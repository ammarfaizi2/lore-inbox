Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbULVJff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbULVJff (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 04:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbULVJff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 04:35:35 -0500
Received: from [62.206.217.67] ([62.206.217.67]:56259 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261953AbULVJfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 04:35:31 -0500
Message-ID: <41C93FAB.9090708@trash.net>
Date: Wed, 22 Dec 2004 10:34:35 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Matt Mackall <mpm@selenic.com>, Mark Broadbent <markb@wetlettuce.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
References: <20041217233524.GA11202@electric-eye.fr.zoreil.com> <36901.192.102.214.6.1103535728.squirrel@webmail.wetlettuce.com> <20041220211419.GC5974@waste.org> <20041221002218.GA1487@electric-eye.fr.zoreil.com> <20041221005521.GD5974@waste.org> <52121.192.102.214.6.1103624620.squirrel@webmail.wetlettuce.com> <20041221123727.GA13606@electric-eye.fr.zoreil.com> <49295.192.102.214.6.1103635762.squirrel@webmail.wetlettuce.com> <20041221204853.GA20869@electric-eye.fr.zoreil.com> <20041221212737.GK5974@waste.org> <20041221225831.GA20910@electric-eye.fr.zoreil.com>
In-Reply-To: <20041221225831.GA20910@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Marc, if the patch below happens to work, it should not drop messages
> like the previous one (it is an ugly short-term suggestion).
> 

> -	spin_lock(&np->dev->xmit_lock);
> +	while (!spin_trylock(&np->dev->xmit_lock)) {
> +		if (np->dev->xmit_lock_owner == smp_processor_id()) {
> +			struct Qdisc *q = dev->qdisc;
> +
> +			q->ops->enqueue(skb, q);

Shouldn't this be requeue ?

Regards
Patrick
