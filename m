Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVJaQhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVJaQhw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVJaQhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:37:52 -0500
Received: from amdext4.amd.com ([163.181.251.6]:31365 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932456AbVJaQhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:37:51 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Mon, 31 Oct 2005 09:40:21 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: drzeus-list@drzeus.cx
cc: linux-kernel@vger.kernel.org, ralf.baechle@linux-mips.org,
       ppopov@embeddedalley.com
Subject: Au1xxx MMC driver
Message-ID: <20051031164021.GG20777@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F7897C122C3870055-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sucked off of gmane):

>> 1. au1xxx mmc driver
>> 
>>    mmc_remove_host() does a safe shutdown of the MMC host, removing
>>    cards and then powering down.  This must be called prior to the
>>    driver thinking of tearing anything down.
>> 
>>    As for those disable_irq()...enable_irq(), are you aware that MMC
>>    can start talking to the host as soon as you've called mmc_add_host() ?
>> 

> I'm also concerned about the ammount of protocol awareness in this
> driver. Is there a spec available for this hardware? Perhaps the MMC
> layer can export more information so that we can avoid switches on
> specific MMC commands?

Spec is here: 

http://tinyurl.com/dslkv  (Horribly long URL and registration required,
unfortunately).

In this case, the controller needs to be specifically told what command
and response type it should expect, thus the opcode switch.
I don't really think this is an  unreasonable demand to be put on the 
hardware driver, and its certainly way more HW specific then the upper 
layers need to be.

As for Russell's comments - yes, the mm_remove_host() should be called
first, thats my ugly.  As for the second one - we haven't had problems
so far with enabling the interrupt after the mmc_add_host() command -
but I can see how its entirely possible thats just a result of luck, and
not skill.   I'll look in to ways to fix that up. 

Jordan
-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

