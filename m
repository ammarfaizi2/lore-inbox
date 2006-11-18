Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753849AbWKREEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbWKREEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 23:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755826AbWKREEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 23:04:13 -0500
Received: from ns2.g-housing.de ([81.169.133.75]:25217 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1753849AbWKREEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 23:04:12 -0500
Date: Sat, 18 Nov 2006 04:04:03 +0000 (GMT)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@sheep.housecafe.de
To: neilb@cse.unsw.edu.au
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.19-rc6 - NFSD working again
In-Reply-To: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0611180342560.10979@sheep.housecafe.de>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just wanted to report a 'it works again' for rc6: after encountering 
the very same problems with -rc3 Jeff Garzik described in [0], I 
upgraded to -rc5 and applied the proposed[1] patch[2].
Now, the knfsd behaved a bit better (nfs-mounted /home, X11 
applications created thousands of empty 'configuration'-files),
however 'mkdir' and 'touch' still failed too often:

  $ mkdir /mnt/nfs/compile-farm/foo
  mkdir: /mnt/nfs/compile-farm/foo: Operation not permitted
  $ mkdir /mnt/nfs/compile-farm/foo
  mkdir: /mnt/nfs/compile-farm/foo: File exists

...and things like that.

With -rc6 this seems to be gone. However, I noticed this message in the 
server's (192.168.10.10) syslog:

nfs4_cb: server 127.0.1.1/192.168.10.10 AUTH_UNIX 0 not responding, timed out
nfs4_cb: server 127.0.1.1/192.168.10.10 AUTH_UNIX 0 not responding, timed out

The NFS server is running on 0.0.0.0:2049, what does this mean?
The message occurs once in a while, not sure what triggers it, found 
not much in the archives...

Thanks,
Christian.

[0] http://uwsg.iu.edu/hypermail/linux/kernel/0611.0/1418.html
[1] http://uwsg.iu.edu/hypermail/linux/kernel/0611.0/1491.html
[2] http://www.citi.umich.edu/projects/nfsv4/linux/kernel-patches/2.6.19-rc3-2/linux-2.6.19-rc3-CITI_NFS4_ALL-2.diff
-- 
BOFH excuse #106:

The electrician didn't know what the yellow cable was so he yanked the ethernet out.
