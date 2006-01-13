Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422997AbWAMWFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422997AbWAMWFL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422998AbWAMWFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:05:11 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:14229 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422997AbWAMWFJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:05:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PLsvxIqB2+kLF0bIomDT1/XkBaS1mc79kGGjUNtzHjYxxxp56UQtukBDeEUHr30yd7T1KrsKdhpbBzDoOKQDXgkPGO7P+KLBTMqYGiMyJS1wO+VTmXwT4rK7/Z/7zF7mWQ9lWERz4F6vy9u1NUfonNMsLECdJC3w3uTAAvktRAY=
Message-ID: <d120d5000601131405w4e20e37fna17767624a4ebf6@mail.gmail.com>
Date: Fri, 13 Jan 2006 17:05:08 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <1137189319.4854.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051225212041.GA6094@hansmi.ch>
	 <1137022900.5138.66.camel@localhost.localdomain>
	 <20060112000830.GB10142@hansmi.ch>
	 <200601122312.05210.dtor_core@ameritech.net>
	 <1137189319.4854.12.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > That should be "MODULE_PARM_DESC(pb_fn_mode, ...)". Also, since this is
> > for compatibility with ADB, why do we have 3 options? Doesn't ADB have
> > only 2?
>
> No, the ADB keyboard can operate in 2 modes that can be set with a PMU
> command, I forgot about that in my earlier comments. In one mode, you get
> the "special" behaviour by default on the Fx keys and you get Fx when
> pressing Fn-Fx, and in the other mode, you get the Fx by default and the
> special behaviour when pressing Fn-Fx.
>

Right, so do we need "no translation, fnkeyfirst and fnkeylast" option
or just "fnkeyfirst and fnkeyast"?

> > > +static inline struct hidinput_key_translation *find_translation(
> >
> > I thought is was agreed that we'd avoid "inlines" in .c files?
>
> Ah ? I have certainly missed that discussion ...

Newer GCCs, unit-at-a-time, etc. etc. - teher was pretty long
discussion about letting GCC decide on inlining.

>
> > > +   struct hidinput_key_translation *table, u16 from)
> > > +{
> > > +   struct hidinput_key_translation *trans;
> > > +
> > > +   /* Look for the translation */
> > > +   for(trans = table; trans->from && (trans->from != from); trans++);
> > > +
> > > +   return (trans->from?trans:NULL);
> > > +}
> >
> > I'd prefer liberal amount of spaces applied here </extreme nitpick mode>
>
> Me too :)
>
> > > +           try_translate = test_bit(usage->code, usbhid_pb_numlock)?1:
> > > +                           test_bit(LED_NUML, input->led);
> > > +           if (try_translate) {
> >
> > Isn't this the same as
> >
> >               if (test_bit(usage->code, usbhid_pb_numlock) || test_bit(LED_NUML, input->led))
> >
> > but harder to read?
>
> No. If the first one is 0, the second one will not matter in the first
> version, while it will in yours.
>

Huh? You mean 1, right?

    try_translate = 0;
    if (test_bit(usage->code, usbhid_pb_numlock))
         try_translate = 1;
    else if (test_bit(LED_NUML, input->led))
         try_translate = 1;
    else







> Ben.
>
>
>


--
Dmitry
