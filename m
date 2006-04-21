Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWDUQD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWDUQD1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWDUQD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:03:26 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:21299 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932378AbWDUQDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:03:25 -0400
Subject: Re: kfree(NULL)
From: Daniel Walker <dwalker@mvista.com>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4448F97D.5000205@imap.cc>
References: <63XWg-1IL-5@gated-at.bofh.it> <63YfP-26I-11@gated-at.bofh.it>
	 <63ZEY-45n-27@gated-at.bofh.it>  <4448F97D.5000205@imap.cc>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 09:03:23 -0700
Message-Id: <1145635403.20843.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 17:25 +0200, Tilman Schmidt wrote:
> On 21.04.2006 11:00, Andrew Morton wrote:
> 
> > James Morris <jmorris@namei.org> wrote:
> > 
> >>On Fri, 21 Apr 2006, Daniel Walker wrote:
> >>
> >>>	I included a patch , not like it's needed . Recently I've been
> >>>evaluating likely/unlikely branch prediction .. One thing that I found 
> >>>is that the kfree function is often called with a NULL "objp" . In fact
> >>>it's so frequent that the "unlikely" branch predictor should be inverted!
> >>>Or at least on my configuration. 
> >>
> >>It would be helpful to collect some stats on this so we can look at the 
> >>ratio.
> > 
> > Yes, kfree(NULL) is supposed to be uncommon.
> 
> Not anymore, after the recent campaign to elliminate explicit NULL
> checks before calls to kfree().
> 
> > If someone's doing it a lot then we should fix up the callers.
> 
> If that fixup amounts to re-adding the NULL check just elliminated
> then that's no improvement. It would be better to drop the assumption
> that kfree() calls with a NULL argument are uncommon, and consequently
> remove the unlikely() predictor. Adding likely() instead may or may
> not be a good idea.


After reviewing some of the callers of kfree(NULL) they appear to be
errors by the caller .. Where there's some false assumptions going on
during looping or repeated calls to the same function. 

I agree with Andrew , I think the calls should be investigated while
retaining the unlikley() predictor . 

Daniel

