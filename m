Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263127AbRFLTRI>; Tue, 12 Jun 2001 15:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263139AbRFLTQ5>; Tue, 12 Jun 2001 15:16:57 -0400
Received: from ns.caldera.de ([212.34.180.1]:30091 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S263127AbRFLTQm>;
	Tue, 12 Jun 2001 15:16:42 -0400
Date: Tue, 12 Jun 2001 21:15:44 +0200
From: Christoph Hellwig <hch@caldera.de>
To: ognen@gene.pbi.nrc.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: threading question
Message-ID: <20010612211544.A6594@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>, ognen@gene.pbi.nrc.ca,
	linux-kernel@vger.kernel.org
In-Reply-To: <200106121858.f5CIwmX05650@ns.caldera.de> <Pine.LNX.4.30.0106121304320.24593-100000@gene.pbi.nrc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0106121304320.24593-100000@gene.pbi.nrc.ca>; from ognen@gene.pbi.nrc.ca on Tue, Jun 12, 2001 at 01:07:11PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2001 at 01:07:11PM -0600, ognen@gene.pbi.nrc.ca wrote:
> Hello,
> 
> due to the nature of the problem (a pairwise mutual alignment of n
> sequences results in mx. n^2 alignments which can each be done in a
> separate thread), I need to create and destroy the threads frequently.
> 
> I am not really comfortable with 1.4 - 1.5 speedups since the solution was
> intended as a Linux one primarily and it just happenned that it works (and
> now even better) on Solaris/SGI/OSF...

If you havily create threads under load you're rather srewed.  If you want
to stay with the (IMHO rather suboptimal) posix threads API you might want
to take a look at the stuff IBM has produced:

	http://oss.software.ibm.com/developerworks/projects/pthreads/

Otherwise a simple wrapper for clone might be a _lot_ faster, but has it's
own disadvantages: no ready-to-use lcoking primitives, no cross-platform
support (ok, it should be portable to the FreeBSD rfork easily).

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
