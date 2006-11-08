Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753789AbWKHAmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbWKHAmz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 19:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753791AbWKHAmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 19:42:55 -0500
Received: from ozlabs.org ([203.10.76.45]:8839 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1753789AbWKHAmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 19:42:55 -0500
Subject: Re: [PATCH] Fix kunmap_atomic's use of kpte_clear_flush()
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4551232A.4020203@goop.org>
References: <4551232A.4020203@goop.org>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 11:42:52 +1100
Message-Id: <1162946572.29130.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 16:22 -0800, Jeremy Fitzhardinge wrote:
> kunmap_atomic() will call kpte_clear_flush with vaddr/ptep arguments
> which don't correspond if the vaddr is just a normal lowmem address
> (ie, not in the KMAP area).  This patch makes sure that the pte is
> only cleared if kmap area was actually used for the mapping.

Or in other words, if kmap_atomic() does nothing, kunmap_atomic() should
do nothing.

Rusty.


