Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTLTVqa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 16:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTLTVqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 16:46:30 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:65410
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261563AbTLTVq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 16:46:28 -0500
Date: Sat, 20 Dec 2003 16:45:41 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Alexander Poquet <atp@csbd.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 fails to complete boot - Sony VAIO laptop
In-Reply-To: <20031219101627.GI31393@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0312190706060.2147@montezuma.fsmlabs.com>
References: <20031219095849.A646A1E030CA3@csbd.org> <20031219101627.GI31393@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Dec 2003, William Lee Irwin III wrote:

> At some point in the past, I wrote:
> WLI3> Could you post your lilo.conf and/or grub.conf and /etc/fstab?
>
> On Fri, Dec 19, 2003 at 10:07:55AM +0000, Alexander Poquet wrote:
> > Certainly.  Thanks a lot for the reply.
>
> Okay, nothing matching other bugreports turned up here. I might have
> to ask you to try to capture some log information. Do you have a null
> modem cable or a null modem adapter and serial cable, and another box
> to hook that up to?

Alexander, does the blinking look like it may have something to do with
setting screen modes? Could you try the following patch?

Index: linux-2.6.0/arch/i386/boot/video.S
===================================================================
RCS file: /build/cvsroot/linux-2.6.0/arch/i386/boot/video.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 video.S
--- linux-2.6.0/arch/i386/boot/video.S	18 Dec 2003 07:16:25 -0000	1.1.1.1
+++ linux-2.6.0/arch/i386/boot/video.S	20 Dec 2003 21:45:10 -0000
@@ -133,7 +133,7 @@ vid1:
 #ifdef CONFIG_VIDEO_RETAIN
 	call	restore_screen			# Restore screen contents
 #endif /* CONFIG_VIDEO_RETAIN */
-	call	store_edid
+#	call	store_edid
 #endif /* CONFIG_VIDEO_SELECT */
 	call	mode_params			# Store mode parameters
 	popw	%ds				# Restore original DS
