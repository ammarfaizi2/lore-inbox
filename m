Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbUBIL7S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 06:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbUBIL7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 06:59:18 -0500
Received: from ns.suse.de ([195.135.220.2]:64487 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265045AbUBIL65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 06:58:57 -0500
Date: Mon, 9 Feb 2004 12:56:18 +0100
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Stian Jordet <liste@jordet.nu>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.3-rc1-mm1
Message-ID: <20040209115618.GA7639@pingi3.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Stian Jordet <liste@jordet.nu>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20040209014035.251b26d1.akpm@osdl.org> <1076320225.671.7.camel@chevrolet.hybel> <20040209022453.44e7f453.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040209022453.44e7f453.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organization: SuSE Linux AG
X-Operating-System: Linux 2.4.21-166-default i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, Feb 09, 2004 at 02:24:53AM -0800, Andrew Morton wrote:
> Stian Jordet <liste@jordet.nu> wrote:
> >
> > man, 09.02.2004 kl. 10.40 skrev Andrew Morton:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc1/2.6.3-rc1-mm1/
> > 
> > Pretty, pretty please take Karstein Keil's big isdn update from
> > 
> > ftp://ftp.isdn4linux.de/pub/isdn4linux/kernel/v2.6
> > 
> 
> Boggle.  That thing is 1.8MB.
> 
>  163 files changed, 25877 insertions(+), 22424 deletions(-)
> 
> This is the first time that anyone told me that it even existed.  How on
> earth could a patch to a major subsystem grow to such a size in such
> isolation?  When we're at kernel version 2.6.3!

My fault, I only sent the patch to Linus.

I told a part of the story in my mail to Linus. The problem was that even in
2.5 ISDN was never working. Here my posting to Linus two weeks ago:

-----------------------------------------------------------------------------
Date: Sun, 25 Jan 2004 23:41:42 +0100
From: Karsten Keil <kkeil@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: new ISDN code for 2.6
User-Agent: Mutt/1.4.1i
Organization: SuSE Linux AG
X-Operating-System: Linux 2.4.21-166-default i686

[-- Anhang #1 --]
[-- Typ: text/plain, Kodierung: 7bit, Größe: 1,1K --]

Hello,

here is a really big patch for ISDN in kernel 2.6.
The reason for this big patch is, that I give up
to fix the bugs in the new implementation of the
obsolate (but currently most used) I4L code.
Here are too much changes that never work in this code and
since the authors of the new implementations don't have time
(here was no real effort since half an year) I started
a new port of the well working and stable 2.4 I4L code
to 2.6.
Note: The new port is only for the old I4L part, which is common used up to
now, not for the new CAPI like interface, which got a new design in 2.5 and
should become the successor of I4L, but here are only few cards with CAPI
drivers at the moment. This will change soon, but since all distributions
depend on the old I4L stuff at the moment, here is a strong need to have a
working I4L part in the kernel now. Since new year I got ~500 mails dialing
with ISDN problems and kernel 2.6.

This stuff is well tested on my equipment (~40 different cards) and also
tested by few other people.

The diff is against the current patch-2.6.2-rc1-bk3 version and should
apply clean.

-----------------------------------------------------------------------------

> 
> How mature is this code?  What is its testing status?  What is the size of
> its user base?  Is it available as individual, changelogged patches?
> 

The code is very important in Europe (and some other places), with current
2.5/2.6 ISDN code you can only use some very expensiv activ card (and also
here you will run into trouble).


> It would be crazy to simply shut our eyes and slam something of this
> magnitude into the tree.  And it is totally unreasonable to expect
> interested parties to be able to review and understand it.
> 
> Could someone please tell me how this situation came about, and what we can
> do to prevent any reoccurrence?
> 

Some more how it came to that bad situation:

Kai Germaschewski was maintaining the ISDN code in 2.4/2.5 and did a big
redesign in all parts in 2.5, to prepare ISDN4Linux for the CAPI interface,
which should make the I4L interface obsolate (CAPI Common ISDN API, is a
common standard for ISDN application), my job was to develop a CAPI
hardware driver for passive cards as a replacement of hisax, this
is known now as mISDN driver (modular ISDN driver), but this driver
supports only few of the cards which are supported by hisax at the moment.

Kai did a good job, but he changed also lot of the old (coming obsolate)
code in incompatible ways and his changes never were complete and tested in
practice, also not from himself, his changes were only academic, because he
left Germany to a study in US and in US he had never access to ISDN.
I was aware that he is in US, but I was to stupid to recognise this missing
ISDN problem, I thought he had some NI1 line in US too.
Since also I was too busy to play with his 2.5/2.6 stuff last year and also
nobody else did (I got only compiling fixes during 2.5/6) we run into this
situation.  After first 2.6 versions came out I got many reports about ISDN
and 2.6 issues in last august. Since then I tried to fix the code and get a 
partial working version in october??, but as I had more time during XMas I
did lot of regression test and run into lot of problems with the new code,
and even fixing some of these bring up a bundle of new problems.
So I ask all remaining I4l developers for help, but nobody take care/has time.

So I make a proposal to start a new 2.4 -> 2.6 port of the old I4L
interface, since I know the 2.4 code very well (since most of the driver
code is from me) and 2.4 ISDN is known as very stable and has got also
some certification from telecomunication authorities.

Nobody of the other I4L developers complain and the result was this
patch.

I was preparing new patch last days against current 2.6 version but since I
got ill last weekend, it is not finished yet, but hopefully during next
houres. I have also BitKeeper running here with a clone of the linux-2.5
tree, so if you prefer a bk diff I can also prepare one (but note, I'm
a BK beginner).


-- 
Karsten Keil
SuSE Labs
ISDN development
