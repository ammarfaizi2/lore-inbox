Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbVKQWHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVKQWHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVKQWHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:07:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26306 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932282AbVKQWHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:07:10 -0500
Date: Thu, 17 Nov 2005 14:07:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org, ak@suse.de,
       ebiederm@xmission.com
Subject: Re: [PATCH 3/10] kdump: export per cpu crash notes pointer through
 sysfs
Message-Id: <20051117140723.3cd2e831.akpm@osdl.org>
In-Reply-To: <20051117132138.GG3981@in.ibm.com>
References: <20051117131339.GD3981@in.ibm.com>
	<20051117131825.GE3981@in.ibm.com>
	<20051117132004.GF3981@in.ibm.com>
	<20051117132138.GG3981@in.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> wrote:
>
> +	/*
> +	 * Might be reading other cpu's data based on which cpu read thread
> +	 * has been scheduled. But cpu data (memory) is allocated once during
> +	 * boot up and this data does not change there after. Hence this
> +	 * operation should be safe. No locking required.
> +	 */
> +	get_cpu();
> +	addr = __pa(per_cpu_ptr(crash_notes, cpunum));
> +	rc = sprintf(buf, "%Lx\n", addr);
> +	put_cpu();

I don't think the get_cpu() and put_cpu() are needed here?
