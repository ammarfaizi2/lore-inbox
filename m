Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbTEMOho (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbTEMOhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:37:43 -0400
Received: from uni00du.unity.ncsu.edu ([152.1.13.100]:1155 "EHLO
	uni00du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S261335AbTEMOhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:37:39 -0400
From: jlnance@unity.ncsu.edu
Date: Tue, 13 May 2003 10:50:23 -0400
To: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Cc: gary.nifong@synopsys.com, jlnance@synopsys.com, david.thomas@synopsys.com
Subject: NFS problems with Linux-2.4
Message-ID: <20030513145023.GA10383@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am having some problems with NFS which I suspect may be a bug in the
2.4 kernels.  I can probably come up with a small testcase, but before I do
that I would like to describe the problem and see if it is something that
is susposed to work.  Perhaps I simply do not understand the guarantees
that NFS makes.

The setup is like this.  I have two machines which share an NFS mounted
directory.  The NFS server is a network appliance box.  Machine A
does an fopen/fwrite/fclose to create a file on the NFS filesystem.  It
then sends a message to machine B.  Machine B then attemps to fopen the
file, but fopen fails (as does stat).  If I add code that sleeps for a
couple of seconds and retries the fopen then everything works.

I have seen the problem on both IA64 machines running the kernel 2.4.18
from Red Hats Advanced Server and on x86 machines running Red Hats
2.4.7-10smp kernel.  I have not tried other linux kernels (I am not root),
but I have run the same program under Solaris (sparc) and have never
observed this.

The IA64 and x86 machines were on different networks and using different
network appliance servers.  The IA64 /proc/mounts entry is:

na1:/vol/h1/home /remote/na1h1home nfs rw,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=na1 0 0

and the x86 entry is:

na1-rtp:/vol/vol0/home/jlnance /home/jlnance nfs rw,v3,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=na1-rtp 0 0


If you would like more information, please let me know.

Thanks,

Jim
