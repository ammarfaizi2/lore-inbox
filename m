Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbVIAD3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbVIAD3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 23:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVIAD3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 23:29:51 -0400
Received: from smtpout.mac.com ([17.250.248.97]:54780 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965057AbVIAD3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 23:29:50 -0400
In-Reply-To: <20050831203211.GA13752@midnight.suse.cz>
References: <20050830093715.GA9781@midnight.suse.cz> <4315E0F0.6060209@pobox.com> <20050831205319.A6385@flint.arm.linux.org.uk> <20050831203211.GA13752@midnight.suse.cz>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <94E48213-4A1A-4979-B3A7-05E7BBE19AD3@mac.com>
Cc: Mark Lord <mlord@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: APs from the Kernel Summit run Linux
Date: Wed, 31 Aug 2005 23:29:22 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 31, 2005, at 16:32:11, Vojtech Pavlik wrote:
> On Wed, Aug 31, 2005 at 08:53:19PM +0100, Russell King wrote:
>
>> On Wed, Aug 31, 2005 at 12:55:12PM -0400, Mark Lord wrote:
>>
>>> I'll try loading the works into another ARM
>>> system I have here, and see (1) if it runs as-is,
>>> and (2) what the disassembly shows.
>>>
>>
>> You can identify ARM code quite readily - look for a large number of
>> 32-bit words naturally aligned and grouped together whose top nibble
>> is 14 - ie 0xE.......
>>
>> The top nibble is the conditional execution field, and 14 is  
>> "always".
>
> Didn't find that. Anyway:
>
> The first and third parts contain a repeating 7-byte sequence
>
>         81 40 20 10 08 04 02
>
> near the beginning, while part 2 is padded with zeroes in the same
> place.

That sequence is altered in the first and last repetitions, like this:

88 4020 1008 0402
81 4020 1008 0402
[...]
81 4020 1008 0402
81 4020 1008 04c2

The 4020 and 0402 look oddly symmetrical to me, but that could just
be my imagination.

I wrote a quick perl script to find the number of occurrences of 8-bit
aligned sequences of 16-bits, for all 16-bit values.  It has some
interesting (and potentially useful) results.

The script:
http://zeus.moffetthome.net/~kyle/hexfreq

The output:
http://zeus.moffetthome.net/~kyle/dwl.hexmult

Reprocessed output by frequency:
http://zeus.moffetthome.net/~kyle/dwl.hexfreq

Reprocessing command:
<dwl.hexmult sed -re 's/^(.*): (.*)$/\2: \1/g' | sort -gr >dwl.hexfreq


Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best  
answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because
life wouldn't have any meaning for them if they didn't. That's why I  
draw
cartoons. It's my life."
   -- Charles Shultz


