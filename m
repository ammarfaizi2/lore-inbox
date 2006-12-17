Return-Path: <linux-kernel-owner+w=401wt.eu-S1752476AbWLQLpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbWLQLpZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 06:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbWLQLpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 06:45:25 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:49388 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbWLQLpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 06:45:25 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45852DB6.1020805@s5r6.in-berlin.de>
Date: Sun, 17 Dec 2006 12:44:54 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, Pavel Machek <pavel@ucw.cz>
CC: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain> <20061216084007.GC4049@ucw.cz> <Pine.LNX.4.64.0612160802250.3660@localhost.localdomain> <Pine.LNX.4.61.0612161912390.30896@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612161912390.30896@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> On Dec 16 2006 08:09, Robert P. J. Day wrote:
>> On Sat, 16 Dec 2006, Pavel Machek wrote:
>>>> but we already have, from "include/linux/kernel.h":
>>>>
>>>>   #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>>> Hmmm. quite misleading name :-(. ARRAY_LEN would be better.

"Size", "length", "width", "depth" is all the same in that one needs to
know the unit of measurement. The unit of measurement of ARRAY_SIZE is
one array member. This makes it useful as a bound for [ ] pointer
arithmetic which uses the same unit.

If you want to look at it from a slightly higher level of abstraction
and want to avoid the ambiguity WRT units of measurement (C programs
most often use Byte as unit for data size), consider the unitless
(cardinal) ARRAY_INDEX_BOUND or ARRAY_CARDINALITY. (In a language which
starts array indexes at 1 instead of 0, it could also be called
ARRAY_HIINDEX.)

But fortunately...

>> i suspect it's *way* too late to make that kind of change, given that
>> "ARRAY_SIZE" is firmly ensconced in countless places in the source
>> tree and that would be a major, disruptive change.
>>
>> even *i* wouldn't try to promote that idea.  :-)
> 
> You know, you could always make it compat for a while, but that requires
> approval from Linus I suppose /* heh, heh */
> 
> I don't even know if this will compile everywhere,
> but I hope you can figure out the idea...
> 
> #define ARRAY_SIZE(x) (print_warning(), sizeof(x) / sizeof(*x))
> #define ARRAY_LEN(x)  (sizeof(x) / sizeof(*x))
> extern ...
> void print_warning(void) {
>     printk("Don't use ARRAY_SIZE anymore, it will go away\n");
> }

...those who know that the ARRAY_SIZE macro is available also know what
it means and how to use it. Therefore there is no need to rename this macro.
-- 
Stefan Richter
-=====-=-==- ==-- =---=
http://arcgraph.de/sr/
