Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUESOoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUESOoO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 10:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbUESOoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 10:44:14 -0400
Received: from nevyn.them.org ([66.93.172.17]:26798 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261239AbUESOmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 10:42:54 -0400
Date: Wed, 19 May 2004 10:42:28 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Andi Kleen <ak@suse.de>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] Remove bogus WARN_ON in futex_wait
Message-ID: <20040519144228.GA6789@nevyn.them.org>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Muli Ben-Yehuda <mulix@mulix.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, rusty@rustcorp.com.au
References: <20040519122350.2792e050.ak@suse.de> <20040519104339.GG31630@mulix.org> <20040519125001.3866f830.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519125001.3866f830.ak@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 12:50:01PM +0200, Andi Kleen wrote:
> On Wed, 19 May 2004 13:43:40 +0300
> Muli Ben-Yehuda <mulix@mulix.org> wrote:
> 
> > On Wed, May 19, 2004 at 12:23:50PM +0200, Andi Kleen wrote:
> > > 
> > > futex_wait goes to an interruptible sleep, but does a WARN_ON later
> > > if it wakes up early. But waking up early is totally legal, since
> > > the sleep is interruptible and any signal can wake it up.
> > 
> > That's not what the WARN_ON is saynig, unless I'm missing
> > something. It's checking if we were woken up early and there's no
> > signal pending for us. 
> 
> True. Anyways, it seems to happen in practice.

I'm guessing that at least one of the ways to trigger this is with
ptrace.  Linux has a nasty habit of waking "wake on signal" sleeps
without a signal if ptrace cancels the signal.

-- 
Daniel Jacobowitz
