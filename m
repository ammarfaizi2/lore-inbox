Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbUBZF7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 00:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbUBZF7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 00:59:41 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:37382 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S262696AbUBZF7f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 00:59:35 -0500
Date: Wed, 25 Feb 2004 21:59:32 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
Message-ID: <20040226055932.GB8910@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <m3ptc3otbn.fsf@zoo.weinigel.se> <Pine.LNX.4.44.0402252133300.18217-100000@lugburz.zadnik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402252133300.18217-100000@lugburz.zadnik.org>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may cause mental anguish to the close-minded. Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 09:46:59PM +0200, Grigor Gatchev wrote:
> 
> 
> On 25 Feb 2004, Christer Weinigel wrote:
> 
> > Just because there's an academic paper written about something doesn't
> > mean that its right.  For once Richard is partially right, unneccesary
> > layering can really ruin a system.  Grigor said that in 25 years he
> > has seen few cases of pretty code performing badly, but look at the
> > failure of SysV streams, it's a really pretty layering model, but in
> > practice it turns out to be too slow for most anything useful.
> >
> > It's not too uncommon with drivers that breaks just because the actual
> > hardware won't fit into the model that is exposed via a layer.  For
> > example, look at the error recovery of the old Linux SCSI code: it's
> > hard to do proper error recovery, and it is much slower than it needs
> > to because first the low level driver tries to do error recovery and
> > later on the higher layers try to do error recovery too.  Multiply a
> > couple of retries in the SCSI middle layer with another couple of
> > retries after a timeout a few seconds at the SCSI controller layer and
> > you have a model where it takes a minute to do figure out that
> > something is wrong, for something that ought to take just a few
> > seconds.
> >
> > Additionally, because of the strict layering it's not always possible
> > to hand up a meaningful error status from the lower layers to the
> > higher layers, it gets lost in the middle just because it didn't fit
> > into the layers model of the world.  It can also mean that it's not
> > possible to use the intelligent features of a smart SCSI controller
> > that can do complex error recovery on its own since most layers end up
> > exposing only the "least common denominator".
> 
> I may be wrong, but this description seems to me more like an example for
> bad design and implementation rather than for a bad general idea.

It may be both.  I don't think the resistance is to layering
as a general idea.  The resistance is to rigidly (read
explicitly) defined layers.

The 7 (if my memory serves) layer ISO networking definition is
perhaps a better example.  I can't recall hearing of any
implementation with decent performance that conforms to the
ISO definition of the layer boundaries.

What seems a good boundary at one time will likely prove a
poor one later.  Or what may be good in the general can slow
down the whole system because of one specific subsection
where it is suboptimal.

The best is to keep layering in mind (which is already the
case) but to remain flexible, functional specific and
mutable. 


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
