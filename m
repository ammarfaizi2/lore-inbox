Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132561AbRC1VIo>; Wed, 28 Mar 2001 16:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132163AbRC1VIf>; Wed, 28 Mar 2001 16:08:35 -0500
Received: from [195.63.194.11] ([195.63.194.11]:36875 "EHLO mail.stock-world.de") by vger.kernel.org with ESMTP id <S132557AbRC1VIT>; Wed, 28 Mar 2001 16:08:19 -0500
Message-ID: <3AC24FA2.8D7EB82@evision-ventures.com>
Date: Wed, 28 Mar 2001 22:54:58 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@transmeta.com>
CC: Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
References: <Pine.LNX.4.31.0103271028280.24734-100000@penguin.transmeta.com> <3AC0E9ED.3324F697@transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> This is my opinion on the issue.  Short summary: "I'm sick of the
> administrative burden associated with keeping dev_t dense."
> 
> Linus Torvalds wrote:
> >
> > And let's take a look at /dev. Do a "ls -l /dev" and think about it. Every
> > device needs a unique number. Do you ever envision seeing that "ls -l"
> > taking about 500 billion years to complete? I don't. I don't think you do.
> > But that's how ludicrous a 64-bit device number is.
> >
> 
> That's how ludicrous a *dense* 64-bit device number is.  I have to say I
> disagree with you that sparse number spaces are a bad idea.  The
> IPv4->IPv6 transition people have looked at the issues of number spaces
> and how much harder they get to keep dense when the size of the
> numberspace grows, because your lookup operation becomes so much more
> painful.  Any time you have to take a larger number space and squeeze it
> into a smaller number space, you get some serious pain.
> 
> Part of the reason we haven't -- quite -- run out of 8-bit majors yet is
> because I have been an absolute *bastard* with registrants lately.  It
> would cut down on my workload if I could assign majors without worrying
> too much about whether or not that particular driver is really going to
> be made public.
> 
> 64 bits is obviously excessive, but I really don't feel comfortable
> saying that only 12 bits of major is sufficient.  16 I would buy, but I
> don't think 16 bits of minor is sufficient.  Given that, it seems to me
> -- especially since dev_t isn't exactly the most accessed data type in
> the universe -- that the conceptual simplicity of keeping the major and
> minor separate in individual 32-bit words really is just as well.  YES,
> it's overengineering, but the cost is very small; the cost of
> underengineering is having to go through yet another painful transition.
> Unfortunately, the Linux community seems to have some serious problems
> with getting system-wide transitions to happen, especially the ones that
> involve ABI changes.  This needs to be taken into account.
> 
>         -hpa

Then just tell me please why the PCI name space is just 32 bit?

Majros are for drivers Minors are for device driver instances 
(yes linux does split minors in a stiupid way by forexample
using the same major for IDE disks and ide CD-ROM, which are in
fact compleatly different devices just sharing driver code...
(Dirrerent block sizes, different interface protokoll and so on....)


Those are the reaons solaris is using a split 24/12 (Major/Minor)
and they don't have our problems here.

> 
> --
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> http://www.zytor.com/~hpa/puzzle.txt
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
