Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSFDMEi>; Tue, 4 Jun 2002 08:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314707AbSFDMEh>; Tue, 4 Jun 2002 08:04:37 -0400
Received: from codepoet.org ([166.70.14.212]:52888 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S314548AbSFDMEh>;
	Tue, 4 Jun 2002 08:04:37 -0400
Date: Tue, 4 Jun 2002 06:04:34 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Padraig Brady <padraig@antefacto.com>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Need help tracing regular write activity in 5 s interval
Message-ID: <20020604120434.GA1386@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Padraig Brady <padraig@antefacto.com>,
	Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020602135501.GA2548@merlin.emma.line.org> <3CFCA2B0.4060501@antefacto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jun 04, 2002 at 12:21:20PM +0100, Padraig Brady wrote:
> As an aside, Nautilus (1.0.4) does stuff every 2 seconds
> (checking is there a CD inserted) that causes the disk LED to flash.
> The same action also causes the kernel (2.4.13) to fill up the ring
> buffer with: "VFS: Disk change detected on device ide1(22,0)".

This should fix the symptom...

--- linux/fs/block_dev.c.orig	Tue Jun  4 06:03:44 2002
+++ linux/fs/block_dev.c	Tue Jun  4 06:03:44 2002
@@ -582,8 +582,11 @@
 	if (!bdops->check_media_change(dev))
 		return 0;
 
+	#if 0
+	/* Polling buggy CD-ROM drives can fill the logs.  Make it shutup. */
 	printk(KERN_DEBUG "VFS: Disk change detected on device %s\n",
 		bdevname(dev));
+	#endif
 
 	sb = get_super(dev);
 	if (sb && invalidate_inodes(sb))
 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
