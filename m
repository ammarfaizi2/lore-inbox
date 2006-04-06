Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWDFPKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWDFPKS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 11:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWDFPKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 11:10:18 -0400
Received: from odin2.bull.net ([129.184.85.11]:49906 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S932178AbWDFPKQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 11:10:16 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Aurelien Degremont <aurelien.degremont@cea.fr>
Subject: Re: PREEMPT_RT : 2.6.16-rt12 and boot : BUG ?
Date: Thu, 6 Apr 2006 17:10:27 +0200
User-Agent: KMail/1.7.1
Cc: Ingo Molnar <mingo@elte.hu>, "" <linux-kernel@vger.kernel.org>
References: <200604061416.00741.Serge.Noiraud@bull.net> <443526B6.6090709@cea.fr>
In-Reply-To: <443526B6.6090709@cea.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604061710.28293.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeudi 6 Avril 2006 16:33, Aurelien Degremont wrote/a écrit :
> Serge Noiraud wrote:
> > I get symbol resolution error when I try to load my scsi modules in the initrd.
> 
> I've got quite the same issue concerning initrd and scsi modules since 
> the change in MPT FUSION drivers which happened in 2.6.10, and that you 
> seem to use also. (No RT code is involved here)
> I tested many different configurations and the only solution I found 
> consist in setting some sleep calls in the 'init' script of the initrd, 
> between each 'insmod' call. Let me know if this change something for you.
I know this. We need to use the mptspi module.
I need to add "--with mptspi" to the mkinitrd command
and that works correctly without the RT patch.
My problem is only with the RT patch.
> 
> ie:
> 
> echo "Loading scsi_mod.ko module"
> insmod /lib/scsi_mod.ko
> sleep 1
> echo "Loading sd_mod.ko module"
> insmod /lib/sd_mod.ko
> sleep 1
> echo "Loading mptbase.ko module"
> insmod /lib/mptbase.ko
> sleep 1
> echo "Loading mptscsih.ko module"
> insmod /lib/mptscsih.ko
> sleep 1
> echo "Loading jbd.ko module"
> insmod /lib/jbd.ko
> sleep 1
> echo "Loading ext3.ko module"
> insmod /lib/ext3.ko
> sleep 1
> 
> 

-- 
Serge Noiraud
