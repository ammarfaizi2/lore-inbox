Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316831AbSFZVBV>; Wed, 26 Jun 2002 17:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316849AbSFZVBU>; Wed, 26 Jun 2002 17:01:20 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:54249 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S316831AbSFZVBT>; Wed, 26 Jun 2002 17:01:19 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH/RFC 2.4.19-rc1] Fix dependancies on keybdev.o
Date: Thu, 27 Jun 2002 06:58:04 +1000
User-Agent: KMail/1.4.5
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20020625160644.GP3489@opus.bloom.county> <200206261236.24247.bhards@bigpond.net.au> <20020626144609.GR3489@opus.bloom.county>
In-Reply-To: <20020626144609.GR3489@opus.bloom.county>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206270658.04695.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2002 00:46, Tom Rini wrote:
> On Wed, Jun 26, 2002 at 12:36:24PM +1000, Brad Hards wrote:
> > 2. Move keyboard handling code to input subsystem
>
> I think that will work out the best.  How's the attached look?  It moves
> drivers/input/Config.in inside of drivers/char/Config.in and then fixes
> arches which had both.  (Lightly tested from xconfig[1] for all arches
> which got changed).
I'm opposed to further junk going into drivers/char. It is already an 
incomprehensible mess of unrelated code.

> > 3. Do wholesale backport of input subsystem from 2.5
>
> Not really an option (and 2.5 has this problem anyhow) since it's so
> invasive, once it's done.
Concur with the invasiveness angle.

Actually, I've got another idea, based on some stuff that I've been working on 
for the ACPI "its not just power management" issue. 

If you need to set something in drivers/input (per your original patch) that 
depends on things that are set in drivers/char (or drivers/usb, anything that 
comes later), then split the Config.in into two sections. One section 
contains the normal Config.in user-selectable options, and a second 
drivers/input/Config-post.in, that is sourced in at the end of 
arch/foo/config.in and contains only automated Config.in dependancies (ie 
define_bool) but no user selectable options.

Does this make sense? If not, I'll try for a patch that shows it later this 
morning.

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
