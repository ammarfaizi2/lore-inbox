Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWHAFBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWHAFBQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 01:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbWHAFBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 01:01:16 -0400
Received: from ozlabs.org ([203.10.76.45]:11476 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161015AbWHAFBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 01:01:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17614.55479.693532.236235@cargo.ozlabs.ibm.com>
Date: Tue, 1 Aug 2006 14:29:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Cc: linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org
Subject: Re: [PATCH] Missing failure handling
In-Reply-To: <20060720191629.GD7643@lumumba.uhasselt.be>
References: <20060720191629.GD7643@lumumba.uhasselt.be>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris writes:

> -	cardmap_set(&all_ppp_units, unit, ppp);
> +	ret = cardmap_set(&all_ppp_units, unit, ppp);
> +	if (ret != 0) {
> +		printk(KERN_ERR "PPP: couldn't set cardmap\n");	

This is a pretty useless message, in that it will mean nothing to a
user who sees it.  It would be better to set ret = -ENOMEM and not
print the message, I think.

Paul.
