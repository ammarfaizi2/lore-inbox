Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268662AbUJPGcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268662AbUJPGcg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 02:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268326AbUJPGcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 02:32:36 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:43974 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S268662AbUJPGc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 02:32:29 -0400
Date: Fri, 15 Oct 2004 23:32:26 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Glenn Burkhardt <glenn@aoi-industries.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: remap_page_range64() for PPC
Message-ID: <20041015233226.B1500@home.com>
References: <20041016034642.F1DD0C60D@aoi-industries.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041016034642.F1DD0C60D@aoi-industries.com>; from glenn@aoi-industries.com on Fri, Oct 15, 2004 at 11:46:42PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 11:46:42PM -0400, Glenn Burkhardt wrote:
> I'm writing an application to run on a PowerPC with a 2.4 embedded
> Linux kernel, and I want to make device registers for our custom
> hardware accessable from user space with mmap().  The physical address
> of the device is above the 4gb boundary (we attach to the 440's
> external peripheral bus), so a standard 'remap_page_range()' call
> won't work.

<snip>

This has come up several times on the ppc lists (but since we still
don't have archives back, nobody can search anyway). I dropped
2.4 and 2.5 patches in source.mvista.com:/pub/linuxppc/ a long
time ago.  You just need to update your board-specific fixup routine
in that version or just make a copy or remap_page_range() into your
driver and use u64 for the phys address.

The real fix, of course, is in the -mm tree as remap_pfn_range(),
I plan to merge 440 io_remap_page_range() support on top of that
call when it goes into mainline. But that doesn't help you with
2.4. :)

-Matt
