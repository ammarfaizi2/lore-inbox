Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVDKHjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVDKHjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 03:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVDKHjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 03:39:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:1976 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261716AbVDKHjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 03:39:10 -0400
Date: Mon, 11 Apr 2005 09:38:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       David Woodhouse <dwmw2@infradead.org>, Chris Mason <mason@suse.com>
Subject: Re: New SCM and commit list
Message-ID: <20050411073844.GA5485@elte.hu>
References: <1113174621.9517.509.camel@gaston> <Pine.LNX.4.58.0504101621200.1267@ppc970.osdl.org> <425A10EA.7030607@pobox.com> <Pine.LNX.4.58.0504102304050.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504102304050.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Then the bad news: the merge algorithm is going to suck. It's going to 
> be just plain 3-way merge, the same RCS/CVS thing you've seen before.  
> With no understanding of renames etc. I'll try to find the best parent 
> to base the merge off of, although early testers may have to tell the 
> piece of crud what the most recent common parent was.
> 
> So anything that got modified in just one tree obviously merges to 
> that version. Any file that got modified in two trees will end up just 
> being passed to the "merge" program. See "man merge" and "man diff3".  
> The merger gets to fix up any conflicts by hand.

at that point Chris Mason's "rej" tool is pretty nifty:

  ftp://ftp.suse.com/pub/people/mason/rej/rej-0.13.tar.gz

it gets the trivial rejects right, and is pretty powerful to quickly 
cycle through the nontrivial ones too. It shows the old and new code 
side by side too, etc.

(There is no fully automatic mode in where it would not bother the user 
with the really trivial rejects - but it has an automatic mode where you 
basically have to do nothing - maybe a fully automatic one could be 
added that would resolve low-risk rejects?)

it's really easy to use (but then again i'm a vim user, so i'm biased), 
just try it on a random .rej file you have ("rej -a kernel/sched.c.rej" 
or whatever).

	Ingo
