Return-Path: <linux-kernel-owner+w=401wt.eu-S1755232AbXAAQZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232AbXAAQZV (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 11:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755234AbXAAQZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 11:25:21 -0500
Received: from ns.suse.de ([195.135.220.2]:45398 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232AbXAAQZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 11:25:20 -0500
From: Andreas Schwab <schwab@suse.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Amit Choudhary <amit2030@yahoo.com>, Bernd Petrovitsch <bernd@firmix.at>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [DISCUSS] Make the variable NULL after freeing it.
References: <88880.94256.qm@web55601.mail.re4.yahoo.com>
	<200701011709.48349.ioe-lkml@rameria.de>
X-Yow: Someone is DROOLING on my collar!!
Date: Mon, 01 Jan 2007 17:25:03 +0100
In-Reply-To: <200701011709.48349.ioe-lkml@rameria.de> (Ingo Oeser's message of
	"Mon, 1 Jan 2007 17:09:46 +0100")
Message-ID: <je3b6uhfz4.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> writes:

> Hi,
>
> On Monday, 1. January 2007 07:37, Amit Choudhary wrote:
>> --- Ingo Oeser <ioe-lkml@rameria.de> wrote:
>> > #define kfree_nullify(x) do { \
>> > 	if (__builtin_constant_p(x)) { \
>> > 		kfree(x); \
>> > 	} else { \
>> > 		typeof(x) *__addr_x = &x; \
>
> Ok, I should change that line to 
> 		typeof(x) *__addr_x = &(x); \
>
>> > 		kfree(*__addr_x); \
>> > 		*__addr_x = NULL; \
>> > 	} \
>> > } while (0)
>> > 
>> > Regards
>> > 
>> > Ingo Oeser
>> > 
>> 
>> This is a nice approach but what if someone does kfree_nullify(x+20).
>
> Then this works, because the side effect (+20) is evaluated only once. 

It's not a side effect, it's a non-lvalue, and you can't take the address
of a non-lvalue.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
