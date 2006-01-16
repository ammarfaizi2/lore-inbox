Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWAPXIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWAPXIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 18:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWAPXIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 18:08:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15443 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751201AbWAPXIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 18:08:12 -0500
Date: Tue, 17 Jan 2006 00:10:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Erik Mouw <erik@harddisk-recovery.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jgarzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Message-ID: <20060116231005.GV3945@suse.de>
References: <20060113224252.38d8890f.rdunlap@xenotime.net> <20060116115607.GA18307@harddisk-recovery.nl> <20060116140713.GB18307@harddisk-recovery.com> <20060116224626.GS3945@suse.de> <1137452436.15553.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137452436.15553.93.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16 2006, Alan Cox wrote:
> On Llu, 2006-01-16 at 23:46 +0100, Jens Axboe wrote:
> > > If you really need this enabled to be able to use suspend/resume at
> > > all, you could add a line like:
> > > 
> > >   It's safe to say Y. If you say N, you might get serious disk
> > >   corruption when you suspend your machine.
> > 
> > That's simply not true. If you say N (if you could), you could risk
> > having a non-responsive disk after resume. However, it would have been
> > synced a suspend time so you wont corrupt anything.
> 
> If you do not execute the ACPI taskfiles for the device and you are
> doing an ACPI suspend you are in completely undefined space. Whether it
> eats your disk or not is a question of probabilities only. Yes its
> unlikely but you are in undefined space so "won't corrupt anything"
> indicates an inappropriate level of certainty.

Sorry, but I think that is FUD. The disk better well be in a synced and
idle state when you power it down, regardless of how you do it. It may
refuse to talk to you after resuming, if that by some weird strike of
lightning causes corruption then you are really unlucky. It definitely
doesn't warrant a nasty warning which, as pointed out by someone else,
isn't even visible as the config selects itself.

> Fortunately it is better than the old PATA layer where as far as I can
> tell if the BIOS resume restores the BIOS HPA setup you may actually end
> up doing more damage by running ACPI taskfiles as we don't appear to
> restore enough drive state.

That is indeed a nasty bug, I have a pending fix for that. It's a pretty
easy fix, just introduce a another resume step that issues the hpa
reinit like we do on boot.

-- 
Jens Axboe

