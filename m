Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUIJJhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUIJJhr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 05:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267364AbUIJJhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 05:37:45 -0400
Received: from [213.91.207.82] ([213.91.207.82]:13441 "EHLO adsl.nucleusys.com")
	by vger.kernel.org with ESMTP id S267345AbUIJJfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 05:35:08 -0400
Date: Fri, 10 Sep 2004 12:34:54 +0300 (EEST)
From: Petko Manolov <petkan@nucleusys.com>
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, eric.valette@free.fr,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4 badness in rtl8150.c ethernet driver : fixed
In-Reply-To: <20040909223605.GA17655@kroah.com>
Message-ID: <Pine.LNX.4.61.0409101212420.22115@bender.nucleusys.com>
References: <413DB68C.7030508@free.fr> <4140256C.5090803@free.fr>
 <20040909152454.14f7ebc9.akpm@osdl.org> <20040909223605.GA17655@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Sep 2004, Greg KH wrote:

> On Thu, Sep 09, 2004 at 03:24:54PM -0700, Andrew Morton wrote:
>> Eric Valette <eric.valette@free.fr> wrote:
>>>
>>> Here is a small patch that makes the card functionnal again. I've
>>> forwarded the patch to driver author also.
>>>
>>> --- linux/drivers/usb/net/rtl8150.c-2.6.9-rc1-mm4.orig	2004-09-09 11:15:11.000000000 +0200
>>> +++ linux/drivers/usb/net/rtl8150.c	2004-09-09 11:15:46.000000000 +0200
>>> @@ -341,7 +341,7 @@
>>>
>>>  static int rtl8150_reset(rtl8150_t * dev)
>>>  {
>>> -	u8 data = 0x11;
>>> +	u8 data = 0x10;
>>
>> hm, OK.  Presumably the change (which comes in via the bk-usb tree) was
>> made for a reason.  So I suspect both versions are wrong ;)
>>
>> But it might be risky for Greg to merge this patch up at present.
>
> As all your patch does is revert the patch in my tree (it was a one line
> change), mainline should work just fine for you, right?
>
> I'll defer to Petkan as to what to do about this, as he sent me that
> patch for a good reason I imagine :)

Steven Hein <ssh@sgi.com> sent me a patch that supposedly fix device 
registers misinitialization when it is being frequently reseted.

RTL8150 is quite flaky piece of HW so i first tested the new value and it 
did work for me.  That's why i decided to send it to Greg.

I would say lets wait for some time and see if we'll break someone else's
heart and then reverse the patch.  Another solution is to restore the 
original value and add new module parameter, so whoever thinks
anything != 0x10 work better for him will be free to change it.


 		Petko
