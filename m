Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263096AbVCQPHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbVCQPHT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 10:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbVCQPGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 10:06:40 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:26379 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263088AbVCQPFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 10:05:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=t7pxqtCZBl/4r6o49ut1JmTcsy+F4KyPlhTF5/289wF7oLTNoGRthLPCDR9iVYFnfnXbFQvPGqP8Q8xIVFxzH+moxI3horE1cnOD0wN9rCNvBy4ZMr8DGmXJt5wjugclTecjVduULl27C/0bj9eTNsmuTZDb0SHTgsFn0RWcWtA=
Message-ID: <d120d50005031707054cef8ef7@mail.gmail.com>
Date: Thu, 17 Mar 2005 10:05:28 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [PATCH 0/5] I8K driver facelift
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <42394FF4.60203@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <200502240110.16521.dtor_core@ameritech.net>
	 <4233B65A.4030302@tuxrocks.com> <4238A76A.3040408@tuxrocks.com>
	 <200503170140.49328.dtor_core@ameritech.net>
	 <42394FF4.60203@tuxrocks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005 02:37:56 -0700, Frank Sorenson <frank@tuxrocks.com> wrote:

> 1: My Inspiron 9200 (and perhaps others) doesn't seem to respond to the
> I8K_SMM_BIOS_VERSION function call, so it fails the check in i8k_probe.
> ~ The check of i8k_get_bios_version doesn't seem critical, and removing
> the return -ENODEV makes it work again for me.  That's the current
> behavior, so perhaps the printk level should just be changed to
> KERN_WARNING rather than KERN_ALERT.

You are probably right, I shoudl change that.

> 2: To compile 2.6.11 cleanly, I needed two hunks from your original
> patch 2 (perhaps you're working from a more up-to-date tree than I am?
> If so, these are probably already addressed.):
> 

Oh, sorry - when I was pereparing cumulative patch I simply missed
this bit. It is still nowhere near the official tree.

> 
> The 'temp' entries make sense, however I'm not sure about the fan_speed
> and fan_state entries.  From the perspective of how the objects are
> ordered, a fan would have 'speed' and 'state' attributes, but a
> 'fan_state' attribute wouldn't normally have a fan.  Maybe something
> along these lines would make more sense from that perspective:
> 
> ./fan/0
> ./fan/0/speed
> ./fan/0/state
> ./fan/1
> ./fan/1/speed
> ./fan/1/state
> 

Yes, as soon as I did attribute array I realized that something like
attr_array_group would reflect the structure better... We'll see what 
can be done.

Thank you for your comments and suggestions!

-- 
Dmitry
