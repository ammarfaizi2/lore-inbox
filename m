Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbVKCEf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbVKCEf4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 23:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbVKCEf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 23:35:56 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:36615 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751594AbVKCEfz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 23:35:55 -0500
Date: Thu, 3 Nov 2005 00:26:49 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Rob Landley <rob@landley.net>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       user-mode-linux-devel@lists.sourceforge.net,
       Yasunori Goto <y-goto@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Mel Gorman <mel@csn.ul.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051103052649.GA16508@ccure.user-mode-linux.org>
References: <1130917338.14475.133.camel@localhost> <20051102172729.9E7C.Y-GOTO@jp.fujitsu.com> <43687C3D.7060706@yahoo.com.au> <200511021728.36745.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511021728.36745.rob@landley.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 05:28:35PM -0600, Rob Landley wrote:
> With fragmentation reduction and prezeroing, UML suddenly gains the option of 
> calling madvise(DONT_NEED) on sufficiently large blocks as A) a fast way of 
> prezeroing, B) a way of giving memory back to the host OS when it's not in 
> use.

DONT_NEED is insufficient.  It doesn't discard the data in dirty
file-backed pages.

Badari Pulavarty has a test patch (google for madvise(MADV_REMOVE))
which does do the trick, and I have a UML patch which adds memory
hotplug.  This combination does free memory back to the host.

				Jeff
