Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266431AbUFUTwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266431AbUFUTwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 15:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266440AbUFUTwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 15:52:25 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:34125 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S266431AbUFUTwW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 15:52:22 -0400
Message-ID: <40D73C6A.1090005@microgate.com>
Date: Mon, 21 Jun 2004 14:52:10 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: da-x@colinux.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing NULL check in drivers/char/n_tty.c
References: <20040621063845.GA6379@callisto.yi.org>	<20040620235824.5407bc4c.akpm@osdl.org>	<20040621073644.GA10781@callisto.yi.org>	<20040621003944.48f4b4be.akpm@osdl.org>	<20040621082430.GA11566@callisto.yi.org>	<40D6F986.3010904@microgate.com> <20040621114605.4df2c05e.akpm@osdl.org>
In-Reply-To: <20040621114605.4df2c05e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Paul Fulghum <paulkf@microgate.com> wrote:
>> Which would be better?
>> 1. Ignore this
>> 2. Fix conditional debug output to check
>>     for ldisc.chars_in_buffer==NULL
>> 3. Remove conditional debug output
> 
> Option 1 is quite valid.  There are no bugs here, yes?

If the debug output is enabled and
a line discipline other than N_TTY is used,
then you get an oops when the NULL method
is called.

Since the debug output is not enabled by
default, and is probably never really used,
it is not a significant bug.

I thought it might be worth eliminating or
correcting the debug outputs since they seem
to get cloned into new serial drivers.
It is certainly not a big problem.

> If someone for some reason wants to clean all this up, the best way would
> be to require that ->chars_in_buffer always be valid, hence remove all
> those checks.

OK

--
Paul Fulghum
paulkf@microgate.com
