Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTDIAvn (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 20:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbTDIAvn (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 20:51:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35501 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261895AbTDIAvm (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 20:51:42 -0400
Message-ID: <3E937144.9090105@pobox.com>
Date: Tue, 08 Apr 2003 21:03:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: zwane@linuxpower.ca, linux-kernel@vger.kernel.org, hch@infradead.org,
       Kai Germaschewski <kai.germaschewski@gmx.de>, sfr@canb.auug.org.au,
       "Nemosoft Unv." <nemosoft@smcc.demon.nl>, davem@redhat.com
Subject: Re: SET_MODULE_OWNER?
References: <20030409001247.E02A12C482@lists.samba.org>
In-Reply-To: <20030409001247.E02A12C482@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <3E92515B.6030807@pobox.com> you write:
> 
>>Rusty Russell wrote:
>>
>>>Unlike that, substituting dev->owner = THIS_MODULE; has no backwards
>>>compatibility loss, and it removes a confusing and pointless macro
>>>which *never* had a point.
>>
>>
>>Substituting dev->owner=THIS_MODULE has _obvious_ backwards compat loss, 
>>because 'owner' member did not exist in struct net_device.
> 
> 
> Oh, so SET_MODULE_OWNER is a struct net_device only thing?  Certain
> authors (myself included) obviously don't know that.
> 
> 
>>If you had bothered to even do a trivial grep, you would have seen the 
>>use to which SET_MODULE_OWNER is being put.  Christoph's try* changes 
>>are annoying but work-around-able.  Removal of SET_MODULE_OWNER is not.
> 
> 
> If *you* had bothered to do a grep, you would have seen non-netdevice
> uses to which it is really being put, as it's managed to thoroughly
> confuse coders.
> 
> APM, isdn, USB, hell, you even fooled the USAGI guys!
> 
> Seriously, adding an owner arg to init_etherdev and friends, or
> creating a set of SET_NET_DEVICE_OWNER etc macros would have been
> defensible for backwards compatibility.

> D: Jeff points out that SET_MODULE_OWNER is really only for struct
> D: net_device, so move it from module.h to netdevice.h and fix up
> D: areas which were confused about it (renaming would be nice, but
> D: too invasive).


Rusty, this is amazingly disingenuous.

Never did I say SET_MODULE_OWNER was only for struct net_device.

I even pointed out specifically that it IS NOT tied to a specific structure:

> no, SET_MODULE_OWNER is quite intentionally independent of the struct. It only requires a consisnent naming in the source, between structures that may use the macro.
> 
> That's a feature. 

Why don't you just let the maintainers apply the driver "cleanups" if 
they wish, or do not wish, like DaveM did.  Only when that is 
accomplished is it reasonable to consider moving SET_MODULE_OWNER -- and 
only then if other people do not need it's obvious utility.

I would personally rather the macro lived on as a part of the module 
API.  Think of it as part of maintaining friendly hardware vendor 
relations, perhaps?

	Jeff



