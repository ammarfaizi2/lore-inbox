Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSEHUgF>; Wed, 8 May 2002 16:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315130AbSEHUgE>; Wed, 8 May 2002 16:36:04 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:1486 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S315120AbSEHUgD>; Wed, 8 May 2002 16:36:03 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Andre Hedrick <andre@linux-ide.org>,
        Bjorn Wesen <bjorn.wesen@axis.com>, Paul Mackerras <paulus@samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
Date: Wed, 8 May 2002 22:04:57 +0200
Message-Id: <20020508200457.25450@smtp.wanadoo.fr>
In-Reply-To: <E175YI5-0002LD-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I though about that, but what about corner cases where only a single
>> register can be accessed ? (typically alt status). Provide specific
>> routines ? Also, how does the extended addressing works ? by writing
>> several times to the cyl registers ? That would have to be dealt with
>> as well in each host driver then.
>
>There are lots of cases we don't care about speed - things like setup of
>the controller, changing UDMA mode etc. 

Right, so we keep the basic indiret access functions, and add the taskfile
ones on top for performances, that's what you mean ?

>> Right. We could go the darwin (apple) way and have taskfile_load/store
>> functions doing the entire registers controlled by a bitmask of which
>> registers has to be touched. it has a cost (testing each bit and
>> conditionally branching, which can suck hard) but probably less than
>
>Get yourself a conditional move instruction 8)

Hehe, let's make an ARM/PPC hybrid ;)

>> an indirect function call which isn't predictable.
>
>Or you have a small set of such functions for the critical paths - ie doing
>actual block I/O which pass the set of values required to do that operation
>and do the stores. What are the performance critical paths
>
>	Begin a disk write
>	Begin a disk read
>	PIO transfer in
>	PIO transfer out
>	End a disk I/O fastpaths (no error case)
>
>	Maybe ATAPI command writes ?
>
>beyond that I doubt the rest are critical 

Well, I would normally agree with the above... except that IDE is so full of
corner cases that I don't want to see dealt with in each host controller
driver...

Ben.

