Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161212AbWGIXbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161212AbWGIXbj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWGIXbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:31:38 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:27102 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161212AbWGIXbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:31:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JeBe0GWA7EkJfqm63k16wDf6dLJam2/DcmUv9ihwb6rLq5si3hcYol3AKo+eI+ul7wtM4s2PjAQe6tGI89ggyQN/+0Bbb6sCEBM/dQhIWeLXGpFC4Yp20Y2BWJkG2E+iyNVAuiYcfhNbd/EEnYqelGMkq3nWe4Wye4NwStuKxS8=
Message-ID: <44B191CF.2090506@gmail.com>
Date: Mon, 10 Jul 2006 07:31:27 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Jon Smirl <jonsmirl@gmail.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Opinions on removing /proc/tty?
References: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com>	<20060707223043.31488bca.rdunlap@xenotime.net>	<9e4733910607072256q65188526uc5cb706ec3ecbaee@mail.gmail.com>	<20060708220414.c8f1476e.rdunlap@xenotime.net>	<9e4733910607082220v754a000ak7e75ae4042a5e595@mail.gmail.com>	<44B0D55D.2010400@gmail.com>	<9e4733910607090645l236f17f1sb9778f0fc6c6ca01@mail.gmail.com> <20060709103529.bf8a46a4.rdunlap@xenotime.net>
In-Reply-To: <20060709103529.bf8a46a4.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Sun, 9 Jul 2006 09:45:06 -0400 Jon Smirl wrote:
> 
>> On 7/9/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>>> Jon Smirl wrote:
>>>> On 7/9/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
>>>>> On Sat, 8 Jul 2006 01:56:02 -0400 Jon Smirl wrote:
>>>>>
>>>>>> On 7/8/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
>>>>>>> I don't know how well this is an answer to your question,
>>>>>>> but I would like to be able to find a list of registered "consoles,"
>>>>>>> whether they be serial, usbserial, netconsole, lp, or whatever.
>>>>>>> /proc/tty/drivers does that partially.
>>>>>> Console is an overloaded word. Do you want to know where it is legal
>>>>>> to send system log output to, or do you want to know where you can log
>>>>>> in from? There was a thread earlier that talked a little about
>>>>>> controlling this.
>>>>> I have a working definition:
>>>>> I want to see a list of drivers that have called register_console().
>>>>>
>>>>>>> I have a patch that also does it in /proc/consoles:
>>>>>>>   http://www.xenotime.net/linux/patches/consoles-list.patch
>>>>>>> Is somewhere in /sys the right place to find a list of all consoles?
>>>>>> /sys is the right place for this info but a class does not exist for
>>>>> it yet.
>>>>>
>>>>> I want a list of registered consoles.  How would I express that in /sys ?
>>>> You could make the list appear as an attribute in
>>>> /sys/class/tty/console. You will need to all a little sysfs code after
>>>> the console tty device is created.
>>>>
>>> That would violate the one file, one value rule and GregKH will drop
>>> it like a hot potato.
>>>
>>> A better solution is to have /sys/class/console.
>> The one value rule is for things that can be changed.

No, it also applies to read-only attributes.

> For, example, I
>> see no problem with using the graphics/modes attribute to see a list
>> of legal modes, and then using graphics/mode to set or view the
>> currently active mode.

Yes, a lot of the fbdev attributes violate this rule. There's some
discussion in fbdev-devel list on how to overhaul this.
 
 Why can't we have a read-only attribute that
>> displays the list of available consoles?
> 
> We should be able to do that somewhere/somehow, but /sys does
> not allow for it in one file, like Tony said.

We can do it in debugfs, or do it like this in sysfs

/sys/class/console--- con0
                  :
                  --- con1
                  :
                  --- con2

Tony
