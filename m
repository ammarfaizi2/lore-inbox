Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264460AbTCXWM4>; Mon, 24 Mar 2003 17:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264457AbTCXWMz>; Mon, 24 Mar 2003 17:12:55 -0500
Received: from bitmover.com ([192.132.92.2]:10136 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264460AbTCXWMN>;
	Mon, 24 Mar 2003 17:12:13 -0500
Date: Mon, 24 Mar 2003 14:23:17 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Larry McVoy <lm@bitmover.com>, Andrew Morton <akpm@digeo.com>,
       venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: lmbench results for 2.4 and 2.5 -- updated results
Message-ID: <20030324222317.GB11421@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, Andrew Morton <akpm@digeo.com>,
	venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <C8C38546F90ABF408A5961FC01FDBF19010485F1@fmsmsx405.fm.intel.com> <20030324200105.GA5522@work.bitmover.com> <543480000.1048540161@flay> <20030324153602.28b44e23.akpm@digeo.com> <20030324220435.GA11421@work.bitmover.com> <546310000.1048543470@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546310000.1048543470@flay>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mmmm. Any idea why the results are so dramtically different? 655 vs 809?

Yeah, two run-away mutt processes (*) eating up all the CPU.  When ENOUGH 
is small, i.e., less than a second or so, LMbench does a series of tests
and takes the mean (I believe, look at the source, lib_timing.c and *.h).
When ENOUGH is big it just does one run and reports that.  So the big run
was long enough it was competing for time slices and the default ones are
short enough they get the whole slice.  It's actually possible to run
LMbench on a loaded system and get fairly accurate results if you have 
a decent enough clock.  

(*) I use rsh to get into the main machine here and ever since Red Hat 7.?
if I'm rsh-ed in from a laptop, put the laptop to sleep and the connection
gets dropped, my mutt sessions don't get SIGHUP or whatever they should 
get and they start sucking up CPU like there is no tomorrow.  Does anyone
know of a fix for this?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
