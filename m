Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272257AbRHWNLv>; Thu, 23 Aug 2001 09:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272258AbRHWNLk>; Thu, 23 Aug 2001 09:11:40 -0400
Received: from s1.relay.oleane.net ([195.25.12.48]:9863 "HELO
	s1.relay.oleane.net") by vger.kernel.org with SMTP
	id <S272257AbRHWNL2>; Thu, 23 Aug 2001 09:11:28 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] (comments requested) adding finer-grained timing to PPC
 add_timer_randomness()
Date: Thu, 23 Aug 2001 15:11:04 +0200
Message-Id: <20010823131104.9016@smtp.adsl.oleane.com>
In-Reply-To: <Pine.LNX.4.21.0108231137080.2015-100000@ltgp.iram.es>
In-Reply-To: <Pine.LNX.4.21.0108231137080.2015-100000@ltgp.iram.es>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> In the 2.4 tree we have code that works out a cpu features word from
>> the PVR value.  The cpu features word has bits for things like does
>> the cpu have the TB register, does the MMU use a hash table, does the
>> cpu have separate I and D caches, etc.
>
>Reading the PVR is probably faster in this case, since you avoid a
>potential cache miss. As I said in an earlier message the __USE_RTC macro
>should be made dependent on whether the kernel supports 601 or not.

The CPU features will nop-out sections of code that don't apply for
a given CPU if you use the assembly macros. If you nop'out a couple
of instructions, you win over reading the PVR, masking out bits,
comparing, and doing a conditional branch.

Ben.



