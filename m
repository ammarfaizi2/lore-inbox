Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268576AbUILJyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268576AbUILJyu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 05:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268577AbUILJyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 05:54:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:62848 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268576AbUILJys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 05:54:48 -0400
Date: Sun, 12 Sep 2004 11:51:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912095118.GA11814@elte.hu>
References: <20040912085609.GK32755@krispykreme> <20040912093605.GJ2660@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912093605.GJ2660@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Lee Irwin III <wli@holomorphy.com> wrote:

> +		if (map > &pidmap_array[pid_max/BITS_PER_PAGE])
> +			map = pidmap_array;

> -	if (offset >= BITS_PER_PAGE)
> +	pid = (map - pidmap_array) * BITS_PER_PAGE + offset;
> +	if (offset >= BITS_PER_PAGE || pid >= pid_max)
>  		goto next_map;
>  	if (test_and_set_bit(offset, map->page))
>  		goto scan_more;
> -
>  	/* we got the PID: */
> -	pid = (map - pidmap_array) * BITS_PER_PAGE + offset;
>  	goto return_pid;

i missed the wrapping, so your patch is the right one:

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
