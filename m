Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268352AbUIKWji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268352AbUIKWji (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 18:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268355AbUIKWji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 18:39:38 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:31220 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268352AbUIKWjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 18:39:36 -0400
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
From: Albert Cahalan <albert@users.sf.net>
To: Roger Luethi <rl@hellgate.ch>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
In-Reply-To: <20040909212507.GA32276@k3.hellgate.ch>
References: <20040908184130.GA12691@k3.hellgate.ch>
	 <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil>
	 <20040909172200.GX3106@holomorphy.com>
	 <20040909175342.GA27518@k3.hellgate.ch>
	 <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil>
	 <20040909205531.GA17088@k3.hellgate.ch>
	 <20040909212507.GA32276@k3.hellgate.ch>
Content-Type: text/plain
Organization: 
Message-Id: <1094942212.1174.20.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Sep 2004 18:36:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 17:25, Roger Luethi wrote:
> On Thu, 09 Sep 2004 22:55:31 +0200, Roger Luethi wrote:
> > I used a somewhat different approach in my development tree (not
> > SELinuxy, though): Most fields were world readable, some required
> > credentials.
> 
> I forgot to mention that you can see the remnants of that approach in
> <linux/nproc.h>: I used two bits of the field ID to define per-field
> access restrictions (NPROC_PERM_USER, NPROC_PERM_ROOT).

Besides the low-security and high-security choices,
I'd like to see a medium-security choice.

low: everybody sees everything
medium: everybody sees something; privileged user sees all
high: must be privileged

This might mean that asking for stuff like EIP and WCHAN
causes you to see fewer processes.

If partial info is returned for a process, I'd like to
also get a bitmap of valid fields. Special "not valid"
values are a pain to deal with.


