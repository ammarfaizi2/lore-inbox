Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWDKHyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWDKHyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 03:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWDKHyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 03:54:51 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:21453 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932334AbWDKHyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 03:54:50 -0400
Date: Tue, 11 Apr 2006 01:54:40 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, kiran@scalex86.org, Laurent.Vivier@bull.net,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/3] per cpu counter fixes for unsigned long type counter overflow
Message-ID: <20060411075440.GQ17364@schatzie.adilger.int>
Mail-Followup-To: Mingming Cao <cmm@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, kiran@scalex86.org,
	Laurent.Vivier@bull.net, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
References: <1144691947.3964.54.camel@dyn9047017067.beaverton.ibm.com> <20060410151817.27766565.akpm@osdl.org> <1144717779.3964.93.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144717779.3964.93.camel@dyn9047017067.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 10, 2006  18:09 -0700, Mingming Cao wrote:
> +static void __percpu_counter_mod(struct percpu_counter *fbc, long amount,
> +				int ul_overflow_check)
>  {
> +		 *  Before updating the global counter, if we detect the
> +		 *  updated new value will cause overflow, then we should not
> +		 *  do the update from this local counter at this moment. (i.e.
> +		 *  the local counter will not be cleared right now). The update
> +		 *  will be deferred at some point until either other local
> +		 *  counter updated the global counter first, or the local
> +		 *  counter's value will not cause global counter overflow.

Wouldn't it be better to update the counter by the maximum amount possible
to avoid overflow/underflow?

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

