Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311547AbSCXELc>; Sat, 23 Mar 2002 23:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311531AbSCXELX>; Sat, 23 Mar 2002 23:11:23 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:35775 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S311547AbSCXELR>;
	Sat, 23 Mar 2002 23:11:17 -0500
Date: Sat, 23 Mar 2002 23:11:11 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: rddunlap@osdl.org
cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [patch 2.5] seq_file for /proc/partitions
In-Reply-To: <Pine.LNX.4.33.0203231920420.23956-100000@osdlab.pdx.osdl.net>
Message-ID: <Pine.GSO.4.21.0203232308260.6560-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Mar 2002 rddunlap@osdl.org wrote:

> +static void *part_next(struct seq_file *part, void *v, loff_t *pos)
> +{
> +	++*pos;
> +	return part_start(part, pos);

Erm...  Actually that _is_ wrong - what you want is

	return ((struct gendisk)v)->next;

> +}

Reasons:
	a) just how many times do you want to grab that lock?
	b) why bother scanning the list from the very beginning each time?

