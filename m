Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267036AbUBRBJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 20:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267072AbUBRBJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 20:09:23 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:64527 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267036AbUBRBJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 20:09:21 -0500
Date: Wed, 18 Feb 2004 02:06:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@osdl.org>
cc: Adrian Bunk <bunk@fs.tum.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, GCS <gcs@lsc.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, vandrove@vc.cvut.cz
Subject: Re: Linux 2.6.3-rc4
In-Reply-To: <Pine.LNX.4.58.0402171503150.2154@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0402180156160.7851@serv>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
 <20040217184543.GA18495@lsc.hu> <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
 <20040217200545.GP1308@fs.tum.de> <Pine.LNX.4.58.0402171214230.2154@home.osdl.org>
 <20040217225905.GQ1308@fs.tum.de> <Pine.LNX.4.58.0402171503150.2154@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 17 Feb 2004, Linus Torvalds wrote:

> What we actually want to say is something like "select I2C=FB_RADEON",
> which makes the minimal dependency of I2C be the same value as FB_RADEON
> (which is a tristate) rather than FB_RADEON_I2C (boolean).

Actually the same can be done this way either:

config FB_RADEON_I2C
	depends on FB_RADEON && I2C
	select I2C_ALGOBIT if FB_RADEON

to select only I2C_ALGOBIT or:

config FB_RADEON_I2C
	depends on FB_RADEON
	select I2C if FB_RADEON
	select I2C_ALGOBIT if FB_RADEON

to select both.
This adds the expression "FB_RADEON_I2C && FB_RADEON" to the selected
symbol as minimum selection.

bye, Roman
