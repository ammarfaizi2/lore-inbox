Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751996AbWCBQ6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbWCBQ6T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWCBQ6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:58:19 -0500
Received: from soundwarez.org ([217.160.171.123]:5253 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751996AbWCBQ6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:58:18 -0500
Date: Thu, 2 Mar 2006 17:58:16 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: ambx1@neo.rr.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-ID: <20060302165816.GA13127@vrfy.org>
References: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx> <20060301194532.GB25907@vrfy.org> <4406AF27.9040700@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4406AF27.9040700@drzeus.cx>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 09:39:03AM +0100, Pierre Ossman wrote:
> Kay Sievers wrote:
> > On Mon, Feb 27, 2006 at 10:40:19PM +0100, Pierre Ossman wrote:
> >> User space hardware detection need the 'modalias' attributes in the
> >> sysfs tree. This patch adds support to the PNP bus.
> > 
> >> +
> >> +	/* FIXME: modalias can only do one alias */
> >> +	return sprintf(buf, "pnp:c%s\n", pos->id);
> > 
> > Without the FIXME actually "fixed", this does not make sense. You want to
> > match always on _all_ aliases. In most cases where you have more than
> > one, the first one is the vendor specific one which isn't interesting at
> > all on Linux. If you have more than one entry usually the second one is the
> > one you are looking for.
> > 
> > So eighter we find a way to encode _all_ id's in one modalias string which can
> > be matched by a wildcard or keep the current solution which iterates over the
> > sysfs "id" file and calls modprobe for every entry.
> > 
> 
> That's a bit harsh. Although the FIXME is a downer, this patch is a
> strict addition of functionality, not removal. It solves a real problem
> for me, and it does so without removing any functionality for anyone
> else. The fact is that most PNP devices do not have multiple id:s (at
> least the ACPI variant which is the most common in todays machines), so
> the problem is not near as big as you make it out to be.

Sorry, but your patch is just incomplete and in some cases just wrong.
On my new ThinkPad, 3 of 12 devices would not work with your patch, so this
is far from "most common" and not acceptable. So eighter we get a fully
working modalias or we better stay without one for PNP and handle that
with the custom script we already use today.

Kay
