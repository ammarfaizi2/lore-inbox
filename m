Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271095AbRH1OUJ>; Tue, 28 Aug 2001 10:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271082AbRH1OT7>; Tue, 28 Aug 2001 10:19:59 -0400
Received: from relay1.zonnet.nl ([62.58.50.37]:41884 "EHLO relay1.zonnet.nl")
	by vger.kernel.org with ESMTP id <S271095AbRH1OTm>;
	Tue, 28 Aug 2001 10:19:42 -0400
Message-ID: <3B8BA883.3B5AAE2E@linux-m68k.org>
Date: Tue, 28 Aug 2001 16:19:47 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108280617250.8365-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus Torvalds wrote:

> The problem with signed compares is not just comparing a signed entity
> against a unsigned one. It's quite common to have signed quantities on
> both sides, but _intending_ a unsigned comparison or vice versa.

Then it's a bug that should _not_ be fixed in the min macro. Unsigned
values should be hold in unsigned variables. If it's that common, please
show me a sane and realistic example.

> This is simply an area where it's better to make people think about the
> types, than to magically try to do the "right" thing.
> 
> > What's wrong with this version?
> 
> [ Standard stupid min() removed ]

It's not stupid, it does the right thing for the majority of the cases.
A cast just hides the problem. If you need a broken min macro to get
people thinking, you have a much bigger problem.

> You just fixed the "re-use arguments" bug - which is a bug, but doesn't
> address the fact that most of the min/max bugs are due to the programmer
> _indending_ a unsigned compare because he didn't even think about the
> type.

You maybe fixed a few bugs, but this new macro will only cause new
problems in the future. If we change only a single type, you have to
scan all min/max users if they possibly need to be changed too. Thanks
to the cast, the compiler won't even remotely help you finding them.

bye, Roman
