Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262140AbSJNTk1>; Mon, 14 Oct 2002 15:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262141AbSJNTk1>; Mon, 14 Oct 2002 15:40:27 -0400
Received: from inrete-46-20.inrete.it ([81.92.46.20]:24808 "EHLO
	pdamail1-pdamail.inrete.it") by vger.kernel.org with ESMTP
	id <S262140AbSJNTk0>; Mon, 14 Oct 2002 15:40:26 -0400
Message-ID: <3DAB1F00.667B82B5@inrete.it>
Date: Mon, 14 Oct 2002 21:46:08 +0200
From: Daniele Lugli <genlogic@inrete.it>
Organization: General Logic srl
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rthal5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: unhappy with current.h
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently wrote a kernel module which gave me some mysterious problems.
After too many days spent in blood, sweat and tears, I found the cause:

*** one of my data structures has a field named 'current'. ***

Pretty common word, isn't it? Would you think it can cause such a
trouble? But in some of my files I happen to indirectly include
<asm/current.h> (kernel 2.4.18 for i386), containing the following line:

#define current get_current()

so that my structure becomes the owner of a function it has never asked
for, while it looses a data member. gcc has nothing to complain about
that.

In some other files I don't happen to include <asm/current.h>, so that
there my structure is sound - but alas! has different size and different
composition. Again, gcc has nothing to complain.

Moral of the story: in my opinion kernel developers should reduce to a
minimum the use of #define, and preferably use words in uppercase and/or
with underscores, in any case not commonly used words.
In the specific case the said #define just looks to save 6 keystrokes
and I think it could have been completely avoided.

Regards, Daniele Lugli
