Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVDDW4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVDDW4s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVDDWzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:55:55 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:31948 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261267AbVDDWus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:50:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ObASaruCYriLog94H8h+rddXN8+1PmbYFHmBVtjD7iaJd0oWfMXlL4ETViwGzS2/680uJKmgPt+ZABO8eCngj23w7z3EnB9hgT2h7PtS4pnHuxZpHM7xtaEery+rtoiNODo+QVYlXVHYuk0ZnLi07qqF48KnNcGpG8e7SBBT0YY=
Message-ID: <d120d50005040415506cd87287@mail.gmail.com>
Date: Mon, 4 Apr 2005 17:50:47 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jaco Kroon <jaco@kroon.co.za>
Subject: Re: i8042 controller on Toshiba Satellite P10 notebook - patch
Cc: linux-kernel@vger.kernel.org, Sebastian Piechocki <sebekpi@poczta.onet.pl>
In-Reply-To: <4251B6E2.3010506@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <425166F9.1040800@kroon.co.za>
	 <d120d5000504040954354fb3fa@mail.gmail.com>
	 <42517442.20602@kroon.co.za>
	 <d120d500050404110374fe9deb@mail.gmail.com>
	 <4251A515.8040802@kroon.co.za>
	 <d120d500050404140253a77ab8@mail.gmail.com>
	 <4251B6E2.3010506@kroon.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 4, 2005 4:51 PM, Jaco Kroon <jaco@kroon.co.za> wrote:
> Dmitry Torokhov wrote:
> > On Apr 4, 2005 3:35 PM, Jaco Kroon <jaco@kroon.co.za> wrote:
> >
> >>As for loading the modules i8042, atkbd and psmouse (in that order):
> >>black void of death.
> >>
> > Hmm.. remind me, if you boot with usb-handoff does it switch the i8042
> > into active multiplexing mode (you get 4 AUX serio ports)?
> >
> Checking my logs it actually looks like usb-handoff did get 4 ports.
> With my patch, however, I only get:
> 
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 AUX port at 0x60,0x64 irq 1
> 

Ok, try booting with "usb-handoff i8042.nomux". If that cures
death-on-reboot problem then Vojtech already has a patch in
2.6.12-rc1:

http://linux.bkbits.net:8080/linux-2.5/cset@41f8e2d7j4JtjbrlrI5eYgQQ86yDhg

> >From the code I understand that this means that i8042_nomux != 0 or
> i8042_check_mux() return != 0.  So I assume that with the patch that
> check_mux returns non-zero (and reversed logic means that 0 implies the
> check succeeds, ie, it _fails_ with my patch installed).  I don't know
> which is the prefered mode of operation though (I guess MUX with 4 AUX
> ports?).
> 

Yes, with 4 ports your external mouse is independent from the touhpad.
When you have only 1 port you can't use touchpad's extended mode
together with an external mouse.

> With my patch I do get the ALPS support though - something which I
> didn't get with usb-handoff, nor with acpi=off, nor with simply hacking
> out the AUX_LOOP and AUX_TEST tests and just assuming the hardware is
> there (I saw ALPS yesterday for the first time in my life for that matter).
> 

Hmm, I'd like to debug that once we resolve reboot problems.

> OT:  I think I prefer synaptics multi-finger tapping to the tapping in
> specific locations to get right and middle clicking, but that is another
> story that probably has nothing to do with the kernel, and quite likely
> something that is configurable in the synaptics xorg driver.
> 

You should be able to control that in xorg.conf.

-- 
Dmitry
