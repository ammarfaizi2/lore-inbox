Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161048AbVKXIHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbVKXIHg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 03:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbVKXIHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 03:07:36 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:24211 "EHLO
	orac.home") by vger.kernel.org with ESMTP id S1161048AbVKXIHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 03:07:35 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Dual opteron various segfaults with 2.6.14.2 and earlier kernels
Date: Thu, 24 Nov 2005 08:07:28 +0000
User-Agent: KMail/1.8.2
References: <200511231537.49320.cova@ferrara.linux.it> <200511240026.42212.cova@ferrara.linux.it> <20051124000351.GT18321@opteron.random>
In-Reply-To: <20051124000351.GT18321@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511240807.28861.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 November 2005 00:03, Andrea Arcangeli wrote:
> Hello Fabio,
>
> On Thu, Nov 24, 2005 at 12:26:41AM +0100, Fabio Coatti wrote:
> > yes, uname says  2.6.14.2; on a second identical machine, I've just seen
> > this:
> >
> >
> > factorial[2352]: segfault at 0000000000020f31 rip 00000000004035ae rsp
> > 00007fffffbfaf60 error 4
> > factorial[2354]: segfault at 0000000000020f31 rip 00000000004035ae rsp
> > 00007fffffe3fc70 error 4
> > factorial[2361]: segfault at 0000000000020f31 rip 00000000004035ae rsp
> > 00007fffffb07c50 error 4
> > factorial[2358]: segfault at 0000000000020f31 rip 00000000004035ae rsp
> > 00007fffffb07c50 error 4
> > factorial[2363]: segfault at 0000000000020f31 rip 00000000004035ae rsp
> > 00007fffffe6d270 error 4
> >
> > the kernel and HW are the same.
>
> Error 4 means a read in userland on a not mapped area.
>
> The above isn't necessairly a kernel or hardware problem, it looks like
> an userland bug if it segfaults at such a low address (20f31). Nothig is
> mapped below "0x400000" exactly to catch these kind of bugs.

Which makes sense; the sed failures seen during 'make' runs were probably a 
result of the TLB flush filter errata on kernels prior to 2.6.14 , whereas 
the above is a userland bug which occurs with all kernels.

Andrew Walrond
