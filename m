Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUGWKEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUGWKEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 06:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267590AbUGWKEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 06:04:00 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:20373 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S267594AbUGWKC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 06:02:29 -0400
Date: Fri, 23 Jul 2004 12:01:01 +0200
From: Roger Luethi <rl@hellgate.ch>
To: zanussi@us.ibm.com
Cc: linux-kernel@vger.kernel.org, karim@opersys.com, richardj_moore@uk.ibm.com,
       bob@watson.ibm.com, michel.dagenais@polymtl.ca
Subject: Re: LTT user input
Message-ID: <20040723100101.GA22440@k3.hellgate.ch>
Mail-Followup-To: zanussi@us.ibm.com, linux-kernel@vger.kernel.org,
	karim@opersys.com, richardj_moore@uk.ibm.com, bob@watson.ibm.com,
	michel.dagenais@polymtl.ca
References: <16640.10183.983546.626298@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16640.10183.983546.626298@tut.ibm.com>
X-Operating-System: Linux 2.6.8-rc2-bk1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2004 15:47:03 -0500, zanussi@us.ibm.com wrote:
> One of the things people mentioned wanting to see during Karim's LTT
> talk at the Kernel Summit was cases where LTT had been useful to real
> users.  Here are some examples culled from the ltt/ltt-dev mailing
> lists:
[...]
> Another thing that came up was the impression that the overhead of
> tracing is too high.  I'm not sure where the number mentioned (5%)

The examples you mentioned confirm what Andrew mentioned recently:
What little public evidence there is comes from developers trying
to understand the kernel or debugging their own applications.

I'd be interested to see examples of how these tools help regular sys
admins or technically inclined users (no Aunt Tillie compatibility
required) -- IMO that would go a long way to make a case for inclusion [1].

Another concern raised at the summit (and what I am personally most
concerned about) is the overlap in all the frameworks that add logging
hooks for all kinds of purposes: auditing, performance, user level
debugging, etc.

Out of mainline examples that have been around for a while include:

- systrace http://niels.xtdnet.nl/systrace/
- syscalltrack http://syscalltrack.sourceforge.net/
- LTT http://www.opersys.com/LTT/

I wonder if a basic framework that can serve more than one purpose
makes sense.

When considering which tracing functionlity should be in mainline,
performance measurments for user-space come in pretty much at the
bottom of my list: Questions like "which process is overwriting this
config file behind my back" seem a lot more common and more likely to
be asked by people not willing or capable of compiling a patched kernel
for that purpose. And tools that are useful for kernel developers (while
unpopular with the powers that be) are nice to have in mainline because
as a kernel hacker, you often _have_ to debug the latest kernel for
which your favorite debug tool is not working yet. An argument for
adding security auditing to mainline is that it helps convince the
conservative and cautious security folks that the functionality is
accepted and here to stay.

None of these arguments apply for LTT as it presents itself: If you
are debugging or tuning a multi-threaded user space app or trying to
understand the kernel, patching some kernel supported by the respective
tool should hardly be a problem.

Please note that I just compared the relative merits of merging various
kinds of tracing functionality into mainline. I did not argue in favor
or against the inclusion of LTT-type functionality.

My point is that the best bet for tools that seem to aim at user-space
performance debugging is to demonstrate how they can be useful for a
wider audience, or to hitch a ride with a framework that does appeal
to a wider audience.

Roger

[1] You could take a page from how DTrace was introduced:
    http://www.sun.com/bigadmin/content/dtrace/
    Or take a look at:
    http://syscalltrack.sourceforge.net/when.html
    http://syscalltrack.sourceforge.net/examples.html
