Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030943AbWFOSPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030943AbWFOSPA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 14:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030945AbWFOSO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 14:14:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58529 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030943AbWFOSO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 14:14:59 -0400
Date: Thu, 15 Jun 2006 11:14:47 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: light weight counters: race free through local_t?
In-Reply-To: <44918EE5.2060302@bull.net>
Message-ID: <Pine.LNX.4.64.0606151110100.9618@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606092212200.4875@schroedinger.engr.sgi.com>
 <449033B0.1020206@bull.net> <Pine.LNX.4.64.0606140928500.4030@schroedinger.engr.sgi.com>
 <44915110.2050100@bull.net> <Pine.LNX.4.64.0606150855410.9137@schroedinger.engr.sgi.com>
 <44918EE5.2060302@bull.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given what you just said it seems that an atomic op is better than first 
reading the cacheline and then incrementing a value in it right? Because 
if we first read then we acquire the cacheline in shared more. Later when 
we write to it we have to acquire it again in exclusive mode. The fetchadd 
would acquire the cacheline immediately in exclusive mode and thus save 
the acquisition in shared mode.

> Yes, it is a one-direction barrier.
> However, if there is not too many stuff in the OzQ, it has not too much
> impact.

It serializes prior accesses and has a simiar effect as an unlock 
operation. The processor cannot freely reorder instructions around the 
increment. That must have some sort of an impact on performance.

> I still prefer the atomic operations.

Noted. Andi: It seems that we can fall back on ia64 to an atomic 
operation without concern for performance.
 
