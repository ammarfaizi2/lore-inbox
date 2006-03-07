Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWCGTgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWCGTgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWCGTgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:36:09 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:55263 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932074AbWCGTgH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:36:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eIG66LYWRzyL4gl6LnzPAt5Q8nxcx31BD6mDP06iHde5Stlk1gtr8YmbOHGbXpetCN7q/io/hK4Lxp5el1B/eXTIhOymA2UIHHorjbn2wuYfd8Ju2OlgPwXX+CiCm4xVyLQTeYXqXHaoKW2E6gpqjRN+PnYErO8Es+kl+AR45t8=
Message-ID: <84144f020603071136m21782038n8951c801627ae867@mail.gmail.com>
Date: Tue, 7 Mar 2006 21:36:04 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Jack Steiner" <steiner@sgi.com>
Subject: Re: [PATCH] - Allocate larger cache_cache if order 0 fails
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060307154805.GA3474@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060307154805.GA3474@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

On 3/7/06, Jack Steiner <steiner@sgi.com> wrote:
> -       cache_estimate(0, cache_cache.buffer_size, cache_line_size(), 0,
> -                      &left_over, &cache_cache.num);
> +       for (order = 0; order < MAX_ORDER; order++) {
> +               cache_estimate(order, cache_cache.buffer_size, cache_line_size(), 0,
> +                       &left_over, &cache_cache.num);
> +               if (cache_cache.num)
> +                       break;
> +       }

Any reason why you can't use calculate_slab_order() here?

                                   Pekka
