Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbUCPPJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbUCPPGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 10:06:51 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:40910 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S262465AbUCPPFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 10:05:46 -0500
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       jgarzik@pobox.com
Subject: Re: [3C509] Fix sysfs leak.
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <200403152147.i2FLl09s002942@delerium.codemonkey.org.uk>
	<wrpad2hf4be.fsf@panther.wild-wind.fr.eu.org>
	<20040316134613.GA15600@redhat.com>
	<wrp3c88g9xu.fsf@panther.wild-wind.fr.eu.org>
	<20040316142951.GA17958@redhat.com>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Tue, 16 Mar 2004 16:05:38 +0100
Message-ID: <wrpwu5kessd.fsf@panther.wild-wind.fr.eu.org>
In-Reply-To: <20040316142951.GA17958@redhat.com> (Dave Jones's message of
 "Tue, 16 Mar 2004 14:29:51 +0000")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dave" == Dave Jones <davej@redhat.com> writes:

Dave,

Dave> The damned bus doesn't even exist. If this is a case that couldn't be
Dave> detected, I'd not be complaining, but this is just nonsense having
Dave> a driver claim that its found an EISA device, when there aren't even
Dave> any EISA slots on the board.

The driver doesn't claim to have found any device. It just registered
to the EISA framework, which you compiled in for a reason.

Unload the driver and the directory will go.

Dave> This happens long after bus initialisation should have already figured
Dave> out that the bus doesn't exist. Even if it was left this late, the
Dave> eisa registration code should be doing a 'oh, I've not even checked
Dave> if I have a bus yet, I'll do it now' before it starts doing completely
Dave> bogus things like checking for devices.

Sure. When EISA bus is hanging off the PCI bus, which haven't been
probed yet ? When the driver registers, the EISA framework may not
have a f*cking clue about where the EISA bus sits, or if it even
exists.

Dave> The way I see it, EISA bus support is completely horked right now.

Feel free to submit a patch. One that works for x86, Alpha, HPPA and
IP22, with EISA connected to PCI, GSC, GIO or CPU bus. It works nicely
enough for me on these platforms.

Regards,

	M.
-- 
Places change, faces change. Life is so very strange.
