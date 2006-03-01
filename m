Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWCAKuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWCAKuR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWCAKuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:50:17 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:27321 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030184AbWCAKuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:50:15 -0500
Message-ID: <44057B46.1010403@sgi.com>
Date: Wed, 01 Mar 2006 11:45:26 +0100
From: Jes Sorensen <jes@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bryan O'Sullivan" <bos@pathscale.com>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
References: <1140841250.2587.33.camel@localhost.localdomain>	 <yq08xrvhkee.fsf@jaguar.mkp.net> <1141149475.24103.18.camel@camp4.serpentine.com>
In-Reply-To: <1141149475.24103.18.camel@camp4.serpentine.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan wrote:
> On Tue, 2006-02-28 at 05:01 -0500, Jes Sorensen wrote:
> 
> 
>>Could you explain why the current mmiowb() API won't suffice for this?
>>It seems that this is basically trying to achieve the same thing.
> 
> 
> It's a no-op on every arch I care about:
> 
> #define mmiowb()
> 
> Which makes it useless.  Also, based on the comments in the qla driver,
> mmiowb() seems to have inter-CPU ordering semantics that I don't want.
> I'm thus hesitant to appropriate it for my needs.

The fact that it's a no-op may simply be because nobody on a specific
arch got to the point where it made sense to define it yet.

Anyway, based on Jesse and Jeremy's comments, then maybe the semantics
here are different. However I do think the name wc_wmb() isn't quite
defining it. If it's only to be used on mmio space, something like
mmio_wc_wmb() would probably be more descriptive.

Cheers,
Jes
