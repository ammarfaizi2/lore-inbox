Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTEUJ7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 05:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbTEUJ7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 05:59:46 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:43933 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262038AbTEUJ7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 05:59:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16075.20763.659219.636543@gargle.gargle.HOWL>
Date: Wed, 21 May 2003 12:12:43 +0200
From: mikpe@csd.uu.se
To: Andi Kleen <ak@suse.de>
Cc: tripperda@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: pat support in the kernel
In-Reply-To: <p73brxwzlfr.fsf@oldwotan.suse.de>
References: <20030520185409.GB941@hygelac.suse.lists.linux.kernel>
	<16074.33371.411219.528228@gargle.gargle.HOWL.suse.lists.linux.kernel>
	<p73brxwzlfr.fsf@oldwotan.suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > mikpe@csd.uu.se writes:
 > 
 > > (Large pages ignoring PAT index bit 2, or something like that.)
 > 
 > change_page_attr will force 4K pages for these anyways, so for the kernel
 > direct mapping it should not be an issue. 
 > 
 > For the hugetlbfs user mapping you may need to check the case, but
 > it's probably reasonable to EINVAL there.
 > 
 > Other than that everything should be 4K mapped.

The bug is that 4K pages get the wrong PAT index; the large page
thing is the trigger but the large pages themselves arent' affected.

So 4K pages need to be restricted to the low 4 PAT types.
