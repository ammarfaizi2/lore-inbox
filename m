Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVCFVvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVCFVvw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 16:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVCFVvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 16:51:52 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:10729 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261471AbVCFVvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 16:51:40 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on battery power)
Date: Sun, 6 Mar 2005 22:53:59 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com, Nigel Cunningham <ncunningham@cyclades.com>
References: <200502252237.04110.rjw@sisk.pl> <200503061830.00574.rjw@sisk.pl> <20050306194100.GA1528@elf.ucw.cz>
In-Reply-To: <20050306194100.GA1528@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503062253.59679.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 6 of March 2005 20:41, Pavel Machek wrote:
> Hi!
> > > > Yes.  I thought about using PG_nosave in the begining, but there's a
> > > > 
> > > > BUG_ON(PageReserved(page) && PageNosave(page));
> > > > 
> > > > in swsusp.c:saveable() that I just didn't want to trigger.  It seems to me,
> > > > though, that we don't need it any more, do we?
> > > 
> > > No, we can just kill it. It was "if something unexpected happens, bail
> > > out soon".
> > 
> > OK
> > 
> > The following is what I'm comfortable with.  I didn't took the Nigel's patch
> > literally, because we do one thing differently (ie nosave pfns) and it contained
> > some changes that I thought were unnecessary.  The i386 part is
> > untested.
> 
> I'd add
> 
> >  	page = pfn_to_page(pfn);
> > -	BUG_ON(PageReserved(page) && PageNosave(page));
> 
> a comment here explaining what PageReserved && PageNosave means. 

OK, I will add the comment.

> >  	if (PageNosave(page))
> >  		return 0;
> > +
> >  	if (PageReserved(page) && pfn_is_nosave(pfn)) {
> >  		pr_debug("[nosave pfn 0x%lx]", pfn);
> >  		return 0;
> 
> AFAICT it only fixes "potential" bug, so it can probably wait. Once
> non-contiguous and initramfs patches are in, this can go...

OK

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
