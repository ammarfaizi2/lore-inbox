Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267328AbTACADI>; Thu, 2 Jan 2003 19:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbTACADH>; Thu, 2 Jan 2003 19:03:07 -0500
Received: from holomorphy.com ([66.224.33.161]:47814 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267328AbTACADH>;
	Thu, 2 Jan 2003 19:03:07 -0500
Date: Thu, 2 Jan 2003 16:11:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Question about Zone Allocation 2.4.X
Message-ID: <20030103001127.GV9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
References: <20030102175517.A21471@vger.timpanogas.org> <20030102235147.GS9704@holomorphy.com> <20030102180849.A21498@vger.timpanogas.org> <20030103000034.GU9704@holomorphy.com> <20030102181554.A21643@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102181554.A21643@vger.timpanogas.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 06:15:54PM -0700, Jeff V. Merkey wrote:
> Looks like we simply jetisioned the concept of a PPL (Physical Pages
> List) and went with a zone allocator instead.  I'm sure there was a
> good reason for it historically.  Rolling a separate zone is exactly
> what I was thinking when I reviewed the code intially.  Question,
> which files will be affected so when I put this one in, I don't end
> up breaking the VM and userspace balancing logic.  i.e.  Could you
> point me to Jens' ZONE_DMA32 code as well.

Adding new zone types is easy. Just add them to mmzone.h, avoid setting
->virtual (which does not universally exist) in free_area_init_core()
if it's not perma-mapped, stuff them in the fallback sequence in
build_zonelists(), and detect them in arch/*/mm/init.c


Bill
