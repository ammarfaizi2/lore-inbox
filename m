Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293059AbSBWAmg>; Fri, 22 Feb 2002 19:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293061AbSBWAmQ>; Fri, 22 Feb 2002 19:42:16 -0500
Received: from holomorphy.com ([216.36.33.161]:40873 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S293059AbSBWAmN>;
	Fri, 22 Feb 2002 19:42:13 -0500
Date: Fri, 22 Feb 2002 16:41:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Larson <plars@austin.ibm.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [PATCH] 2.4.18-rc2 Fix for get_pid hang
Message-ID: <20020223004143.GL3511@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Paul Larson <plars@austin.ibm.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org, manfred@colorfullife.com
In-Reply-To: <1014416988.12007.461.camel@plars.austin.ibm.com> <E16eQ4R-0003cZ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <E16eQ4R-0003cZ-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Paul Larson wrote:
>> This was made against 2.4.18-rc2 but applies cleanly against
>> 2.4.18-rc4.  This is a fix for a problem where if we run out of
>> available pids, get_pid will hang the system while it searches
>> through the tasks for an available pid forever.

On Sat, Feb 23, 2002 at 12:29:47AM +0000, Alan Cox wrote:
> Wouldn't it be a much cleaner patch to limit the maximum number of
> processes to less than the number of pids available. You seem to be
> fixing a non problem by adding branches to the innards of a loop.

I've seen this one before. It seems to kick in at 11K processes, where
one would normally expect it much higher... so I'm not sure a constant
upper bound on that counter suffices. Maybe clashes of pid's with pgrp's
and sessions and tgrps are what does that, maybe it's something else.

and of course:

#include <stdgeek.h>  /* Any hope of a non-O(tasks) solution? */


Cheers,
Bill
