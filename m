Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbUKRAki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbUKRAki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 19:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbUKRAeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 19:34:16 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:42500 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S262607AbUKRA2d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 19:28:33 -0500
Message-ID: <419BECB0.70801@tebibyte.org>
Date: Thu, 18 Nov 2004 01:28:32 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrea Arcangeli <andrea@novell.com>,
       Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable
 braindamage
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random> <1099706150.2810.147.camel@thomas> <20041117195417.A3289@almesberger.net> <419BDE53.1030003@tebibyte.org> <20041117210410.R28844@almesberger.net>
In-Reply-To: <20041117210410.R28844@almesberger.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Werner Almesberger escreveu:
> Chris Ross wrote:
> The underlying hypothesis for suggesting explicitly flagging
> candidates for killing is of course that it doesn't see who
> exactly is misbehaving :-) Since this issue has been around for
> a nummber of years, I think it's fair to assume that the OOM
> killers indeed have a problem in that area.

That's my point ii) below, which is what Thomas's patch is trying to 
address. I doubt you'd find much disagreement that this area still needs 
work :)

>>The example I have in mind is on my machine when the daily cron 
>>run over commits causing standard daemons such as ntpd to be killed to 
>>make room. It would be preferable if the daemon was swapped out and just 
>>didn't run for minutes, or even hours if need be, but was allowed to run 
>>again once the system had settled down.
> 
> Ah, now I understand why you'd want to swap. Interesting. Now,
> depending on the time if day, you have typically "interactive"
> processes, like your idle desktop, turn into "non-interactive"
> ones, which can then be subjected to swapping. Nice example
> against static classification :-)

A better example than the ntpd daemon (which mightn't take kindly to 
finding minutes just passed in a blink of its eye) is Thomas's example 
with the sshd. If the daemon was swapped out you wouldn't be able to log 
into the box while it was thrashing, but in practice you can't really 
anyway. At least once the system had recovered sufficiently you could 
get back in, under the present system you can never log in again.

>>So, the problem breaks down into three parts:
>>
>>	  i) When should the oom killer be invoked.
>>	 ii) How do we pick a victim process
>>	iii) How can we deal with the process in the most useful manner
> 
> iii) may also affect i). If you're going to swap, you don't want
> to wait until you're fighting for the last available page in the
> system.

Well yes, in typical fashion everything depends on everything else. That 
in a nutshell is also my argument against the kill-me flag.

Regards,
Chris R.
