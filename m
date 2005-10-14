Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVJNRqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVJNRqK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 13:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVJNRqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 13:46:10 -0400
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:27067 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S1750816AbVJNRqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 13:46:08 -0400
To: Greg KH <greg@kroah.com>
Cc: Chris Wright <chrisw@osdl.org>, kernel-stuff@comcast.net,
       stable@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [stable] Re: [PATCH] Re: bug in handling of highspeed usb HID
 devices
References: <101320051953.12930.434EBB460007F30B0000328222007589429D0E050B9A9D0E99@comcast.net>
	<20051013212518.GY5856@shell0.pdx.osdl.net>
	<20051014171326.GA16496@kroah.com>
From: Christian Krause <Christian.Krause@informatik.tu-chemnitz.de>
Date: Fri, 14 Oct 2005 19:46:02 +0200
In-Reply-To: <20051014171326.GA16496@kroah.com> (Greg KH's message of "Fri,
 14 Oct 2005 10:13:26 -0700")
Message-ID: <m37jcg3sbp.fsf@gondor.middle-earth.priv>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Score: 0.0 (/)
X-Spam-Report: --- Start der SpamAssassin 3.1.0 Textanalyse (0.0 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: a37c3661e0372786d6c154dc38711565
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2005 10:13:26 -0700, Greg KH wrote:

> On Thu, Oct 13, 2005 at 02:25:18PM -0700, Chris Wright wrote:
>> * kernel-stuff@comcast.net (kernel-stuff@comcast.net) wrote:
>> > This seems to be -stable material since it's a clear cut bug with bad
>> > consequences. 
>> > 
>> > Chris Wright - is the below patch acceptable for -stable?

> Also, I don't think this should go into -stable, as there are no
> high-speed HID devices available right now, so it really isn't affecting
> anyone :)

No, that's no correct. There are such devices:

Newer KVM-over-IP appliances, like the Avocent's DSR2030 emulates
keyboard, mouse and a mass storage device over USB. I've tested this
specific device with linux and the USB transfers are Highspeed and the
USB device has one interface which is HID. So there are Highspeed USB
devices out there. 

With all respect, but I don't really understand why this is important.
The linux kernel clearly violates the USB specification. The calculation of
the real polling interval for interrupt endpoints is
i = 2^(bInterval-1) (according to USB 2.0 spec, chapter 9.6.6) and _not_
i = 2^((2^(bInterval-1))-1) as it is calculated in linux.
This is clearly a bug in linux and should be fixed.


Changing this has _no_ impact on other devices than Highspeed HID devices
and only this patch allows them to work. And there are such devices. At
least Avocent's DSR2030.


Best regards,
Christian
