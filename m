Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWCCS6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWCCS6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 13:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWCCS6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 13:58:43 -0500
Received: from guru.webcon.ca ([216.194.67.26]:9136 "EHLO guru.webcon.ca")
	by vger.kernel.org with ESMTP id S1750952AbWCCS6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 13:58:43 -0500
Date: Fri, 3 Mar 2006 13:58:40 -0500 (EST)
From: "Ian E. Morgan" <imorgan@webcon.ca>
X-X-Sender: imorgan@light.int.webcon.net
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Setkeycodes w/ keycode >= 0x100 ?
In-Reply-To: <Pine.LNX.4.61.0603031322410.18198@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0603031343270.15776@light.int.webcon.net>
References: <Pine.LNX.4.64.0603031241130.15776@light.int.webcon.net>
 <Pine.LNX.4.61.0603031322410.18198@chaos.analogic.com>
Organization: Webcon, Inc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Assp-Spam-Prob: 0.00000
X-Assp-Whitelisted: Yes
X-Assp-Envelope-From: imorgan@webcon.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2006, linux-os (Dick Johnson) wrote:

> 
> On Fri, 3 Mar 2006, Ian E. Morgan wrote:
> 
> > Since my HP notebook has some unrecognized keys, I have to use setkeycodes to
> > make the kernel recognise them. However, many of the basic (<=255) KEY's from
> > input.h are not suitable, but newer ones (>=0x100) woule be perfect.
> >
> > Any idea how to map scancodes to keycodes >=0x100 when setkeycodes won't
> > accept hex input nor anything greater than 255?
> >
> > Regards,
> > Ian Morgan
> 
> The keyboard controller generates scan-codes from 0 to 255. It reads the
> scan-code information from a byte-wide port (so-called PORT_A in the
> PC/AT), so it can't be any larger than a byte. The controller provides a
> code when the key is pressed and another code when the key is released.
> The only difference between these codes is a single bit. This limits the
> number of possible different scan codes to 127.
> 
> The scan-codes are translated, based upon the Caps Lock, the Ctrl key, the
> Alt key, and the Shift key so, in principle, you could have almost 4 times
> as many keyboard symbols as scan-codes. However, you would have to rewrite
> a lot of keyboard code to take advantage of this.

Perhaps my question was unclear. Here is an example of what I do now:

	#KEY_COFFEE
	setkeycodes e00a 152

This works, but is an illogical arbitrary assignment. I want to do this:

	#KEY_POWER2
	setkeycodes e00a 356

(or some other such thing with a keycode >256). But it fails with:

KDSETKEYCODE: Invalid argument
failed to set scancode 8a to keycode 356

In drivers/char/keyboard.c, there are three cases in which it can return
-EINVAL, but I can't see obviously which one is being hit.

Is the answer simply that we cannot bind scancodes to keycodes greater than
256? If so, then why are there newer KEY's defined in input.h >256, and how does
one ever use them?

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan at webcon dot ca       PGP: #2DA40D07       www.webcon.ca
    *  Customized Linux Network Solutions for your Business  *
-------------------------------------------------------------------
