Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbUKFGae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbUKFGae (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 01:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbUKFGae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 01:30:34 -0500
Received: from cantor.suse.de ([195.135.220.2]:60855 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261325AbUKFGaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 01:30:30 -0500
To: Jack Steiner <steiner@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Externalize SLIT table
References: <20041103205655.GA5084@sgi.com.suse.lists.linux.kernel>
	<20041104.105908.18574694.t-kochi@bq.jp.nec.com.suse.lists.linux.kernel>
	<20041104040713.GC21211@wotan.suse.de.suse.lists.linux.kernel>
	<20041104.135721.08317994.t-kochi@bq.jp.nec.com.suse.lists.linux.kernel>
	<20041105160808.GA26719@sgi.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 06 Nov 2004 07:30:29 +0100
In-Reply-To: <20041105160808.GA26719@sgi.com.suse.lists.linux.kernel>
Message-ID: <p73k6sz7am2.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner <steiner@sgi.com> writes:
>  
> +static ssize_t node_read_distance(struct sys_device * dev, char * buf)
> +{
> +	int nid = dev->id;
> +	int len = 0;
> +	int i;
> +
> +	for (i = 0; i < numnodes; i++)
> +		len += sprintf(buf + len, "%s%d", i ? " " : "", node_distance(nid, i));


One problem is that most architectures define node_distance currently
as nid != i. This would give 0 on them for the identity mapping and 10 
on IA64 which uses the SLIT values. Not good for a portable interface.
I would suggest to at least change them to return 10 for a zero node distance.

Also in general I would prefer if you could move all the SLIT parsing
into drivers/acpi/numa.c. Then the other ACPI architectures don't need to copy
the basically identical code from ia64.

-Andi
