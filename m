Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269454AbRICMKH>; Mon, 3 Sep 2001 08:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271683AbRICMJ5>; Mon, 3 Sep 2001 08:09:57 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:63206 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S269454AbRICMJj>; Mon, 3 Sep 2001 08:09:39 -0400
Importance: Normal
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs on parisc
 architecture
To: "David S. Miller" <davem@redhat.com>
Cc: Richard.Zidlicky@stud.informatik.uni-erlangen.de, thunder7@xs4all.nl,
        parisc-linux@lists.parisc-linux.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF9A995335.07A81CF5-ONC1256ABC.00422A7B@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Mon, 3 Sep 2001 14:08:43 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 03/09/2001 14:08:45
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Miller wrote:

>   From: Richard Zidlicky
<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
>   Date: Mon, 3 Sep 2001 00:34:37 +0200
>
>   On Sun, Sep 02, 2001 at 07:57:17PM +0200, thunder7@xs4all.nl wrote:
>   >  /* 64 bit systems (and the S/390) need to be aligned explicitly -jdm
*/
>   > -#if BITS_PER_LONG == 64 || defined(__s390__)
>   > +#if BITS_PER_LONG == 64 || defined(__s390__) || defined(__hppa__)
>   >  #   define ADDR_UNALIGNED_BITS  (3)
>   >  #endif
>
>   couldn't reiserfs use asm/unaligned.h like anyone else?
>   Seems at least sparc and mips may need the same treatment.
>
>Sparc will act correctly for unaliagned accesses.
>
>It will trap and run very slowly, but it wont' OOPS and
>it will give correct results.
>
>This is actually required behavior, I don't know why parisc
>is acting differently.

>From what I recall when we were looking into reiserfs on S/390,
the core problem was that reiserfs tried to do *atomic* operations
on non-aligned words.  This isn't supported by the hardware on
S/390 (normal non-aligned accesses just work).

I don't really see how this can be fixed in a trap handler; how
would the handler guarantee atomicity?



Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

