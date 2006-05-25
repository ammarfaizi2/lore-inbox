Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbWEYIJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWEYIJy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 04:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbWEYIJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 04:09:54 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:41372 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S965055AbWEYIJx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 04:09:53 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17525.25911.460120.154875@gargle.gargle.HOWL>
Date: Thu, 25 May 2006 12:05:11 +0400
To: Martin Peschke <mp3@de.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 5/6] statistics infrastructure
Newsgroups: gmane.linux.kernel
In-Reply-To: <1148474038.2934.18.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
References: <1148474038.2934.18.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke writes:
 > This patch adds statistics infrastructure as common code.
 > 

[...]

 > +
 > +static void statistic_add_util(struct statistic *stat, int cpu,
 > +			       s64 value, u64 incr)
 > +{
 > +	struct statistic_entry_util *util = stat->pdata->ptrs[cpu];
 > +	util->num += incr;
 > +	util->acc += value * incr;
 > +	if (unlikely(value < util->min))
 > +		util->min = value;
 > +	if (unlikely(value > util->max))
 > +		util->max = value;

One useful aggregate that can be calculated here is a standard
deviation. Something like

        util->acc_sq += value * incr * value * incr; /* sum of squares */

And in statistic_fdata_util() squared standard deviation is

        std_dev = util->acc_sq;
        /*
         * Difference of averaged square and squared average.
         */
        std_dev = do_div(std_dev, util->num) - whole * whole;

 > +}

Nikita.
