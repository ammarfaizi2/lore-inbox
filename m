Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271325AbUJVOxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271325AbUJVOxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271326AbUJVOxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:53:45 -0400
Received: from holomorphy.com ([207.189.100.168]:36547 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S271325AbUJVOx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:53:27 -0400
Date: Fri, 22 Oct 2004 07:53:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Glenn Burkhardt <glenn@aoi-industries.com>, linux-kernel@vger.kernel.org
Subject: Re: remap_page_range64() for PPC
Message-ID: <20041022145321.GV17038@holomorphy.com>
References: <20041016034642.F1DD0C60D@aoi-industries.com> <20041015233226.B1500@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015233226.B1500@home.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 11:46:42PM -0400, Glenn Burkhardt wrote:
>> I'm writing an application to run on a PowerPC with a 2.4 embedded
>> Linux kernel, and I want to make device registers for our custom
>> hardware accessable from user space with mmap().  The physical address
>> of the device is above the 4gb boundary (we attach to the 440's
>> external peripheral bus), so a standard 'remap_page_range()' call
>> won't work.

On Fri, Oct 15, 2004 at 11:32:26PM -0700, Matt Porter wrote:
> This has come up several times on the ppc lists (but since we still
> don't have archives back, nobody can search anyway). I dropped
> 2.4 and 2.5 patches in source.mvista.com:/pub/linuxppc/ a long
> time ago.  You just need to update your board-specific fixup routine
> in that version or just make a copy or remap_page_range() into your
> driver and use u64 for the phys address.
> The real fix, of course, is in the -mm tree as remap_pfn_range(),
> I plan to merge 440 io_remap_page_range() support on top of that
> call when it goes into mainline. But that doesn't help you with
> 2.4. :)

It has gone mainline. Glenn Burkhardt's troubles should now be fixed
for all time, unless io_remap_page_range() itself is in question. I'd
like to carry out a similar conversion on io_remap_page_range() so that
it can have similar safety against physical address overflow. There is
one 32-bit architecture where all IO memory is beyond the 4GB boundary,
and a number where at least some crucial portions of it are. This would
then decide how many arguments io_remap_page_range() takes. There are
some difficulties in this (particularly for the architecture[s] it
would benefit most) so I've been punting on this issue thus far.


-- wli
