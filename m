Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267469AbTBIXJb>; Sun, 9 Feb 2003 18:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267470AbTBIXJb>; Sun, 9 Feb 2003 18:09:31 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:61570 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267469AbTBIXJa>; Sun, 9 Feb 2003 18:09:30 -0500
Message-ID: <3E46E1D6.20709@blue-labs.org>
Date: Sun, 09 Feb 2003 15:18:46 -0800
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030125
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Current NFS issues (2.5.59)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok.  Here goes.  I have two servers that NFS mount from each other and 
provide.

Server 1 exports A, B, and C to server 2.  Server 2 exports D and E back 
to server 1 and exports F and G to two other clients.  Each of these 
(A-G) are distinctly different filesystem paths and not part of each other.

1. If server 1 is restarted, server 2 will invalidate (make all 'df' 
values '1') F and G.  This requires an 'exportfs -vra' or similar on 
server 2 to fix the client 'df' values.  The client doesn't need to do 
anything.

2. Repeated nfs system stops and starts (/etc/init.d/nfs restart) will 
eventually cause a kernel panic on server 2 (haven't tested on server 
1).   The number of restarts is variable.

3. Mount point F (/home/david) infrequently loops.  ls -la /home/david 
will loop forever until all client memory is exhausted and the kernel 
kills it via OOM.  ls -la /home/david/somefile or /home/david/somedir/ 
works just fine as well as any sub directory under /home/david.  
Restarts of both systems refuse to fix things.

4. Mounts infrequently get "permission denied" messages on the client 
with a " rpc.mountd: getfh failed: Operation not permitted" message on 
the server.  This is fixable by restarting the nfs system on the server.


Server1 is UNI, server 2 is SMP.  All servers and clients are stock 
2.5.59[1].  NFS is running on top of Reiserfs filesystems on all client 
and server machines.

I'll be happy to apply test patches to either clients or servers.

David

[1] One client is 2.5.56 but it rarely accesses the NFS mount unlike the 
other machines which use them constantly


