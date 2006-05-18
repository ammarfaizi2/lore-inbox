Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWERFRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWERFRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 01:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWERFRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 01:17:52 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:24950 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1751140AbWERFRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 01:17:51 -0400
X-IronPort-AV: i="4.05,139,1146466800"; 
   d="scan'208"; a="1808296449:sNHT29301516"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Dave Olson <olson@unixfolk.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 35 of 53] ipath - some interrelated stability and cleanliness fixes
X-Message-Flag: Warning: May contain useful information
References: <fa.2ho1QSA8Kf7L8EFqp3rLsB7NE9s@ifi.uio.no>
	<fa.yXZlqXBzNi9Gq/4Q6Wc9H6bw+lU@ifi.uio.no>
	<Pine.LNX.4.61.0605170944570.22323@osa.unixfolk.com>
	<ada4pzo5xti.fsf@cisco.com>
	<Pine.LNX.4.61.0605172113480.23165@osa.unixfolk.com>
	<adaac9g3pae.fsf@cisco.com>
	<1147929311.3094.16.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 17 May 2006 22:17:50 -0700
In-Reply-To: <1147929311.3094.16.camel@localhost.localdomain> (Bryan O'Sullivan's message of "Wed, 17 May 2006 22:15:11 -0700")
Message-ID: <adau07n3o8x.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 18 May 2006 05:17:50.0550 (UTC) FILETIME=[686FFF60:01C67A3A]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> Wow.  I have no idea where that extra "goto bail" came
    Bryan> from.  It's not supposed to be there.

Even without it you still leak the work structure, because there's no
schedule_work().

Now that I look at it, in uverbs_mem.c, the mm will be leaked if the
kmalloc fails...

 - R.
