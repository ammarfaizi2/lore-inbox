Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262918AbVA2OE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbVA2OE2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 09:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbVA2OE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 09:04:28 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:63238 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S262918AbVA2OE1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 09:04:27 -0500
Date: Sat, 29 Jan 2005 14:04:23 +0000
From: John Levon <levon@movementarian.org>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] OProfile: Fix oops on undetected CPU type
Message-ID: <20050129140423.GA71581@compsoc.man.ac.uk>
References: <Pine.LNX.4.61.0501281146150.22906@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501281146150.22906@montezuma.fsmlabs.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CutD7-000NHZ-OS*lgXOlf3JIOE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 12:06:19PM -0700, Zwane Mwaikambo wrote:

> ===== drivers/oprofile/oprofile_files.c 1.7 vs edited =====
> --- 1.7/drivers/oprofile/oprofile_files.c	2005-01-04 19:48:23 -07:00
> +++ edited/drivers/oprofile/oprofile_files.c	2005-01-28 11:36:25 -07:00
> @@ -63,7 +63,9 @@ static struct file_operations pointer_si
>  
>  static ssize_t cpu_type_read(struct file * file, char __user * buf, size_t count, loff_t * offset)
>  {
> -	return oprofilefs_str_to_user(oprofile_ops.cpu_type, buf, count, offset);
> +	if (oprofile_ops.cpu_type)
> +		return oprofilefs_str_to_user(oprofile_ops.cpu_type, buf, count, offset);
> +	return -EIO;

This is wrong: you need to investigate why .cpu_type isn't set: in
particular, it should have fallen back to timer mode.
oprofile_arch_init() should have returned -ENODEV, and that should have
set timer mode.

Unfortunately bkcvs seems out of date so I can't even look at this
myself.

john
