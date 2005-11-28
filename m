Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVK1GcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVK1GcP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 01:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVK1GcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 01:32:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7552 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932067AbVK1GcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 01:32:15 -0500
Date: Mon, 28 Nov 2005 01:32:12 -0500
From: Dave Jones <davej@redhat.com>
To: gboyce <gboyce@badbelly.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE + CPU Scaling problem on Via EPIA systems
Message-ID: <20051128063212.GA18775@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	gboyce <gboyce@badbelly.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0511272350380.17020@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511272350380.17020@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 12:02:32AM -0500, gboyce wrote:
 > Folks,
 > 
 > While attempting to setup a new server using a Via EPIA-M motherboard 
 > (Nehemiah processor), I encountered a problem when I enabled CPU Frequency 
 > scaling via the powernowd daemon.
 > 
 > The system is using software RAID 1 on a pair of IDE drives.  Everything 
 > goes fine until powernowd is enabled.  At that point I get the following 
 > errors:
 > 
 > [4294871.703000] hda: dma_timer_expiry: dma status == 0x20
 > [4294871.703000] hda: DMA timeout retry
 > [4294871.703000] hda: timeout waiting for DMA
 > [4294871.703000] hda: status error: status=0x58 { DriveReady SeekComplete 
 > DataRequest }
 > [4294871.703000]
 > [4294871.703000] ide: failed opcode was: unknown
 > [4294871.703000] hda: drive not ready for command
 > [4294958.589000] hda: dma_timer_expiry: dma status == 0x20
 > [4294958.589000] hda: DMA timeout retry
 > [4294958.589000] hda: timeout waiting for DMA
 > [4294958.589000] hda: status error: status=0x58 { DriveReady SeekComplete 
 > DataRequest }
 > [4294958.589000]
 > [4294958.589000] ide: failed opcode was: unknown
 > [4294958.589000] hda: drive not ready for command
 > 
 > I ran the system for an extended time previously with no problem, but at 
 > this point I did not use powernowd, and I was not using RAID.
 > 
 > The system is running Ubuntu, but I also encountered someone else with the 
 > same problem on an older Via EPIA system and SuSE.  The ubuntu kernel I'm 
 > using is 2.6.12-10-386.
 > 
 > I've attached the full dmesg output as well.
 > 
 > For now I'm just going to turn off cpu scaling.  Someday I'd like to use 
 > it though.  Any suggestions for things I can try?  Or is this perhaps a 
 > known issue of some sort?

On some variants of the VIA C3, we need to quiesce all DMA operations
before we do a speed transition. We currently don't do that.
I do have a patch from someone which adds support in the longhaul
driver to wait for IDE transactions to stop, but to do it cleanly,
we really need some callbacks into the IDE layer.

The longhaul driver right now is pretty much a case of
"if it works for you great, if not, don't use it".

		Dave

