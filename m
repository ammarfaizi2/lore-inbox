Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWGXX6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWGXX6j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 19:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWGXX6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 19:58:39 -0400
Received: from terminus.zytor.com ([192.83.249.54]:19616 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932336AbWGXX6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 19:58:38 -0400
Message-ID: <44C55E8F.2020200@zytor.com>
Date: Mon, 24 Jul 2006 16:58:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>,
       Pratap <pratap@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] cpuid neatening.
References: <1153526643.13699.18.camel@localhost.localdomain>	 <1153526798.13699.23.camel@localhost.localdomain> <1153527194.13699.34.camel@localhost.localdomain>
In-Reply-To: <1153527194.13699.34.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Roll all the cpuid asm into one __cpuid call.  It's a little neater,
> and also means only one place to patch for paravirtualization.

The whole point of those is to avoid the unnecessary write to memory and 
pick it back up again.  This patch reintroduces that ugliness.

You don't want to make it the obvious multi-return macro, either, 
because that code is known to break some old versions of gcc.

	-hpa
