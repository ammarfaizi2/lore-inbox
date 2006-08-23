Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbWHWTnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbWHWTnY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 15:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWHWTnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 15:43:23 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:15735 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S965104AbWHWTnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 15:43:23 -0400
Message-ID: <44ECAFB4.8060206@emc.com>
Date: Wed, 23 Aug 2006 15:42:44 -0400
From: Ric Wheeler <ric@emc.com>
Reply-To: ric@emc.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@TU-Ilmenau.DE>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 4/5] fail-injection capability for disk IO
References: <20060823113243.210352005@localhost.localdomain> <20060823113317.722640313@localhost.localdomain> <p73lkpf64gh.fsf@verdi.suse.de> <20060823121028.GE5893@suse.de> <eciajs$1ip$1@sea.gmane.org>
In-Reply-To: <eciajs$1ip$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.4.0.264935, Antispam-Data: 2006.8.1.75432
X-PerlMx-Spam: Gauge=, SPAM=2%, Reasons='EMC_FROM_0+ -2, __CP_MEDIA_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mario 'BitKoenig' Holbe wrote:
> Jens Axboe <axboe@suse.de> wrote:
> 
>>On Wed, Aug 23 2006, Andi Kleen wrote:
>>
>>>I think I would prefer a stackable driver instead of this hook.
> 
> 
> I second this, preferrably a device-mapper target similar to dm-error.
> 
> 
>>But that makes it more tricky to setup a test, since you have to change
>>from using /dev/sda (for example) to /dev/stacked-driver.
> 
> 
> Do you really think somebody would run such tests on otherwise normally
> used devices?
> 

We certainly run this kind of tests on a routine basis - before we ship 
a kernel to our installed field, we need to verify that it will handle 
disk IO errors correctly.

In our case, the tests are run on a farm of machines that get pxe'ed to 
a specific image, tested (usually by sticking in a disk known to be bad 
enough to cause reliable errors ;-)) and then we watch to see that the 
errors do not cause hangs, etc.

Having a requirement to change our standard image (sda -> 
stacked-driver) would not be impossible, but would be less convenient...

ric
