Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbUKTKqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbUKTKqD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 05:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUKTKqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 05:46:03 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:48008 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261665AbUKTKp4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 05:45:56 -0500
Message-ID: <419F2062.8080401@ribosome.natur.cuni.cz>
Date: Sat, 20 Nov 2004 11:45:54 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041114
X-Accept-Language: cs, en, en-us
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au, chris@tebibyte.org,
       marcelo.tosatti@cyclades.com, andrea@novell.com,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] fix spurious OOM kills
References: <20041111112922.GA15948@logos.cnet>	 <4193E056.6070100@tebibyte.org>	<4194EA45.90800@tebibyte.org>	 <20041113233740.GA4121@x30.random>	<20041114094417.GC29267@logos.cnet>	 <20041114170339.GB13733@dualathlon.random>	 <20041114202155.GB2764@logos.cnet>	<419A2B3A.80702@tebibyte.org>	 <419B14F9.7080204@tebibyte.org>	<20041117012346.5bfdf7bc.akpm@osdl.org>	 <419CD8C1.4030506@ribosome.natur.cuni.cz>	 <20041118131655.6782108e.akpm@osdl.org>	 <419D25B5.1060504@ribosome.natur.cuni.cz>	 <419D2987.8010305@cyberone.com.au>	 <419D383D.4000901@ribosome.natur.cuni.cz>	 <20041118160824.3bfc961c.akpm@osdl.org>	 <419E821F.7010601@ribosome.natur.cuni.cz> <1100946207.2635.202.camel@thomas>
In-Reply-To: <1100946207.2635.202.camel@thomas>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Sat, 2004-11-20 at 00:30 +0100, Martin MOKREJ© wrote:
> 
>>OK, I can say kernel 2.6.7, 2.6.8.1, 2.6.9-rc1 kill just the RNAsubopt
>>application in my test.
>>
>>2.6.9-rc2 kills RNAsubopt and also two xterms, one running vmstat,
>>the other is parent of RNAsubopt program I used to eat memory with.
>>
>>2.6.9 has killed just those 2 xterms, as a sideeffect the RNAsubopt
>>got killed as parent shell got killed.
>>
>>2.6.10-rc1 killed all three.
>>
>>I conclude the major problem got introduced between
>>2.6.9-rc1 and 2.6.9-rc2.
> 
> 
> Can you please try 2.6.10-rc2-mm2 + the patch I posted yesterday night ?
> It will still kill RNAsubopt, but it should not longer touch the xterm,
> which runs vmstat.

Will do in a minute.

> 
> 
>>Second problem with 2.6 tree is that I think application should receive 
>>some errocode when asking for more memory, so it can exit itself.
>>This used to work well under 2.4 tree and was demostrated in my
>>previous reports where you see application exist with "not enough memory"
>>rather than with "Killed". ;-)
> 
> 
> One good reason might be that in the out of memory situation the system
> has no idea, whether the requester will gracefully shutdown when
> recieving ENOMEM or keep trying to get some more memory. 
> 
> The decision to return ENOMEM or finally calling the oom-killer depends
> on the flags for this allocation request. The criteria are __GFP_FS set
> and not __GFP_NORETRY set.
> 
> So all allocations GFP_KERNEL, GFP_USER and GFP_HIGHUSER are candidates
> to end up in the oom_killer. The only caller which ever sets the
> __GFP_NORETRY flag is fs/xfs.

I don't understand ansi C ;) ... so just tell me why the kernel doesn't
try the "old" way as on 2.4 kernel, and if teh appliation wouldn't get killed,
I don't care I have to wait another 10 seconds to het it killed.
The application wil close it's files, remove tempfiles etc.

The sources of the program are available. Can you have a brif look into
the code and tell me if this application does or does not treat those
memory allocation in whatever that *GFP* thing is? ;-) In other words,
is this application written correctly or not? Does it have to be killed
ro should it exit weel also on 2.6 kernel (note, it does exit on 2.4 ...).

Thanks for help!
Martin

BTW: my last 2 relies got lost on the way through lkml. :((
My SMTPserver said:
@40000000419f13a321bbf6a4 status: local 0/10 remote 9/20
@40000000419f13a41cea7d1c delivery 9: success: (tglx@linutronix.de)_213.239.205.147_accepted_message./Remote_host_said:_250_Ok
:_queued_as_1D47365C044/
@40000000419f13a41cebadcc status: local 0/10 remote 8/20
@40000000419f13a504926324 delivery 3: success: (chris@tebibyte.org)_82.161.9.107_accepted_message./Remote_host_said:_250_Ok:_q
ueued_as_A38AD684/
@40000000419f13a504937c64 status: local 0/10 remote 7/20
@40000000419f13a508f3214c delivery 5: failure: 130.57.1.11_does_not_like_recipient./Remote_host_said:_550_5.1.1_<andrea@novell
.com>_is_not_a_valid_mailbox._550_No_such_recipient/Giving_up_on_130.57.1.11./
@40000000419f13a508f8bae4 status: local 0/10 remote 6/20
@40000000419f13a602653a54 delivery 8: success: (riel@redhat.com)_66.187.233.32_accepted_message./Remote_host_said:_250_2.0.0_i
AK9pMqT000648_Message_accepted_for_delivery/
@40000000419f13a602666b04 status: local 0/10 remote 5/20
@40000000419f13a63041b8bc delivery 6: success: (linux-kernel@vger.kernel.org)_12.107.209.244_accepted_message./Remote_host_sai
d:_250_2.7.0_nothing_apparently_wrong_in_the_message.;_S261490AbUKTJvY/
@40000000419f13a63042ddb4 status: local 0/10 remote 4/20
@40000000419f13a8042341ec delivery 7: success: (linux-mm@kvack.org)_66.96.29.28_accepted_message./Remote_host_said:_250_2.6.0_
S26517AbUKTJvQ_message_accepted/
@40000000419f13a804248a0c status: local 0/10 remote 3/20
@40000000419f13a8181adc3c delivery 1: success: (akpm@osdl.org)_65.172.181.4_accepted_message./Remote_host_said:_250_2.0.0_iAK9
pMPE008452_Message_accepted_for_delivery/
@40000000419f13a8181af794 status: local 0/10 remote 2/20
@40000000419f13aa22abd8cc delivery 2: success: (piggin@cyberone.com.au)_203.29.91.92_accepted_message./Remote_host_said:_250_O
K_id=1CVRtv-0003cD-LZ/
@40000000419f13aa22ad191c status: local 0/10 remote 1/20
@40000000419f13ac38f1240c delivery 4: success: (marcelo.tosatti@cyclades.com)_64.186.161.6_accepted_message./Remote_host_said:
_250_Ok:_queued_as_041F080041B/
