Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWAWVAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWAWVAt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWAWVAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:00:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60682 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030185AbWAWVAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:00:48 -0500
Date: Mon, 23 Jan 2006 22:02:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Nate Diller <nate.diller@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com, seelam@cs.utep.edu,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2][RESEND] Default iosched fixes (was: Fall back io scheduler for 2.6.15?)
Message-ID: <20060123210221.GY12773@suse.de>
References: <5c49b0ed0601191604p4fa53404r783b3a703e922b13@mail.gmail.com> <20060120081145.GD4213@suse.de> <5c49b0ed0601201517h3126ac8dp931bab93a85bf9c5@mail.gmail.com> <20060121114841.GT13429@suse.de> <5c49b0ed0601231150i39e678f3s9dd99c308ffb5157@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c49b0ed0601231150i39e678f3s9dd99c308ffb5157@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23 2006, Nate Diller wrote:
> On 1/21/06, Jens Axboe <axboe@suse.de> wrote:
> > On Fri, Jan 20 2006, Nate Diller wrote:
> > > My previous default iosched patch did a poor job dealing with the
> > > 'elevator=' boot-time option.  The old behavior falls back to the
> > > compiled-in default if the requested one is not registered at boot
> > > time.  This patch dynamically evaluates which default
> > > to use, and emits a suitable error message when the requested scheduler
> > > is not available.  It also does the 'as' -> 'anticipatory' conversion
> > > before elevator registration, which along with a modified registration
> > > function, allows it to correctly indicate which default scheduler is
> > > in use.
> >
> > I'm a little confused by your description - what problem does this patch
> > actually solve? We already fall back to the default, and we already do
> > the "as" conversion. It does seem to cleanup the code, just curious
> > since your description seems to promise a little more than what it
> > actually adds.
> 
> It makes the ' (default)' printk that happens at elevator registration
> time behave (more) correctly.  My original patch rather ignored that
> segment of code.  The current behavior is to only print ' (default)'
> when one was specified at boot time, and not if 'as' was requested
> either, since it doesn't understand the 'as -> anticipatory'
> conversion.  Now, it will display correctly the one selected at
> compile-time, if none was specified at boot, and when the boot-time
> option was 'as'.
> 
> It also handles modular defaults better; although they cannot be
> specified in kconfig, a default requested at boot-time will now still
> work, even if it's a module.  When the boot-time requested scheduler
> is not loaded, it will fall back to the compiled-in default; when it
> is, it gets used.

Ok, thanks for the (better) explanation. I'll add your patch for
inclusion, thanks.

-- 
Jens Axboe

