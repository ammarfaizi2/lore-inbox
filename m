Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbVAFVvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbVAFVvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbVAFVu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:50:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3000 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263001AbVAFVm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:42:57 -0500
Date: Thu, 6 Jan 2005 16:41:59 -0500
From: Dave Jones <davej@redhat.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       DRI Devel <dri-devel@lists.sourceforge.net>
Subject: Re: chasing the four level page table
Message-ID: <20050106214159.GG16373@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jon Smirl <jonsmirl@gmail.com>, Andi Kleen <ak@muc.de>,
	linux-kernel@vger.kernel.org,
	DRI Devel <dri-devel@lists.sourceforge.net>
References: <9e47339105010609175dabc381@mail.gmail.com> <m1vfaav340.fsf@muc.de> <9e47339105010610362fd7fffe@mail.gmail.com> <20050106193826.GC47320@muc.de> <9e4733910501061205354c9508@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910501061205354c9508@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 03:05:49PM -0500, Jon Smirl wrote:
 > On 6 Jan 2005 20:38:27 +0100, Andi Kleen <ak@muc.de> wrote:
 > > You can't use get_user_pages in this case because the AGP aperture
 > > can be above mem_map.  If none of the callers take page_table_lock
 > > already you would need to add that too. I guess from the context the lock
 > > is not taken, but better double check.
 > > 
 > > Perhaps we should add a get_user_phys() or somesuch for this.
 > 
 > No where in DRM is page_table_lock being taken.  Also, no other device
 > driver takes page_table_lock either, so that probably implies that DRM
 > shouldn't start doing it to. 

No other device driver is also doing such lowlevel stuff with
page tables directly afaics. drivers/char/drm seem to be the only drivers
using [pgd|pmd|pte]_offset() routines.

		Dave

