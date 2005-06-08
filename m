Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVFHPC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVFHPC4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 11:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVFHPC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 11:02:56 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:10206 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261291AbVFHPCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:02:46 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] Re: swsusp: Not enough free pages
Date: Wed, 8 Jun 2005 17:02:52 +0200
User-Agent: KMail/1.8.1
Cc: linux-pm@lists.osdl.org, "Yu, Luming" <luming.yu@intel.com>,
       Andrew Morton <akpm@zip.com.au>,
       ACPI devel <acpi-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403> <20050606215815.GO2230@elf.ucw.cz> <200506071239.10125.rjw@sisk.pl>
In-Reply-To: <200506071239.10125.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506081702.53349.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 7 of June 2005 12:39, Rafael J. Wysocki wrote: 
> On Monday, 6 of June 2005 23:58, Pavel Machek wrote:
> > Hi!
> > 
> > > > No, I see it on i386, too. Try patch below; if it frees some after
> > > > first pass, you have that problem, too.
> > > 
> > > I've run it once and the result is this:
> > > 
> > > Freeing memory... done (75876 pages freed)
> > > Freeing memory... done (1536 pages freed)
> > > Freeing memory... done (0 pages freed)
> > > Freeing memory... done (1792 pages freed)
> > > Freeing memory... done (0 pages freed)
> > > 
> > > It does free some pages after the first pass, but this is only a small fraction
> > > of all pages freed.  I wouldn't call it a bad result ...
> > 
> > Well, it still did not free all memory it should have freed, and you
> > were lucky.
> 
> This is a reproducible behavior.  Here goes the result for another suspend:
> 
> Freeing memory... done (136611 pages freed)
> Freeing memory... done (200 pages freed)
> Freeing memory... done (128 pages freed)
> Freeing memory... done (0 pages freed)
> Freeing memory... done (2353 pages freed)
> 
> and it is always like that.  It usually frees more than 100000 pages
> in the first pass and about 5% more in the next passes together.
> 
> > Apparently for some people it does not that well (and that 
> > includes me, I see 0 in first pass quite often).
> 
> On 2.6.12-rc3+ I have never seen 0 in the first pass.  In fact, with X running
> I have never seen less than 60000. :-)
> 
> Perhaps there's a bug that does not hit x86-64 for some reason.  I'll try to
> run it on my second box later today and see what happens.

This is the worst result from the second box:

Freeing memory...  done (54641 pages freed)
Freeing memory...  done (0 pages freed)
Freeing memory...  done (5120 pages freed)
Freeing memory...  done (1952 pages freed)
Freeing memory...  done (2304 pages freed)

Still, there are 5x more pages freed in the first pass (80% of RAM was
empty anyway before suspend), and usually it is 10-20x more or so.

AFAICT, on x86-64 shrink_all_memory(10000) is good enough.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
