Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVAGUFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVAGUFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVAGUEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:04:41 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:11752 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261581AbVAGUEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:04:10 -0500
Date: Fri, 7 Jan 2005 12:02:13 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Martin Hicks <mort@wildopensource.com>
cc: Marco Cipullo <cipullo@libero.it>, linux-kernel@vger.kernel.org
Subject: Re: From last __GFP_ZERO changes
In-Reply-To: <20050107193354.GT18461@localhost>
Message-ID: <Pine.LNX.4.58.0501071200280.28689@schroedinger.engr.sgi.com>
References: <200501061243.58968.cipullo@libero.it> <20050107193354.GT18461@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2005, Martin Hicks wrote:

>
> On Thu, Jan 06, 2005 at 12:43:58PM +0100, Marco Cipullo wrote:
> > From last __GFP_ZERO changes:
> >
> > --- a/drivers/block/pktcdvd.c	2005-01-06 03:27:45 -08:00
> > +++ b/drivers/block/pktcdvd.c	2005-01-06 03:27:45 -08:00
> > @@ -135,12 +135,10 @@
> >  		goto no_bio;
> >
> >  	for (i = 0; i < PAGES_PER_PACKET; i++) {
> > -		pkt->pages[i] = alloc_page(GFP_KERNEL);
> > +		pkt->pages[i] = alloc_page(GFP_KERNEL|| __GFP_ZERO);
> >
> > Is this OK?
> >
> > Or should be
> >
> >  	for (i = 0; i < PAGES_PER_PACKET; i++) {
> > -		pkt->pages[i] = alloc_page(GFP_KERNEL);
> > +		pkt->pages[i] = alloc_page(GFP_KERNEL| __GFP_ZERO);
>
> It definitely should be the latter.

Correct. Please submit the patch. I see a patch that fixes a pktcdvd.c
issue in Andrews tree so it was likely already fixed without me hearing of
it.
