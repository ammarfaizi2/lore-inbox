Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbUCXUxg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUCXUxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:53:36 -0500
Received: from clara.xs4all.nl ([194.109.199.28]:64940 "EHLO clara.xs4all.nl")
	by vger.kernel.org with ESMTP id S261847AbUCXUxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:53:33 -0500
Message-ID: <4061F54B.8030002@lunar-linux.org>
Date: Wed, 24 Mar 2004 21:53:31 +0100
From: Auke Kok <sofar@lunar-linux.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040218
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFSv3 client hangs against solaris9 server (2.4.23-25)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


past rtfm, stfw, switching all my linux nodes back to nfsver=2 
explicitly, here's why and how:

I have a solaris9 NFS server exporting home directories and other stuff 
to about 40 linux nodes. RH's 2.4.20-SMP kernel nicely uses nfsver=3 but 
the stock 2.4.23 and 2.4.25 kernels compiled from source do not work 
sufficiently, err correction, they don't work usably at all.

The problem is the nfs clients think the server is unavailable all the 
time, after reverting to 'soft' mounts the machines are usable, but data 
corruption will appear sooner or later anyway, so that's not it.

I know the server is okay since I've tried mounting the nfs filesystems 
with the following options:

nfsvers=3,udp
nfsvers=3,tcp
nfsvers=2,udp

The nodes and the server are connected over GigaBit, there is only a 
single 3com gbit switch in between them. Re-mounting to nfsvers=2 
immediately resolves the issue, but like I said, only compiled kernels 
have the issue.

BTW my test case is a simple ./configure && make in 
/home/sofar/src/ccache-2.3, which is on the nfs-mount. on nfsvers=2 it 
takes 20 seconds to complete, and on v3 about 3 hours timing out all the 
time (possibly forever with hard mounts).

I'm willing to debug the crap out of this since it is driving me nuts, 
if anyone wants to contact me please do so! Using linux for 8 years, 
getting paid as a linux sysadmin, free-time linux distro maintainer... 
and I can't get nfsvers=3 to work !!!! (help!help!)

Auke Kok
