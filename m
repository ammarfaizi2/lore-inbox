Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264683AbTDYA2v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264684AbTDYA2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 20:28:50 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:23768 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264683AbTDYA2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 20:28:46 -0400
Date: Fri, 25 Apr 2003 01:40:13 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch?] SiS 746 AGP-Support
Message-ID: <20030425004003.GA12614@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>,
	linux-kernel@vger.kernel.org
References: <200304250224.50431.volker.hemmann@heim9.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304250224.50431.volker.hemmann@heim9.tu-clausthal.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I don't know, if the following changes are 'clean' but they give me a working 
 > agpsupport for my SiS 746Fx based mobo.
 > 
 > This (attempt) of a patch is against 2.4.21-rc1:

Might work fine as long as you have an agp2.0 card in the slot, but the
minute you put a 3.0 (read as AGPx8) card in there, things are very
likely to break.

I've not seen the specs for this chipset, but most of the AGP3 chipsets
I've seen have a fallback mode in their register set which gets enabled
as soon as you plug in an AGP2 card. These registers don't get enabled
with an AGP3 card, instead you need to read from different registers,
and in most cases, act completly different to decode aperture sizes etc.

The generic routines in 2.5 *might* work, but are untested on this chipset.
2.4 currently has no AGP3 support at all. Some folks did backport what
I've done in 2.5 a while ago, but I would advise against merging it at
this stage, as there is still work to be done there, including stability
fixes. Right there are a number of possible problems which may include
random memory corruption.

		Dave

