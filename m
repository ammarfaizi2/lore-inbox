Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283360AbRLIMCq>; Sun, 9 Dec 2001 07:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283365AbRLIMCf>; Sun, 9 Dec 2001 07:02:35 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:19466 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S283360AbRLIMCO>;
	Sun, 9 Dec 2001 07:02:14 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200112091201.fB9C1wD158088@saturn.cs.uml.edu>
Subject: Re: Intel I860
To: jamagallon@able.es (J.A. Magallon)
Date: Sun, 9 Dec 2001 07:01:58 -0500 (EST)
Cc: n0ano@indstorage.com,
        akruemmel@dohle.com (Achim =?iso-8859-1?Q?Kr=FCmmel?=),
        linux-kernel@vger.kernel.org
In-Reply-To: <20011127003327.C1546@werewolf.able.es> from "J.A. Magallon" at Nov 27, 2001 12:33:27 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon writes:
> On 20011126 n0ano@indstorage.com wrote:

>> Uh, what exactly do you think you have here?  The I860 was a
>> completely new architecture that Intel dropped over 5 years
>> ago.  I've got one running Unix SVR4 in my basement but you
>> can't buy an I860 motherboard today.
>>
>> (For the record the 860 was a great architecture for the time
>> and I'm still bitter that Intel dropped it but that's a different
>> story.)
>
> You are talking about intel i860 _processor_, and he asks about
> I860 chipset.
>
> BTW, I always desired to put my hands on an i860. It is the only real
> good chip by Intel (it really looked like a Moto...). The only ones
> I used were inside an HP Graphics accelerator on a 9000/385.

You people are insane, but hey, it'd be cool to have i860 Linux.
Maybe you don't realize just how unfit this chip is for normal
UNIX-like use.

It's a RISC chip with the Pentium MMU. To get any speed out of it,
you have to enable some strange features. First of all, you need
the double-instruction mode. In every 64-bit chunk of memory you
place 1 floating-point instruction and 1 integer instruction.
Second of all, you need to enable pipelined FPU operation. This is
an exposed pipeline, so watch out! Look what happens:

a = x + x
b = a + a     <-- uses old value of "a", not x+x
nop
nop
nop
c = a + a

Yep, c!=a after this!  Actually, "c" won't be set until a few
instructions later because it too is still in the pipeline.
You need a few dummy operations to push it out.

Now lets have a trap of some sort while that floating-point
pipeline is full. The chip leaves itself in a horrible messy
state that may well require thousands of lines of assembly
code to sort out. I'm not kidding.

The chip made a fine DSP. You could put a few dozen together
for radar.
