Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270848AbRH1Mn3>; Tue, 28 Aug 2001 08:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270847AbRH1MnT>; Tue, 28 Aug 2001 08:43:19 -0400
Received: from relay1.zonnet.nl ([62.58.50.37]:37841 "EHLO relay1.zonnet.nl")
	by vger.kernel.org with ESMTP id <S270848AbRH1Mm6>;
	Tue, 28 Aug 2001 08:42:58 -0400
Message-ID: <3B8B91D1.A4D5C23F@linux-m68k.org>
Date: Tue, 28 Aug 2001 14:42:57 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.GSO.4.21.0108242055410.19796-100000@weyl.math.psu.edu> <E15b9rU-0002vE-00@localhost> <9mf8ft$7pt$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus Torvalds wrote:

> I know people don't understand about the difference between signed and
> unsigned compares, and people may not even realize that just by doing
> the patches David ended up fixing a few real bugs that were uncovered
> simply by virtue of having to think about what kind of comparison it was
> supposed to be.

What's wrong with "-Wsign-compare"? You just fixed only a minor amount
of compares.

An explicit type is maintenance problem and cause of other subtle bugs.
When types are changing, the type in the macro is too easily missed and
can cause these funny "but it works on ia32..." errors.

What's wrong with this version?

#define min(a, b) ({            \
        typeof(a) _a = (a);     \
        typeof(b) _b = (b);     \
        _a < _b ? _a : _b;      \
})      

With "-Wsign-compare" the compiler will warn you about wrong usage and
will otherwise automatically do the right thing.

Explicit casts are not good, but such half hidden casts are worse. You
are hiding the problem instead of really fixing it. Why won't you let
the compiler help you?

bye, Roman
