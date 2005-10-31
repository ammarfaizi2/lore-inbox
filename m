Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVJaQ7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVJaQ7v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVJaQ7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:59:51 -0500
Received: from [85.8.13.51] ([85.8.13.51]:10388 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S964786AbVJaQ7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:59:50 -0500
Message-ID: <43664D78.8050804@drzeus.cx>
Date: Mon, 31 Oct 2005 17:59:36 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.4.1 (X11/20051008)
MIME-Version: 1.0
To: Jordan Crouse <jordan.crouse@amd.com>
CC: linux-kernel@vger.kernel.org, ralf.baechle@linux-mips.org,
       ppopov@embeddedalley.com
Subject: Re: Au1xxx MMC driver
References: <20051031164021.GG20777@cosmic.amd.com>
In-Reply-To: <20051031164021.GG20777@cosmic.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Crouse wrote:
>
>> I'm also concerned about the ammount of protocol awareness in this
>> driver. Is there a spec available for this hardware? Perhaps the MMC
>> layer can export more information so that we can avoid switches on
>> specific MMC commands?
>>     
>
> Spec is here: 
>
> http://tinyurl.com/dslkv  (Horribly long URL and registration required,
> unfortunately).
>   

Very nice. First manufacturer I've seen that gives out a spec. without 
requiring your soul. :)

> In this case, the controller needs to be specifically told what command
> and response type it should expect, thus the opcode switch.
> I don't really think this is an  unreasonable demand to be put on the 
> hardware driver, and its certainly way more HW specific then the upper 
> layers need to be.
>
>   

I've read the spec. and the command response type seems to be the only 
thing required. So protocol awareness is acceptable there provided there 
is a failure case for any unknown type.

For the command type field the driver should check the number of blocks 
and direction, not the command code. SDIO seems more difficult. But 
since we do not support that atm we still have the option of making sure 
any future implementations consider the needs of this hardware. I doubt 
there will be a need for checking command codes here either.

In summary, I see no need for protocol awareness other than response types.

Rgds
Pierre

