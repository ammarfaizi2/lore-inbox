Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318992AbSH1VBs>; Wed, 28 Aug 2002 17:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318993AbSH1VBr>; Wed, 28 Aug 2002 17:01:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38154 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318992AbSH1VBq>; Wed, 28 Aug 2002 17:01:46 -0400
Date: Wed, 28 Aug 2002 14:08:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dominik Brodowski <devel@brodo.de>
cc: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
In-Reply-To: <20020828225315.D816@brodo.de>
Message-ID: <Pine.LNX.4.33.0208281406190.16824-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Aug 2002, Dominik Brodowski wrote:
> 
> "policy input" --> "frequency input" --> cpufreq core --> cpufreq driver
>   user-space    |                 k e r n e l  -  s p a c e

No.

The "policy input" has to filter down ALL THE WAY. If you turn it into a 
frequency-only input at _any_ time, you've lost information that the 
lowest levels need. 

THAT is the problem with the current #3 - it _assumes_ that the policy 
input has already been converted to frequency, and since it assumes that, 
it cannot handle the case where the hardware itself wants to know what the 
policy was.

			Linus

