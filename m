Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTLNNH5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 08:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTLNNH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 08:07:57 -0500
Received: from secure.comcen.com.au ([203.23.236.73]:28432 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S261262AbTLNNHy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 08:07:54 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Jamie Lokier <jamie@shareable.org>, forming@charter.net
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Sun, 14 Dec 2003 23:11:10 +1000
User-Agent: KMail/1.5.1
Cc: Ian Kumlien <pomac@vapor.com>, linux-kernel@vger.kernel.org
References: <200312140407.28580.ross@datscreative.com.au> <20031214042714.GB21241@mail.shareable.org> <200312142124.45966.ross@datscreative.com.au>
In-Reply-To: <200312142124.45966.ross@datscreative.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312142311.10650.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 December 2003 21:24, Ross Dickson wrote:
<snip>
> 
> The v2 io-apic mods seems OK so far.
> 
> I am not yet sure the v2 apic patch is going to be stable enough for everyone.
> I suspect it is the apic reads.
> 
> Ian had problems at 600ns so now has been trying 800ns. I have yet to hear how
> his machine is.
> 
> I have also gone from 600ns to 800ns and had my first hard lockup
> after about 6 hrs on 800ns delay timeout. 
> 
> I am using a heavily patched 2.4.23 kern so it could be a coincidence
> but I am suspicious that it may not be that safe to be reading the apic
> registers at all during the delay timeout as the v2 apic patch does.
> 
> I am now going to try increasing the wait loop delay from 100ns to 400ns
> in case the apic does not like being hammered repetitively during the delay
> time. - It could be that the bus between the cpu core and the local apic is
> marginal on either timing (PLL) or current and if we hammer it we may
> be asking for incorrect reads?
> 
> I am about to recompile with the following values that differ from my
> original v2 posting. 
> ( 800UL and the ndelay(400) )

<snip>
I had a lockup on a boot so I am trying a bit more conservative with

1000UL and ndelay(400) 

I don't think anyone should try any less than this but hey?

This gives my system a safety margin of 16 apic counts.
The v1 patch on my system typically gave a safety delay of 13 counts.

The performance hit with the v2 is still less than with the v1.
With v2 additional delay would only have been present on 2 out of 10
instead of 10 out of 10 with v1.

..APIC TIMER ack delay, reload:16701, safe:16685
..APIC TIMER ack delay, predelay count:16657
..APIC TIMER ack delay, predelay count:16664
..APIC TIMER ack delay, predelay count:16677
..APIC TIMER ack delay, predelay count:16691
..APIC TIMER ack delay, predelay count:16636
..APIC TIMER ack delay, predelay count:16649
..APIC TIMER ack delay, predelay count:16660
..APIC TIMER ack delay, predelay count:16671
..APIC TIMER ack delay, predelay count:16686
..APIC TIMER ack delay, predelay count:16635

Although as previously mentioned on my system it takes 28 apic counts
to write an io byte to the south bridge such as an ack in xtpic mode
so v1 was not what you would call slow.

If 28 counts was a benchmark then I could still try v2 up to about 1750UL and
still be quicker than the xtpic.

Ross.

