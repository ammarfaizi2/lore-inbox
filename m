Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbTIENsk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 09:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTIENsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 09:48:39 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:26499 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S262512AbTIENsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 09:48:38 -0400
Message-ID: <403e01c373b4$59817630$24ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Re: keyboard - was: Re: Linux 2.6.0-test4
Date: Fri, 5 Sep 2003 22:46:26 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although I don't have time to keep up with the list, I saw this posting from
"Chris Heath" <chris@heathens.co.nz>.  Reordered by importance:

> At this late stage, I don't think it is a good idea to completely
> rewrite the untranslate algorithm.  So we continue to hack it and hack
> it until it works.  :-/

Surely not.  Some keyboards which worked since 2.0 and probably 1.something
are broken in 2.6.  Other keyboards which worked before 2.2.something
(without USB drivers but with BIOS emulation) and resumed working since
2.4.something (with fixed USB dirvers) are broken in 2.6.  Haven't some
lessons been learned from a 2.4.something-dontuse and a few other
2.4.somethings which also should have been -dontuse?  If 2.6.0-dontuse gets
released, Linux will really be as bad as some other famous operating
systems.  Surely it is better to rewrite the untranslate algorithm.

Of course there's some power management and other problems which are in the
same situation.  The keyboard is not the only reason why it would be foolish
to release 2.6.0 before it starts working.

> However, the bytes that come from the i8042 are a mixture of Set 1 and
> Set 2.  Set 1 because the key releases have their 8th bits set, and Set
> 2 because we get the non-XT keys escaped with E0.

I wonder if it's really that simple.  Though today I experimented on a
desktop machine which might have a real i8042 maybe.  Under a combination of
2.6.0-test4 and X11, showkey -s produced the same results which showkey -s
used to produce under 2.4.something on a plain text console.  Maybe this
proves that X11 still accesses the keyboard at a sufficiently low level that
it doesn't suffer from the breakage that was added in 2.6.0-test4 keyboard
drivers.

> I guess the keyboard is sending Set 2 and the BIOS is translating the set
> 2 codes to set 1 for "compatibility with XT software".

I'm pretty sure that this isn't that simple.  The BIOS fails to translate
some keys.  I hacked grub enough to make it possible to type from a Japanese
 keyboard into grub.  Fortunately grub doesn't use every key that the BIOS
understands, so I was able to swap some scan codes in grub's interrupt
handler, let the BIOS translate the ones it likes, and then translate the
results again in grub's higher-level translator.

(Now why does such ugly stuff make people want to puke on their keyboards
when it's really the BIOS's fault  :-?)

