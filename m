Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWD1DCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWD1DCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 23:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWD1DCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 23:02:17 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:40893 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030212AbWD1DCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 23:02:16 -0400
Date: Fri, 28 Apr 2006 08:29:27 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [Patch 5/8] taskstats interface
Message-ID: <20060428025927.GD14496@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <444991EF.3080708@watson.ibm.com> <444996FB.8000103@watson.ibm.com> <44501A97.2060104@engr.sgi.com> <445041EB.7080205@watson.ibm.com> <20060427064237.GA14496@in.ibm.com> <445104DC.90401@engr.sgi.com> <20060427182719.GC14496@in.ibm.com> <44511CCF.1080504@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44511CCF.1080504@engr.sgi.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If we envision a need of it in the future, we'd better put it in
> today. It would be nice to have the revision number at beginning of
> the struct. Shailabh's instruction says to add new field after existing
> fields.
>

Yes, true. It does not hurt to have a version number for taskstats.
I will add it in.

<snip>
 
> 
> I am sorry that i did not make myself clear. My suggestion of using
> the bitmask payload info is to be combined with #ifdef CONFIG_* to
> eliminate unnecessary fields from the traffic. I am concerned about
> losing data due to application not reading data fast enough.
> 
> Well, we can revisit this suggestion when we start losing data
> though. ;-)

Like Shailabh said #ifdef CONFIG_* adds complexity for userspace parsing
of the structure, but if it helps avoid sending unnecessary data we
can consider using that approach. 

Would something like the structure below be useful?

struct csastats {
#if defined(CONFIG_CSA) || defined(CONFIG_CSA_MODULE)
       char    acctent[sizeof(struct acctcsa) +
                       sizeof(struct acctmem) +
                       sizeof(struct acctio)];
       int     filled;
#endif
};

The filled member can be a bool or an int to indicate that the structure
contains meaningful data and the CONFIG_* is used to control the
inclusion of meaningful fields. Instead of using a bitmap we use
the filled member.

Is this what you had in mind?

-- 
					<---	Balbir
