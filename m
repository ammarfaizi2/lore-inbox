Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTKBI6V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 03:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTKBI6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 03:58:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41416 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261569AbTKBI6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 03:58:20 -0500
Date: Sun, 2 Nov 2003 08:58:19 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>
Cc: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/[0-9]*/maps where did the (deleted) status go?
Message-ID: <20031102085818.GG7665@parcelfarce.linux.theplanet.co.uk>
References: <3FA47EAF.3070802@hundstad.net> <3FA4BDAB.9080805@mnsu.edu> <20031102004739.12a0004c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031102004739.12a0004c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 02, 2003 at 12:47:39AM -0800, Andrew Morton wrote:
> This patch (against 2.6) will restore the old 2.4 behaviour.  I'll scoot
> the 2.4 equiv over to Marcelo.
> 
> diff -puN fs/proc/task_mmu.c~proc-pid-maps-output-fix fs/proc/task_mmu.c
> --- 25/fs/proc/task_mmu.c~proc-pid-maps-output-fix	2003-11-02 00:38:26.000000000 -0800
> +++ 25-akpm/fs/proc/task_mmu.c	2003-11-02 00:38:30.000000000 -0800
> @@ -106,7 +106,7 @@ static int show_map(struct seq_file *m, 
>  		if (len < 1)
>  			len = 1;
>  		seq_printf(m, "%*c", len, ' ');
> -		seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
> +		seq_path(m, file->f_vfsmnt, file->f_dentry, "");
>  	}
>  	seq_putc(m, '\n');
>  	return 0;

It's still wrong - the real bug is in seq_path(); the thing should *not*
try to escape anything in " (deleted)" part.
