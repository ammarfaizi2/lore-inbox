Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbRFKBpg>; Sun, 10 Jun 2001 21:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263344AbRFKBp0>; Sun, 10 Jun 2001 21:45:26 -0400
Received: from shogun1.csun.edu ([130.166.11.14]:23566 "EHLO shogun1.csun.edu")
	by vger.kernel.org with ESMTP id <S263333AbRFKBpP>;
	Sun, 10 Jun 2001 21:45:15 -0400
Date: Sun, 10 Jun 2001 18:44:56 -0700 (PDT)
From: Lucca <lucca@shogun1.csun.edu>
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: process table fills with DN state when nfs connection is lost
In-Reply-To: <20010610223428.A27096@grobbebol.xs4all.nl>
Message-ID: <Pine.LNX.4.21.0106101841010.1555-100000@shogun1.csun.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>what happens is this : the other system reboots into windows o the nfs
>connection gets lost. however, what happens is that now the process
>table starts to fill with cron initiated mrtg calls and all get the DN
>state in ps aux.

The default is to do a hard-mount of NFS shares.  Hardmounts hang when the
server disappears.  This is... Generally what you will want.  adding the
intr option should allow the processes to be killed (but I have not tried
this)

>now, the load goes up and when I came home it was at 144 already. I
>stopped cron, unable to kill off the mrtg calls. I then re-established the
>nfs connection by rebooting the windows back to linux; I then could umount
>the nfs shares and guess what happened -- all DN processes went ayway and
>the system load back to normal.

Count yourself lucky.  I was foolishly serving webpages from an NFS
mount.  Fortunately apache has limits.  Seeing a loadavg in the the hundreds
is... disturbing.

The loadavg does this because processes in the D state get counted wether
they are doing anything or not.  I don't know if this is correct or not, but
most unicies seem to do this.

>it seems that some things block in the kernel when the nfs stuff is
>failed. is this right ? is my setup incorrect or what ?

Not incorrect, but you might experiment with soft mounts, which will rapidly
timeout and die with io-errors rather than hanging.

lucca@shogun1.csun.edu

