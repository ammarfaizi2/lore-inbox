Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWBWQAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWBWQAn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWBWQAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:00:43 -0500
Received: from cantor2.suse.de ([195.135.220.15]:31937 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751501AbWBWQAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:00:42 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Date: Thu, 23 Feb 2006 17:00:35 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       mingo@elte.hu
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <1140707358.4672.67.camel@laptopd505.fenrus.org>
In-Reply-To: <1140707358.4672.67.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231700.36333.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 16:09, Arjan van de Ven wrote:

> This patch puts the infrastructure in place to allow for a reordering of
> functions based inside the vmlinux. The general idea is that it is possible
> to put all "common" functions into the first 2Mb of the code, so that they
> are covered by one TLB entry. This as opposed to the current situation where
> a typical vmlinux covers about 3.5Mb (on x86-64) and thus 2 TLB entries.
> (This patch depends on the previous patch to pin head.S as first in the order)

I think you would first need to move the code first for that. Currently it starts
at 1MB, which means 1MB is already wasted of the aligned 2MB TLB entry.

I wouldn't have a problem with moving the 64bit kernel to 2MB though.

> 
> I think that to get to a better list we need to invite people to submit
> their own profiles, and somehow add those all up and base the final list on
> that. I'm willing to do that effort if this is ends up being the prefered
> approach. Such an effort probably needs to be repeated like once a year or
> so to adopt to the changing nature of the kernel.

Looks reasonable. 

Afaik newer gcc can even separate likely and unlikely code into different sections.
I don't see you trying to handle that. 

Also if you're serious about saving TLBs it might be worth it to prereserve
some memory near the main kernel mapping for modules (e.g. with a boot option) 
and load them there. Then they would be covered with the same TLB entry too.

-Andi
