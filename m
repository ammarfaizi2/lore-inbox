Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSKMOSS>; Wed, 13 Nov 2002 09:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSKMOSS>; Wed, 13 Nov 2002 09:18:18 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:42665 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261663AbSKMOSR>; Wed, 13 Nov 2002 09:18:17 -0500
Subject: Re: Kill obsolete and  unused suspend/resume code from IDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@redhat.com
In-Reply-To: <20021113141353.GI10168@atrey.karlin.mff.cuni.cz>
References: <20021112175154.GA6881@elf.ucw.cz>
	<1037126927.9383.5.camel@irongate.swansea.linux.org.uk> 
	<20021113141353.GI10168@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 14:50:35 +0000
Message-Id: <1037199035.11996.75.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-13 at 14:13, Pavel Machek wrote:
> I noticed you are not playing any tricks with inserting requests to
> queues... This is basically what I was doing, so I like it.
> 
> Is sc1200_spindown_drive really sc1200 specific? Is there some problem
> with doing suspend at ide.c layer, and resume (which is controller
> specific) in each driver?
> 
> ...Ugh. You are doing it as pci device, not as generic device. I
> believe you should use sysfs directly.
> 
> Anyway I can live with this, and its way better than whats in there
> just now.

If you think doing it in sysfs is the right way, then move it to sysfs.
The drive spindown is going to end up on the end of the comamnd queue
anyway. Right now we don't have any controller specific power
management, but for some controllers there is power management that we
can do when sleeping (pci D3, turning off buffers etc)

Alan

