Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVGFMKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVGFMKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 08:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVGFMKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 08:10:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8071 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262257AbVGFJMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 05:12:42 -0400
Date: Wed, 6 Jul 2005 11:11:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ast@domdv.de
Subject: Re: [swsusp] encrypt suspend data for easy wiping
Message-ID: <20050706091104.GB1301@elf.ucw.cz>
References: <20050703213519.GA6750@elf.ucw.cz> <20050706020251.2ba175cc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706020251.2ba175cc.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > To prevent data gathering from swap after resume you can encrypt the
> > suspend image with a temporary key that is deleted on resume. Note
> > that the temporary key is stored unencrypted on disk while the system
> > is suspended... still it means that saved data are wiped from disk
> > during resume by simply overwritting the key.
> 
> hm, how useful is that?  swap can still contain sensitive userspace
> stuff.

At least userspace has chance to mark *really* sensitive stuff as
unswappable. Unfortunately that does not work against swsusp :-(.

[BTW... I was thinking about just generating random key on swapon, and
using it, so that data in swap is garbage after reboot; no userspace
changes needed. What do you think?]

> Are there any plans to allow the user to type the key in on resume?

Plans... ;-).

> > +Encrypted suspend image:
> > +------------------------
> > +If you want to store your suspend image encrypted with a temporary
> > +key to prevent data gathering after resume you must compile
> > +crypto and the aes algorithm into the kernel - modules won't work
> > +as they cannot be loaded at resume time.
> 
> Why not just `select' the needed symbols in Kconfig?  It makes
> configuration much easier for the user.
> 
> > +	if(!*tfm) {
> > +	if(sizeof(key) < crypto_tfm_alg_min_keysize(*tfm)) {
> > +	if (mode) {
> 
> Coding style nit: please use a single space after `if'.
> 
> > +fail:	crypto_free_tfm(*tfm);
> > +out:	return error;
> 
> We conventionally insert a newline directly after labels.
> 
> > +#ifdef CONFIG_SWSUSP_ENCRYPT
> > +#ifdef CONFIG_SWSUSP_ENCRYPT
> > +#ifdef CONFIG_SWSUSP_ENCRYPT
> > +#ifdef CONFIG_SWSUSP_ENCRYPT
> > +#ifdef CONFIG_SWSUSP_ENCRYPT
> > +#ifdef CONFIG_SWSUSP_ENCRYPT
> > +#ifdef CONFIG_SWSUSP_ENCRYPT
> > +#ifdef CONFIG_SWSUSP_ENCRYPT
> > +#ifdef CONFIG_SWSUSP_ENCRYPT
> 
> err, no.  Please find a way to reduce the ifdeffery.

Andreas, these are yours.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
