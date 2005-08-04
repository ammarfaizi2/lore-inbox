Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbVHDKnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVHDKnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 06:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVHDKnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 06:43:05 -0400
Received: from colin.muc.de ([193.149.48.1]:5649 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262469AbVHDKnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 06:43:03 -0400
Date: 4 Aug 2005 12:43:02 +0200
Date: Thu, 4 Aug 2005 12:43:02 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, zwane@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 4/8] x86_64:Fix cluster mode send_IPI_allbutself to use get_cpu()/put_cpu()
Message-ID: <20050804104302.GC97893@muc.de>
References: <20050801202017.043754000@araj-em64t> <20050801203011.290911000@araj-em64t>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801203011.290911000@araj-em64t>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 01:20:21PM -0700, Ashok Raj wrote:
> Need to ensure we dont get prempted when we clear ourself from mask when using
> clustered mode genapic code.

It's not needed I think. If the caller wants to execute code
on the current CPU then it has to have disabled preemption
itself already to avoid races. And if not it doesn't care.

One could argue that this function should be always called
with preemption disabled though. Perhaps better a WARN_ON().

-Andi
