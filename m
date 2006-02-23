Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWBWNm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWBWNm0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWBWNm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:42:26 -0500
Received: from mx1.suse.de ([195.135.220.2]:19133 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751233AbWBWNm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:42:26 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Patch to make the head.S-must-be-first-in-vmlinux order explicit
Date: Thu, 23 Feb 2006 14:42:19 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
In-Reply-To: <1140700758.4672.51.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231442.19903.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 14:19, Arjan van de Ven wrote:
> This patch puts the code from head.S in a special .bootstrap.text
> section.
> 
> I'm working on a patch to reorder the functions in the kernel (I'll post
> that later), but for x86-64 at least the kernel bootstrap requires that the
> head.S functions are on the very first page/pages of the kernel text. This
> is understandable since the bootstrap is complex enough already and not a
> problem at all, it just means they aren't allowed to be reordered. This
> patch puts these special functions into a separate section to document this,
> and to guarantee this in the light of possibly reordering the rest later.
> 
> (So this patch doesn't fix a bug per se, but makes things more robust by
> making the order of these functions explicit)

I don't think the 64bit kernel code requires this actually (or at least
it shouldn't), but arch/x86_64/boot/compressed/head.S
seems to have the entry address hardcoded. Perhaps you can just change this
to pass in the right address?

-Andi
