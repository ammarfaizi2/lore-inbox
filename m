Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWCCTXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWCCTXI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 14:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWCCTXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 14:23:08 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:16396 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751500AbWCCTXH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 14:23:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.64.0603031343270.15776@light.int.webcon.net>
x-originalarrivaltime: 03 Mar 2006 19:23:05.0569 (UTC) FILETIME=[E58CC510:01C63EF7]
Content-class: urn:content-classes:message
Subject: Re: Setkeycodes w/ keycode >= 0x100 ?
Date: Fri, 3 Mar 2006 14:23:05 -0500
Message-ID: <Pine.LNX.4.61.0603031418530.4130@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Setkeycodes w/ keycode >= 0x100 ?
Thread-Index: AcY+9+WUObDb9yZiQhaawpbgjWzmgw==
References: <Pine.LNX.4.64.0603031241130.15776@light.int.webcon.net> <Pine.LNX.4.61.0603031322410.18198@chaos.analogic.com> <Pine.LNX.4.64.0603031343270.15776@light.int.webcon.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ian E. Morgan" <imorgan@webcon.ca>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 3 Mar 2006, Ian E. Morgan wrote:

> On Fri, 3 Mar 2006, linux-os (Dick Johnson) wrote:
>
>>
>> On Fri, 3 Mar 2006, Ian E. Morgan wrote:
>>
>>> Since my HP notebook has some unrecognized keys, I have to use setkeycodes to
>>> make the kernel recognise them. However, many of the basic (<=255) KEY's from
>>> input.h are not suitable, but newer ones (>=0x100) woule be perfect.
>>>
>>> Any idea how to map scancodes to keycodes >=0x100 when setkeycodes won't
>>> accept hex input nor anything greater than 255?
>>>
>>> Regards,
>>> Ian Morgan
>>
>> The keyboard controller generates scan-codes from 0 to 255. It reads the
>> scan-code information from a byte-wide port (so-called PORT_A in the
>> PC/AT), so it can't be any larger than a byte. The controller provides a
>> code when the key is pressed and another code when the key is released.
>> The only difference between these codes is a single bit. This limits the
>> number of possible different scan codes to 127.
>>
>> The scan-codes are translated, based upon the Caps Lock, the Ctrl key, the
>> Alt key, and the Shift key so, in principle, you could have almost 4 times
>> as many keyboard symbols as scan-codes. However, you would have to rewrite
>> a lot of keyboard code to take advantage of this.
>
> Perhaps my question was unclear. Here is an example of what I do now:
>
> 	#KEY_COFFEE
> 	setkeycodes e00a 152
>
> This works, but is an illogical arbitrary assignment. I want to do this:
>
> 	#KEY_POWER2
> 	setkeycodes e00a 356
>
> (or some other such thing with a keycode >256). But it fails with:
>
> KDSETKEYCODE: Invalid argument
> failed to set scancode 8a to keycode 356
>
> In drivers/char/keyboard.c, there are three cases in which it can return
> -EINVAL, but I can't see obviously which one is being hit.
>
> Is the answer simply that we cannot bind scancodes to keycodes greater than
> 256? If so, then why are there newer KEY's defined in input.h >256, and how does
> one ever use them?
>
> Regards,
> Ian Morgan
>
> --
> -------------------------------------------------------------------
> Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
> imorgan at webcon dot ca       PGP: #2DA40D07       www.webcon.ca
>    *  Customized Linux Network Solutions for your Business  *
> -------------------------------------------------------------------
>

Well the input.h in the distribution I use, has the highest key-code
as KEY_UNKNOWN and that is number 200. Perhaps you are trying to
use BTN_0 through BTN_N as key codes? Or perhaps there is some
unfinished business in your version of headers?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.47 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
