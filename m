Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316756AbSFDUGO>; Tue, 4 Jun 2002 16:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSFDUF2>; Tue, 4 Jun 2002 16:05:28 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:38369 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316751AbSFDUEj>;
	Tue, 4 Jun 2002 16:04:39 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15613.7493.765450.205401@napali.hpl.hp.com>
Date: Tue, 4 Jun 2002 13:04:21 -0700
To: <o.pitzeier@uptime.at>
Cc: "'Ivan Kokshaysky'" <ink@jurassic.park.msu.ru>,
        "'Richard Henderson'" <rth@twiddle.net>,
        <linux-kernel@vger.kernel.org>, <axp-kernel-list@redhat.com>
Subject: Re: kernel 2.5.20 on alpha (RE: [patch] Re: kernel 2.5.18 on alpha)
In-Reply-To: <000101c20bb0$27e93620$010b10ac@sbp.uptime.at>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 4 Jun 2002 12:11:05 +0200, "Oliver Pitzeier" <o.pitzeier@uptime.at> said:

  >> `copy_user_page' undeclared (first use in this function) make[1]:
  >> *** [main.o] Error 1 make[1]: Leaving directory
  >> `/usr/src/linux-2.5.20/init' make: *** [init] Error 2

  Oliver> I guess I found where the error comes from:

  Oliver> (from the 2.5.20 Changelog):
  >> <davidm@napali.hpl.hp.com> [PATCH] pass "page" pointer to
  >> clear_user_page()/copy_user_page()
  >> 
  >> Hi Linus,
  >> 
  >> Are you willing to change the interfaces of clear_user_page() and
  >> copy_user_page() so that they can receive the relevant page
  >> pointer as a separate argument?  I need this on ia64 to implement
  >> the lazy-cache flushing scheme.
  >> 
  >> I believe PPC would also benefit from this.
  >> 
  >> --david

  Oliver> Now I believe, that Alpha also benefits from this. :o) The
  Oliver> only thing I have to do - I guess - is to change the defines
  Oliver> for copy_user_page() and clear_user_page. Adding the not
  Oliver> used parameter >pg< should not make any problems.

Yes, you can simply ignore the page pointer argument.  It's there for
those arches that want to take advantage of it.  Sorry about causing
breakage...

	--david
