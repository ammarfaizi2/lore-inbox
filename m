Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbRGSXZr>; Thu, 19 Jul 2001 19:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbRGSXZh>; Thu, 19 Jul 2001 19:25:37 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:37636 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266263AbRGSXZX>; Thu, 19 Jul 2001 19:25:23 -0400
Date: Thu, 19 Jul 2001 16:24:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Julian Anastasov <ja@ssi.bg>
cc: "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
In-Reply-To: <Pine.LNX.4.33.0107200206460.1820-100000@u.domain.uli>
Message-ID: <Pine.LNX.4.33.0107191623070.26633-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Fri, 20 Jul 2001, Julian Anastasov wrote:
>
> 	My understanding was that eax, ... edx are declared as
> local vars and so their values can't be used out of the current
> function scope, even when they are defined in inline func.

Yes, but notice how we return a value.

And the only way to get that value is to execute the cpuid. So obviously
gcc can't drop the cpuid. And if it cannot drop it, it cannot ignore the
fact that cpuid changes all the registers we say it changes.

			Linus

