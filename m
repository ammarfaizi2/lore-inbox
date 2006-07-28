Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752025AbWG1QFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbWG1QFQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbWG1QFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:05:16 -0400
Received: from aun.it.uu.se ([130.238.12.36]:30354 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1752025AbWG1QFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:05:15 -0400
Date: Fri, 28 Jul 2006 18:04:59 +0200 (MEST)
Message-Id: <200607281604.k6SG4xV3021888@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: oakad@yahoo.com, pazke@donpac.ru
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006 06:02:11 -0700 (PDT), Alex Dubov wrote:
>The exact condition is (irq_status!=0 &&
>irq_status!=0xffffffff). I think it is not any better
>that what I have.
>
>--- Andrey Panin <pazke@donpac.ru> wrote:
>
>> On 208, 07 27, 2006 at 08:34:06PM -0700, Alex Dubov
>> wrote:
>> 
>> What this strange line (in tifm_7xx1_isr function)
>> is supposed to do:
>> 
>>         if(irq_status && (~irq_status))

If you're chasing micro-optimisations, you could write

    /* if irq_status is not 0 or ~0, do <blah> */
    if (((unsigned)irq_status + 1) >= 2)

which should reduce the number of conditional branches
to a single one. (And drop the cast if irq_status is
declared as unsigned.)

But for long-term maintenance just spelling out the exact
condition (irq_status != 0 && irq_status != ~0) is preferable.
