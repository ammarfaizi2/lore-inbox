Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVJFXGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVJFXGH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVJFXGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:06:07 -0400
Received: from styx.suse.cz ([82.119.242.94]:49640 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751128AbVJFXGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:06:05 -0400
Date: Fri, 7 Oct 2005 01:05:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@vrfy.org>,
       Hannes Reinecke <hare@suse.de>
Subject: Re: [patch 08/28] Input: prepare to sysfs integration
Message-ID: <20051006230513.GB6981@midnight.suse.cz>
References: <20050915070131.813650000.dtor_core@ameritech.net> <20050915070302.813567000.dtor_core@ameritech.net> <20051005220316.GA2932@suse.de> <d120d5000510051517k28bbb1f9v3c7ec7448608926@mail.gmail.com> <20051005225504.GA3566@suse.de> <d120d5000510061046y7d36de9cseccbbbd18529678@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000510061046y7d36de9cseccbbbd18529678@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 12:46:59PM -0500, Dmitry Torokhov wrote:
> On 10/5/05, Greg KH <gregkh@suse.de> wrote:
> > On Wed, Oct 05, 2005 at 05:17:00PM -0500, Dmitry Torokhov wrote:
> >
> > > The reason is that I want to change input_allocate_device to take
> > > bitmap of supported events. This way I could allocate ABS tables
> > > dynamically at the same time I allocate input_dev itself and it will
> > > simplify error handling logic in drivers and it will save I think 1260
> > > bytes per input_dev structure which is nice. And I don't want to go
> > > through all subsystems yet again soI want to fold into my input
> > > dynalloc patch...
> >
> > That sounds good.
> >
> 
> Well, I tried implementing the proposal above and interface came out
> pretty awkward to use. My next option is to move abs table into
> "->private" structure, much like keytable was moved, or (for HID-like
> devices) allocate it when actually needed and adjust individual
> drivers. So I guess the patches that you have right now are good after
> all.
 
The problem is that the ->abs tables are accessed in the input core and
in the handlers, too, which means they have to share the lifetime rules
with the input_dev struct itself.

That means we probably have a problem with the drivers deallocating the
keytable, while the device still exists, because there is a reference to
it from say sysfs, and keyboard.c tries to access the keytable because
of an ioctl.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
