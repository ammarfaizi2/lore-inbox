Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVHaTrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVHaTrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 15:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVHaTrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 15:47:08 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45680
	"EHLO g5.random") by vger.kernel.org with ESMTP id S1751023AbVHaTrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 15:47:08 -0400
Date: Wed, 31 Aug 2005 21:47:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: tony.luck@intel.com
Cc: Bill Davidsen <davidsen@tmr.com>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050831194701.GP1614@g5.random>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> <20050830082901.GA25438@bitwizard.nl> <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de> <20050830094058.GA29214@bitwizard.nl> <4314D98E.2030801@tmr.com> <200508311914.j7VJEN7M009450@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508311914.j7VJEN7M009450@agluck-lia64.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 12:14:23PM -0700, tony.luck@intel.com wrote:
> Do you want to try to handle version skew ?  All kernels built
> from GIT trees look like 2.6.13 until Linus releases 2.6.14-rc1.
> Possible approaches (requiring changes to the kernel Makefile).
> 1) Use the SHA1 of HEAD to provide a precise identification.
> 2) Use $(git-rev-tree linus ^v${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION} | wc -l)
> to get an approximate distance from the base version
> 
> Another version issue is use of "localversion" ... I use it to tag
> kernels with a summary of the config file I used during build (e.g.
> -tiger-smp, or -generic-up).  Looking at the results you've collected
> so far, there appear to be a variety of other conventions in use
> that prevent aggregation of results.

Aggregation of results seems the biggest problem right now. If we add
the git tag we really have to aggregate the git revisions before showing
the main page (or there would be too many of them). So we need at least
a standard way to do that. Perhaps it's simpler to export it via
readonly sysctl or with /proc and passed separately to the server (not
mixed in the uname strings)? I can extend the protocol without
invalidating the old clients and old data.

I'm thinking to add optional aggregations for (\d+)\.(\d+)\.(\d+)\D and
for different archs. So you can watch ia64 only or 2.6.13 only etc...

The "-tiger-smp/-generic-up" makes life harder indeed ;).

If there was a more standard way to add extraversions and localversions
aggregation would be easier and more reliable.
