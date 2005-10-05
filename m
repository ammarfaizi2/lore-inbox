Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbVJEWRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbVJEWRD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbVJEWRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:17:03 -0400
Received: from qproxy.gmail.com ([72.14.204.207]:41965 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030394AbVJEWRB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:17:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=imi+FxE2XlYTl0qIWZ3//hnHzBk6wIMSDMqzt9C8UGTaGsjdXJOEx2Es89xuYX7F+a1CPxEIyntpZZrGhVOar11pPwaB5Vezztqs7FEV457NLU1alXMlKsg1Am0BpYFDjtvHiR8E76oQuifagvY3Qm2J4WkUVb14W7iCo2nqMbY=
Message-ID: <d120d5000510051517k28bbb1f9v3c7ec7448608926@mail.gmail.com>
Date: Wed, 5 Oct 2005 17:17:00 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <gregkh@suse.de>
Subject: Re: [patch 08/28] Input: prepare to sysfs integration
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
In-Reply-To: <20051005220316.GA2932@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050915070131.813650000.dtor_core@ameritech.net>
	 <20050915070302.813567000.dtor_core@ameritech.net>
	 <20051005220316.GA2932@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/05, Greg KH <gregkh@suse.de> wrote:
> On Thu, Sep 15, 2005 at 02:01:39AM -0500, Dmitry Torokhov wrote:
> > Input: prepare to sysfs integration
> >
> > Add struct class_device to input_dev; add input_allocate_dev()
> > to dynamically allocate input devices; dynamically allocated
> > devices are automatically registered with sysfs.
> >
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>
> Ok, I've applied this one, and the other "convert the input drivers to
> be dynamic" to my tree, as this is all great work.
>
> I'll work on the last few patches that you have, with regard to how to
> tie it into sysfs "properly" now, and get back to you, just wanted to
> apply all of these, so we have a common base to work on.
>

Greg,

Could you please drop these patches for a while? Or maybe just don't
push them to Linus yet. The reason is that I want to change
input_allocate_device to take bitmap of supported events. This way I
could allocate ABS tables dynamically at the same time I allocate
input_dev itself and it will simplify error handling logic in drivers
and it will save I think 1260 bytes per input_dev structure which is
nice. And I don't want to go through all subsystems yet again soI want
to fold into my input dynalloc patch...

> Oh, I did change one thing in this patch:
>
> >
> > +EXPORT_SYMBOL(input_allocate_device);
>
> I made that EXPORT_SYMBOL_GPL().  Let me know if you object to this.
>

That's fine with me.

--
Dmitry
