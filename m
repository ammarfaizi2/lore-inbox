Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966111AbWKUJHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966111AbWKUJHi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 04:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966362AbWKUJHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 04:07:38 -0500
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:50841
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S966111AbWKUJHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 04:07:36 -0500
From: Michael Buesch <mb@bu3sch.de>
To: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 46/61] fix Intel RNG detection
Date: Tue, 21 Nov 2006 10:05:35 +0100
User-Agent: KMail/1.9.5
References: <20061101053340.305569000@sous-sol.org> <20061101054343.623157000@sous-sol.org> <20061120234535.GD17736@redhat.com>
In-Reply-To: <20061120234535.GD17736@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jan Beulich <jbeulich@novell.com>,
       Metathronius Galabant <m.galabant@googlemail.com>,
       Michael Buesch <mb@bu3sch.de>, Greg Kroah-Hartman <gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611211005.35984.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 November 2006 00:45, Dave Jones wrote:
> On Tue, Oct 31, 2006 at 09:34:26PM -0800, Chris Wright wrote:
>  
>  > From: Jan Beulich <jbeulich@novell.com>
>  > 
>  > [PATCH] fix Intel RNG detection
>  > 
>  > Previously, since determination whether there was an Intel random number
>  > generator was based on a single bit, on systems with a matching bridge
>  > device but without a firmware hub, there was a 50% chance that the code
>  > would incorrectly decide that the system had an RNG.  This patch adds
>  > detection of the firmware hub to better qualify the existence of an RNG.
>  > 
>  > There is one issue with the patch: I was unable to determine the LPC
>  > equivalent for the PCI bridge 8086:2430 (since the old code didn't care
>  > about which of the many devices provided by the ICH/ESB it was chose to use
>  > the PCI bridge device, but the FWH settings live in the LPC device, so the
>  > device list needed to be changed).
>  > 
>  > Signed-off-by: Jan Beulich <jbeulich@novell.com>
>  > Signed-off-by: Michael Buesch <mb@bu3sch.de>
>  > Signed-off-by: Andrew Morton <akpm@osdl.org>
>  > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>  > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>  > Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> 
> 
> Since I pushed an update to our Fedora users based on 2.6.18.2, a few people
> have reported they no longer have their RNG's detected.
> Here's one report: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=215144

Well, this patch should acutally fix false detections.
Did these people actually have a _working_ rng before?
I saw a report of a mac user, for which the rng disappeared. But
the previously "detected" rng didn't work either. (Work as in produces
sane random numbers). So there actually wasn't a rng available all the time.

-- 
Greetings Michael.
