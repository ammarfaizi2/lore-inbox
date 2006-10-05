Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWJEVnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWJEVnV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWJEVnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:43:12 -0400
Received: from gw.goop.org ([64.81.55.164]:60113 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932271AbWJEVnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:43:04 -0400
Message-ID: <45257C65.3030600@goop.org>
Date: Thu, 05 Oct 2006 14:43:01 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       tim.c.chen@linux.intel.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
References: <B41635854730A14CA71C92B36EC22AAC3F3FBA@mssmsx411> <20061005143748.2f6594a2.akpm@osdl.org>
In-Reply-To: <20061005143748.2f6594a2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> So how's this look?
>   

Looks fine to me.  Other than the general question of why WARN_ON* 
returns a value at all, and if so, does the final unlikely() really do 
anything.

> I worry a bit that someone's hardware might go and prefetch that static
> variable even when we didn't ask it to.  Can that happen?
>   

Sure, the CPU has the option, but if it goes around speculatively 
polluting its caches with unused stuff, it isn't going to perform very 
well in general.  So presumably the CPU won't do it unless it really 
thinks it will help.

    J
