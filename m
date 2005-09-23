Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVIWUzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVIWUzm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 16:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVIWUzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 16:55:42 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:38592 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751274AbVIWUzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 16:55:41 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [swsusp] Rework image freeing
Date: Fri, 23 Sep 2005 22:52:52 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
References: <20050921205132.GA4249@elf.ucw.cz> <200509220053.45358.rjw@sisk.pl> <20050922094608.GA1773@elf.ucw.cz>
In-Reply-To: <20050922094608.GA1773@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509232252.53237.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 22 of September 2005 11:46, Pavel Machek wrote:
> Hi!
> 
> > > -
> > > -/**
> > > - *	calc_nr - Determine the number of pages needed for a pbe list.
> > > - */
> > > -
> > > -static int calc_nr(int nr_copy)
> > > -{
> > > -	return nr_copy + (nr_copy+PBES_PER_PAGE-2)/(PBES_PER_PAGE-1);
> > > -}
> > 
> > I can't see why you are going to drop this function.  Isn't it necessary any more?
> 
> I've actually decreased on-disk memory requirements by... guess what:
> (nr_copy+PBES_PER_PAGE-2)/(PBES_PER_PAGE-1) factor. I do not store two
> copies of page directories any more.

On-disk - yes, but we still need to allocate RAM to create the "pagedir".
It takes ca (nr_copy_pages/(PBS_PER_PAGE-1) + !!(nr_copy_pages % (PBS_PER_PAGE-1))),
so we should include this number in the check for free RAM and in the message
in swsusp_alloc(), I think.

Besides, the checks for free RAM and swap could be moved to
suspend_prepare_image(), along with the accompanying printk()s,
so that we call swsusp_alloc() only after we have verified there should
be enough resources.

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
