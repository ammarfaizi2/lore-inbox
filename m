Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbULHSB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbULHSB0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbULHR7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:59:30 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:1006 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261291AbULHR4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:56:21 -0500
Subject: Re: Anticipatory prefaulting in the page fault handler V1
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@osdl.org>, hugh@veritas.com,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-mm <linux-mm@kvack.org>, linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0412080920240.27156@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>
	 <41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org>
	 <41AEBAB9.3050705@pobox.com> <20041201230217.1d2071a8.akpm@osdl.org>
	 <179540000.1101972418@[10.10.2.4]> <41AEC4D7.4060507@pobox.com>
	 <20041202101029.7fe8b303.cliffw@osdl.org>
	 <Pine.LNX.4.58.0412080920240.27156@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1102528526.25546.974.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Dec 2004 09:55:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 09:24, Christoph Lameter wrote:
> The page fault handler for anonymous pages can generate significant overhead
> apart from its essential function which is to clear and setup a new page
> table entry for a never accessed memory location. This overhead increases
> significantly in an SMP environment.

do_anonymous_page() is a relatively compact function at this point. 
This would probably be a lot more readable if it was broken out into at
least another function or two that do_anonymous_page() calls into.  That
way, you also get a much cleaner separation if anyone needs to turn it
off in the future.  

Speaking of that, have you seen this impair performance on any other
workloads?  

-- Dave

