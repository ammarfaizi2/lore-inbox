Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316945AbSE1VYq>; Tue, 28 May 2002 17:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316946AbSE1VYp>; Tue, 28 May 2002 17:24:45 -0400
Received: from holomorphy.com ([66.224.33.161]:47246 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316945AbSE1VYo>;
	Tue, 28 May 2002 17:24:44 -0400
Date: Tue, 28 May 2002 14:24:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020528212427.GV14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20020521222858.GA14737@elf.ucw.cz> <20020527194018.GQ14918@holomorphy.com> <20020528193220.GB189@elf.ucw.cz> <20020528210917.GU14918@holomorphy.com> <20020528211120.GA28189@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Pavel Machek wrote:
>>> I had to add
>>> 	if (!curr) break; 
>>> to fix the oops. It now looks way nicer. Thanx.

At some point in the past, I wrote:
>> It's pretty odd that this happens to the buddy lists. I guess if it's
>> needed as a stopgap measure, I can't complain too much, but I'd suspect
>> something's corrupting it or you're catching a buddy list operation in
>> progress. I might be interested in taking a stab at finding out where
>> the corruption happens if you also think that's what's going on.

On Tue, May 28, 2002 at 11:11:20PM +0200, Pavel Machek wrote:
> I think it is not a coruption, but something like
> "not all list are valid on non-himem machine", or something like that.
> 								Pavel

d'oh! Sorry about that, I forgot about free_area_init_core() not fixing
up zeroed-out list_heads for ZONE_HIGHMEM. I don't see any harm in
doing INIT_LIST_HEAD() on them in free_area_init_core(), and it would
seem to fix this boundary case, no? Alternatively, highmem zones on non-
highmem machines can be skipped by the caller as well. Do you think
either of these might be good ideas, or is it going too far out of one's
way for marginal code prettiness benefits?

Actually, I just thought of something that might be useful in addition,
which is that it would probably only be necessary to search inside of
page_zone(page), do you agree?


Cheers,
Bill
