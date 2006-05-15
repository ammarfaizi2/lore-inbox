Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWEOXIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWEOXIH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWEOXIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:08:06 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:43127 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1750737AbWEOXIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:08:04 -0400
X-IronPort-AV: i="4.05,131,1146466800"; 
   d="scan'208"; a="322314138:sNHT29403828"
To: ralphc@pathscale.com
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 53 of 53] ipath - add memory barrier when waiting for  writes
X-Message-Flag: Warning: May contain useful information
References: <f8ebb8c1e43635081b73.1147477418@eng-12.pathscale.com>
	<adazmhjth56.fsf@cisco.com>
	<1147727447.2773.14.camel@chalcedony.pathscale.com>
	<60844.71.131.57.117.1147734080.squirrel@rocky.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 16:08:03 -0700
In-Reply-To: <60844.71.131.57.117.1147734080.squirrel@rocky.pathscale.com> (ralphc@pathscale.com's message of "Mon, 15 May 2006 16:01:20 -0700 (PDT)")
Message-ID: <ada64k6sx7w.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 23:08:04.0043 (UTC) FILETIME=[6B6C31B0:01C67874]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    ralphc> I don't have a lot to add to this other than I looked at
    ralphc> the assembly code output for -Os and -O3 and both looked
    ralphc> OK.  I put the mb() in to be sure the writes were complete
    ralphc> and I found this to work by experimentation.  Without it,
    ralphc> the driver fails to read the EEPROM correctly.

Hmm, that doesn't give me a warm fuzzy feeling.  Basically on x86-64
you're adding an unneeded mfence instruction to work around
miscompilation?

Is i2c_wait_for_writes miscompiled without the mb() with -Os?  What
does the bad assembly look like?

 - R.
