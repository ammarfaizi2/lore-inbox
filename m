Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVBHPo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVBHPo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 10:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVBHPo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 10:44:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10699 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261544AbVBHPoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 10:44:18 -0500
Date: Tue, 8 Feb 2005 15:44:17 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@germaschewski.name>,
       linux-kernel@vger.kernel.org, dholland@eecs.harvard.edu
Subject: Re: [PATCH] Makefiles are not built using a Fortran compiler
Message-ID: <20050208154417.GH20386@parcelfarce.linux.theplanet.co.uk>
References: <20050208030228.GE20386@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.61.0502081322310.6118@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502081322310.6118@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 01:23:48PM +0100, Roman Zippel wrote:
> Enabling the following in the Makefile should have the same effect:
> 
> # For maximum performance (+ possibly random breakage, uncomment
> # the following)
> 
> #MAKEFLAGS += -rR

This reduces the debug output even further (and size of debug output is
strongly correlated with time taken to do a null build):

-rw-r--r--  1 willy willy 65582214 2005-02-07 21:13 vanilla.debug
-rw-r--r--  1 willy willy 51413770 2005-02-07 22:17 nosuffixes.debug
-rw-r--r--  1 willy willy 37245484 2005-02-08 09:56 maxperf.debug

Seems like it gets rid of the RCS and SCCS rules -- certainly a big
improvement, and I'm not sure anyone really uses those rules.  Can we
perhaps uncomment this line at the beginning of 2.6.12 and see if anyone
complains?  This should reduce make overhead by 30-40% which is really
worth doing.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
