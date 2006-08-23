Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWHWMHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWHWMHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWHWMHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:07:13 -0400
Received: from mx1.suse.de ([195.135.220.2]:21994 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932435AbWHWMHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:07:11 -0400
To: Akinobu Mita <mita@miraclelinux.com>
Cc: akpm@osdl.org, okuji@enbug.org, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 4/5] fail-injection capability for disk IO
References: <20060823113243.210352005@localhost.localdomain>
	<20060823113317.722640313@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 23 Aug 2006 14:07:10 +0200
In-Reply-To: <20060823113317.722640313@localhost.localdomain>
Message-ID: <p73lkpf64gh.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita <mita@miraclelinux.com> writes:
>   * @bio:  The bio describing the location in memory and on the device.
> @@ -3077,6 +3093,9 @@ end_io:
>  		if (unlikely(test_bit(QUEUE_FLAG_DEAD, &q->queue_flags)))
>  			goto end_io;
>  
> +		if (should_fail(fail_make_request, bio->bi_size))
> +			goto end_io;

AFAIK it is reasonably easy to write stacking block drivers.
I think I would prefer a stackable driver instead of this hook.

-Andi
