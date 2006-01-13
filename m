Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161572AbWAMVzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161572AbWAMVzp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161574AbWAMVzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:55:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:46985 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161572AbWAMVzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:55:45 -0500
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <200601122312.05210.dtor_core@ameritech.net>
References: <20051225212041.GA6094@hansmi.ch>
	 <1137022900.5138.66.camel@localhost.localdomain>
	 <20060112000830.GB10142@hansmi.ch>
	 <200601122312.05210.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 08:55:19 +1100
Message-Id: <1137189319.4854.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That should be "MODULE_PARM_DESC(pb_fn_mode, ...)". Also, since this is
> for compatibility with ADB, why do we have 3 options? Doesn't ADB have
> only 2?

No, the ADB keyboard can operate in 2 modes that can be set with a PMU
command, I forgot about that in my earlier comments. In one mode, you get
the "special" behaviour by default on the Fx keys and you get Fx when
pressing Fn-Fx, and in the other mode, you get the Fx by default and the
special behaviour when pressing Fn-Fx.

> > +static inline struct hidinput_key_translation *find_translation(
> 
> I thought is was agreed that we'd avoid "inlines" in .c files?

Ah ? I have certainly missed that discussion ...

> > +	struct hidinput_key_translation *table, u16 from)
> > +{
> > +	struct hidinput_key_translation *trans;
> > +
> > +	/* Look for the translation */
> > +	for(trans = table; trans->from && (trans->from != from); trans++);
> > +
> > +	return (trans->from?trans:NULL);
> > +}
> 
> I'd prefer liberal amount of spaces applied here </extreme nitpick mode>

Me too :)

> > +		try_translate = test_bit(usage->code, usbhid_pb_numlock)?1:
> > +				test_bit(LED_NUML, input->led);
> > +		if (try_translate) {
> 
> Isn't this the same as 
> 
> 		if (test_bit(usage->code, usbhid_pb_numlock) || test_bit(LED_NUML, input->led))
> 
> but harder to read?

No. If the first one is 0, the second one will not matter in the first
version, while it will in yours.

Ben.


