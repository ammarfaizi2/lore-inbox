Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbULGBal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbULGBal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 20:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbULGBal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 20:30:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7368 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261661AbULGBa3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 20:30:29 -0500
Date: Mon, 6 Dec 2004 17:33:27 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: cliff white <cliffw@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, akpm@osdl.org, jgarzik@pobox.com,
       torvalds@osdl.org, clameter@sgi.com, hugh@veritas.com,
       benh@kernel.crashing.org, nickpiggin@yahoo.com.au, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance tests
Message-ID: <20041206193327.GB2282@dmt.cyclades>
References: <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org> <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org> <41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org> <41AEBAB9.3050705@pobox.com> <20041201230217.1d2071a8.akpm@osdl.org> <179540000.1101972418@[10.10.2.4]> <20041202104330.4938fb11.cliffw@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202104330.4938fb11.cliffw@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 10:43:30AM -0800, cliff white wrote:
> On Wed, 01 Dec 2004 23:26:59 -0800
> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
> 
> > --Andrew Morton <akpm@osdl.org> wrote (on Wednesday, December 01, 2004 23:02:17 -0800):
> > 
> > > Jeff Garzik <jgarzik@pobox.com> wrote:
> > >> 
> > >> Andrew Morton wrote:
> > >> > We need to be be achieving higher-quality major releases than we did in
> > >> > 2.6.8 and 2.6.9.  Really the only tool we have to ensure this is longer
> > >> > stabilisation periods.
> > >> 
> > >> 
> > >> I'm still hoping that distros (like my employer) and orgs like OSDL will 
> > >> step up, and hook 2.6.x BK snapshots into daily test harnesses.
> > > 
> > > I believe that both IBM and OSDL are doing this, or are getting geared up
> > > to do this.  With both Linus bk and -mm.
> > 
> > I already run a bunch of tests on a variety of machines for every new 
> > kernel ... but don't have an automated way to compare the results as yet, 
> > so don't actually look at them much ;-(. Sometime soon (quite possibly over 
> > Christmas) things will calm down enough I'll get a couple of days to write 
> > the appropriate perl script, and start publishing stuff.
> 
> We've had the most success when one person has an itch to scratch, and works
> with us to scratch it. We (OSDL) worked with Sebastien at Bull, and we're very 
> glad he had the time to do such excellent work. We worked with Con Kolivas, likewise.
> 
> We've done tools to automate LTP comparisons ( bryce@osdl.org  has posted results )
> and reaim, we've been able to post some regression to lkml, and tied in with developers
> to get bugs fixed. But OSDL has been limited by manpower.
>  
> One of the issues with the performance tests is the amount of data produced - 
>  for example, the deep IO tests produce ton's o'  numbers, but the developer community wants
> a single "+/- 5%" type response-  we need some opinions and help on how to do the data reduction 
> necessary. 

Yep, reaim produces a single "global throughput" result in MB/s, which is wonderful 
for readability.

Now iozone on the other extreme produces output for each kind of operation
(read, write, rw, sync version of those) for each client IIRC. tiobench also
has detailed output for each operation.

We ought to reduce all benchmark results to "read", "write" and "global" (read+write/2) 
numbers. 

I'm willing to work on the data reduction and graphic generation scripts
for STP results. I think I can do that.

> 
> What would be really kewl is some test/analysis code that could be re-used, so the Martin's of the future
> have a good starting place. 
