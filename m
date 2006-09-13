Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWIMTSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWIMTSA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWIMTR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:17:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:60678 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750937AbWIMTR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:17:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AV+mzwjm5ygyWjRM7Cf4DrLJelaYIpHtES3T0BG1eUtxBDt6KC5iinO6keboeFvDbngbegFl0++4xII7SwHpWkLvlHQ6OvGCItCFkdLoWInmVWABqIXr77TBx+qAxR+NZvlDZpIodwEgR5NB+hw7jb9jOBXKmOf142TshxDpatw=
Message-ID: <e9c3a7c20609131217q145fb234q36f70b23f1acf950@mail.gmail.com>
Date: Wed, 13 Sep 2006 12:17:55 -0700
From: "Dan Williams" <dan.j.williams@gmail.com>
To: "Jakob Oestergaard" <jakob@unthought.net>,
       "Dan Williams" <dan.j.williams@intel.com>, NeilBrown <neilb@suse.de>,
       linux-raid@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       christopher.leech@intel.com
Subject: Re: [PATCH 00/19] Hardware Accelerated MD RAID5: Introduction
In-Reply-To: <20060913071512.GA23492@unthought.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
	 <20060913071512.GA23492@unthought.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/06, Jakob Oestergaard <jakob@unthought.net> wrote:
> On Mon, Sep 11, 2006 at 04:00:32PM -0700, Dan Williams wrote:
> > Neil,
> >
> ...
> >
> > Concerning the context switching performance concerns raised at the
> > previous release, I have observed the following.  For the hardware
> > accelerated case it appears that performance is always better with the
> > work queue than without since it allows multiple stripes to be operated
> > on simultaneously.  I expect the same for an SMP platform, but so far my
> > testing has been limited to IOPs.  For a single-processor
> > non-accelerated configuration I have not observed performance
> > degradation with work queue support enabled, but in the Kconfig option
> > help text I recommend disabling it (CONFIG_MD_RAID456_WORKQUEUE).
>
> Out of curiosity; how does accelerated compare to non-accelerated?

One quick example:
4-disk SATA array rebuild on iop321 without acceleration - 'top'
reports md0_resync and md0_raid5 dueling for the CPU each at ~50%
utilization.

With acceleration - 'top' reports md0_resync cpu utilization at ~90%
with the rest split between md0_raid5 and md0_raid5_ops.

The sync speed reported by /proc/mdstat is ~40% higher in the accelerated case.

That being said, array resync is a special case, so your mileage may
vary with other applications.

I will put together some data from bonnie++, iozone, maybe contest,
and post it on SourceForge.

>  / jakob

Dan
