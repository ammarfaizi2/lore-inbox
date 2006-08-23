Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWHWMJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWHWMJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWHWMJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:09:34 -0400
Received: from ns1.suse.de ([195.135.220.2]:38378 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932439AbWHWMJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:09:33 -0400
To: Akinobu Mita <mita@miraclelinux.com>
Cc: akpm@osdl.org, okuji@enbug.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/5] fail-injection library
References: <20060823113243.210352005@localhost.localdomain>
	<20060823113316.560762676@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 23 Aug 2006 14:09:31 +0200
In-Reply-To: <20060823113316.560762676@localhost.localdomain>
Message-ID: <p73hd0364ck.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita <mita@miraclelinux.com> writes:
> +	if (failure_probability(data) == 100 ||
> +	    INT_MAX / 100 * failure_probability(data) > get_random_int())

I don't think it's a good idea to use get_random_int here. It's a secure
quite heavyweight random simulator that eats up precious entropy.

I would use something simple with an option for the user to specify the seed
(default jiffies maybe) for reproducibility.

e.g. the perfmon patchkit that was just posted had a reasonable simple
pseudo RND for lib/. Maybe you can reuse that.

-Andi
