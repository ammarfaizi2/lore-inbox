Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbRC0TbK>; Tue, 27 Mar 2001 14:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131503AbRC0Tax>; Tue, 27 Mar 2001 14:30:53 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8206 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131497AbRC0Tac>; Tue, 27 Mar 2001 14:30:32 -0500
Message-ID: <3AC0E9ED.3324F697@transmeta.com>
Date: Tue, 27 Mar 2001 11:28:45 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <Pine.LNX.4.31.0103271028280.24734-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my opinion on the issue.  Short summary: "I'm sick of the
administrative burden associated with keeping dev_t dense."

Linus Torvalds wrote:
> 
> And let's take a look at /dev. Do a "ls -l /dev" and think about it. Every
> device needs a unique number. Do you ever envision seeing that "ls -l"
> taking about 500 billion years to complete? I don't. I don't think you do.
> But that's how ludicrous a 64-bit device number is.
> 

That's how ludicrous a *dense* 64-bit device number is.  I have to say I
disagree with you that sparse number spaces are a bad idea.  The
IPv4->IPv6 transition people have looked at the issues of number spaces
and how much harder they get to keep dense when the size of the
numberspace grows, because your lookup operation becomes so much more
painful.  Any time you have to take a larger number space and squeeze it
into a smaller number space, you get some serious pain.

Part of the reason we haven't -- quite -- run out of 8-bit majors yet is
because I have been an absolute *bastard* with registrants lately.  It
would cut down on my workload if I could assign majors without worrying
too much about whether or not that particular driver is really going to
be made public.

64 bits is obviously excessive, but I really don't feel comfortable
saying that only 12 bits of major is sufficient.  16 I would buy, but I
don't think 16 bits of minor is sufficient.  Given that, it seems to me
-- especially since dev_t isn't exactly the most accessed data type in
the universe -- that the conceptual simplicity of keeping the major and
minor separate in individual 32-bit words really is just as well.  YES,
it's overengineering, but the cost is very small; the cost of
underengineering is having to go through yet another painful transition. 
Unfortunately, the Linux community seems to have some serious problems
with getting system-wide transitions to happen, especially the ones that
involve ABI changes.  This needs to be taken into account.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
