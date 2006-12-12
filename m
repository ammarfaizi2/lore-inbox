Return-Path: <linux-kernel-owner+w=401wt.eu-S1750988AbWLLIas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWLLIas (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 03:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWLLIar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 03:30:47 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:48584 "HELO
	smtp111.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750988AbWLLIar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 03:30:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=fuHUkBb1yJGfHGmyhgKTguQcxvjNCv+0L6RGQ+bOlhbloxFrfIz2cERJzvUSX4ap3MaV97yq5pa/Ni0nZ4bWjqnyaMWTGg1Y3FWrsi5hG8gUpheuBtx2DEexfH1+beeAqj/5ep6MHwMmDS2kFRTeniq1h7IHOyvnTyfdIW/Wv44=  ;
X-YMail-OSG: yCSuuz0VM1mXJEOBX0X4nla2MXzjPMIJSYKTl7z5O_l8SiHouICl2M90uNwfqS2nLGJti8SNCeKmEersUOy3s87t4i1OjjiNCj20Nq14zvQVcxk7vT8uoGoXY1mlFGl_b8fXxhYivlLQgfKvuoJRk7d9gb08hEyi8xSgqW_T8ixft5JVpuUupD6YOYiA
From: David Brownell <david-b@pacbell.net>
To: "Voipio Riku" <Riku.Voipio@movial.fi>
Subject: Re: [patch 2.6.19-git] rts-rs5c372 updates:  more chips, alarm, 12hr mode, etc
Date: Tue, 12 Dec 2006 00:30:42 -0800
User-Agent: KMail/1.7.1
Cc: rtc-linux@googlegroups.com,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Alessandro Zummo" <alessandro.zummo@towertech.it>,
       dan.j.williams@intel.com, i2c@lm-sensors.org
References: <200612081859.42995.david-b@pacbell.net> <200612111155.09435.david-b@pacbell.net> <42003.80.222.56.248.1165875783.squirrel@webmail.movial.fi>
In-Reply-To: <42003.80.222.56.248.1165875783.squirrel@webmail.movial.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612120030.44554.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 December 2006 2:23 pm, Voipio Riku wrote:

> from what I saw, the driver simply passes messages over to the i2c
> controller. It even specifically mentiones that it supports repeated start
> conditions, as needed for read method #1. Comparing to 80219 manual[1], I
> did not spot anything obviously wrong.

I skimmed i2c-ixp3xx too, but have never spent much time with I2C controller
drivers or Intel's fancier XScales.


> >> With your patch, the rtc acts like the chip would completely ignore the
> >> "address" transfer, and starts reading from the last (default) register
> >> anyway. Thus all the regs look shifted by one in the driver.
> 
> > That's quite strange.  The docs on the RTC are quite clear about what's
> > supposed to happen with what I2C messages.  And I'd expect them to be
> > right ... especially since they behaved for me, and the original author
> > of that code!  That makes me suspect that your particular I2C controller
> > driver must not be issuing the protocol requests it should be, at least
> > on your hardware and revision.
> 
> Well at least I'm happy that there is now someone more experienced working
> on this driver. When I tried to get it working I could not find anyone
> with another board to verify if the original and/or my patch works for
> them..

Unfortunately our patches collided.  The original code worked for me
(other than bugs in the trim register).


> > Plus, if I understand things correctly, using mode #3 would break when
> > writing
> 
> I should not. Writing isn't related to reading methods according the
> datasheet[2]. It provides one addressing method for writing, and writing
> works fine our Thecus/Allnet hardware.

I see ... reading more closely "the internal address pointer is set to Fh
when the stop condition is met", namely right after each transaction.  It's
not like other chips with such pointers that I've used (they never reset it).

I don't mind if the "read all the registers" operation uses mode 3.  I'll
have to see if your updated version behaves (albeit without handling 12 hour
time, the alarm, etc) for me.

But I'm still concerned that switching to mode 3 seems to be just working
around a bug in some other driver, and that _other_ bug should be fixed.

- Dave

