Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbVJLVmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVJLVmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 17:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVJLVmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 17:42:21 -0400
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:50124 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S932459AbVJLVmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 17:42:20 -0400
To: kernel-stuff@comcast.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in handling of highspeed usb HID devices
References: <101220052110.3094.434D7BDD0001F67000000C1622007621949D0E050B9A9D0E99@comcast.net>
From: Christian Krause <chkr@plauener.de>
Date: Wed, 12 Oct 2005 23:42:17 +0200
In-Reply-To: <101220052110.3094.434D7BDD0001F67000000C1622007621949D0E050B9A9D0E99@comcast.net> (kernel-stuff@comcast.net's
 message of "Wed, 12 Oct 2005 21:10:53 +0000")
Message-ID: <m3zmpev2di.fsf@gondor.middle-earth.priv>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Score: 0.0 (/)
X-Spam-Report: --- Start der SpamAssassin 3.1.0 Textanalyse (0.0 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: 2da4cb75faf7b3f12212370ffd4cc0ae
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 12 Oct 2005 21:10:53 +0000, kernel-stuff  wrote:
>> Re-calculation in usb_fill_int_urb makes more sense, because it is the
>> most general approach. So it would make sense to remove it from
>> hid-core.c.
>> 

> Patch looks correct to me from a purely logical perspective. (IOW I
> read that file first time :)

> But since interval is passed as a parameter to the usb_fill_int_urb()
> function, I think it is more natural to remove the recalculation from
> usb_fill_int_urb() - If caller passes a parameter and has enough info
> to determine its value, it makes sense for the caller to pass in the
> right value and the callee to just take it as it is.

Yes, but in this case we have to check all callers of usb_fill_int_urb
to do the recalculation. E.g. in input/usbmouse.c
endpoint->bInterval is used directly as parameter to usb_fill_int_urb.

To avoid breaking things (my suggested patch has no impact on any other
usb driver) and to solve the problem shortly, I suggest to
use my patch and do some kind of refactoring later (You are right,
for a clean interface the interval parameter should have the same
meaning independend of the speed).


Best regards,
Christian


