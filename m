Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262769AbVDHInW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVDHInW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbVDHIjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 04:39:39 -0400
Received: from [130.95.128.60] ([130.95.128.60]:25573 "EHLO
	asclepius.uwa.edu.au") by vger.kernel.org with ESMTP
	id S262753AbVDHIin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 04:38:43 -0400
X-UWA-Client-IP: 130.95.13.9 (UWA)
Date: Fri, 8 Apr 2005 16:38:08 +0800
From: Matt Johnston <matt@ucc.asn.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050408083807.GG373825@morwong.ucc.gu.uwa.edu.au>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-SpamTest-Info: Profile: Formal (218/050405)
X-SpamTest-Info: Profile: Detect Hard [UCS 290904]
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (UCS) [02-08-04]
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 09:42:04PM -0700, Linus Torvalds wrote:
> 
> On Thu, 7 Apr 2005, Chris Wedgwood wrote:
> > 
> > I'm playing with monotone right now.  Superficially it looks like it
> > has tons of gee-whiz neato stuff...  however, it's *agonizingly* slow.
> > I mean glacial.  A heavily sedated sloth with no legs is probably
> > faster.
> 
> Yes. The silly thing is, at least in my local tests it doesn't actually
> seem to be _doing_ anything while it's slow (there are no system calls
> except for a few memory allocations and de-allocations). It seems to have
> some exponential function on the number of pathnames involved etc.
> 
> I'm hoping they can fix it, though. The basic notions do not sound wrong.

That is indeed correct wrt pathnames. The current head of
monotone is a lot better in this regard (the order of 2-3
minutes for "monotone import" on a 2.6 linux untar). The
basic problem is that in the last release (0.17), a huge
amount of sanity checking code was added to ensure that
inconsistent or generally bad revisions can never be
written/received/transmitted.

The focus is now on speeding that up - there's a _lot_ of
low hanging fruit for us to look at.

Matt

