Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbVJGD6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbVJGD6L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 23:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbVJGD6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 23:58:10 -0400
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:14525 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751366AbVJGD6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 23:58:09 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch 08/28] Input: prepare to sysfs integration
Date: Thu, 6 Oct 2005 22:58:07 -0500
User-Agent: KMail/1.8.2
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@vrfy.org>,
       Hannes Reinecke <hare@suse.de>
References: <20050915070131.813650000.dtor_core@ameritech.net> <d120d5000510061046y7d36de9cseccbbbd18529678@mail.gmail.com> <20051006230513.GB6981@midnight.suse.cz>
In-Reply-To: <20051006230513.GB6981@midnight.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510062258.07793.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 October 2005 18:05, Vojtech Pavlik wrote:
> On Thu, Oct 06, 2005 at 12:46:59PM -0500, Dmitry Torokhov wrote:
> > On 10/5/05, Greg KH <gregkh@suse.de> wrote:
> > > On Wed, Oct 05, 2005 at 05:17:00PM -0500, Dmitry Torokhov wrote:
> > >
> > > > The reason is that I want to change input_allocate_device to take
> > > > bitmap of supported events. This way I could allocate ABS tables
> > > > dynamically at the same time I allocate input_dev itself and it will
> > > > simplify error handling logic in drivers and it will save I think 1260
> > > > bytes per input_dev structure which is nice. And I don't want to go
> > > > through all subsystems yet again soI want to fold into my input
> > > > dynalloc patch...
> > >
> > > That sounds good.
> > >
> > 
> > Well, I tried implementing the proposal above and interface came out
> > pretty awkward to use. My next option is to move abs table into
> > "->private" structure, much like keytable was moved, or (for HID-like
> > devices) allocate it when actually needed and adjust individual
> > drivers. So I guess the patches that you have right now are good after
> > all.
>  
> The problem is that the ->abs tables are accessed in the input core and
> in the handlers, too, which means they have to share the lifetime rules
> with the input_dev struct itself.
>
> That means we probably have a problem with the drivers deallocating the
> keytable, while the device still exists, because there is a reference to
> it from say sysfs, and keyboard.c tries to access the keytable because
> of an ioctl.
> 

Not necessarily, you just need to make sure that you don't try to access
these fields when input_dev is "half-dead". But we have many issues with
locking/lifetime rules in input core so that's just another item that
needs to be considered.

I wanted to get basic sysfs support in and then work on locking...

-- 
Dmitry
