Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWFISBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWFISBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWFISBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:01:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:44233 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030298AbWFISBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:01:43 -0400
Date: Fri, 09 Jun 2006 20:01:42 +0200
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="iso-8859-1"
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20060608205048.113800@gmx.net>
MIME-Version: 1.0
Subject: RFC: dma_mmap_coherent() for powerpc/ppc architecture and ALSA?
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
X-Authenticated: #6097454
X-Flags: 1001
X-GMX-UID: DxjiLIYjTlI8X0ZvKmhrKpFOU2poZdkR
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to adapt Linux for the AmigaOne, which is a G3/G4 PPC desktop system with a non cache coherent northbridge (MAI ArticiaS), a VIA82C686B southbridge and the U-boot firmware. Due to the cache coherency problem I compiled in the CONFIG_NOT_COHERENT_CACHE option (arch/ppc/kernel/dma-mapping.c) in the AmigaOne Linux kernel.

While that fixes the DMA data corruption problem, it causes a kernel oops or a complete system lookup after starting sound playback. With kernel versions =<2.6.14 the oops messages refered to a BUG() entry in mm/rmap.c. Therefore I tried out a newer kernel (2.6.16.15), where the oops refers to the ALSA function snd_pcm_mmap_data_nopage() implemented in pcm_native.c.

Well, after searching a while in some old linux kernel threads, I found this thread here:
http://www.thisishull.net/showthread.php?t=22080&page=3&pp=10

Based on the information in this thread, I came to the conclusion that ALSA simply won't work on non cache coherent architectures (except ARM), because the generic DMA API was never expanded to support the functionality required by ALSA (namely mapping dma pages into user space with dma_mmap_coherent()).

This leads me to the question, if there are any plans to include the dma_mmap_coherent() function (for powerpc/ppc and/or any other platform) in one of the next kernel versions and if an adapation of the ALSA drivers is planned. Or is there a simple way (hack) to fix this problem?

Thanks!

Regards,

Gerhard

-- 
--
-- email : gerhard_pircher -AT- gmx -DOT- net
--

Echte DSL-Flatrate dauerhaft für 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl
