Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVIVU7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVIVU7w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVIVU7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:59:52 -0400
Received: from isilmar.linta.de ([213.239.214.66]:50050 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751190AbVIVU7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:59:51 -0400
Date: Thu, 22 Sep 2005 22:59:45 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [Fwd: sched_clock() has poor resolution]
Message-ID: <20050922205945.GB30068@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	john stultz <johnstul@us.ibm.com>
References: <43325D31.3090604@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43325D31.3090604@drzeus.cx>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 22, 2005 at 09:28:49AM +0200, Pierre Ossman wrote:
>  * Let sched_clock() follow the time source. Don't have it coupled to
> the TSC.
> 
>  * Init the TSC even though it isn't used for anything but sched_clock().

As pmtmr requires somewhat working TSCs, you can even use TSC if pmtmr is
used as a time source:

static int init_pmtmr(char* override)
...
        /* we use the TSC for delay_pmtmr, so make sure it exists */
        if (!cpu_has_tsc)
                return -ENODEV;
...

So at least for this case, sched_clock() can and should use TSC, not
jiffies, AFAICS.

Thanks,
	Dominik
