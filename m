Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbTBQMpQ>; Mon, 17 Feb 2003 07:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267059AbTBQMpQ>; Mon, 17 Feb 2003 07:45:16 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:58642 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267052AbTBQMpO>; Mon, 17 Feb 2003 07:45:14 -0500
Date: Mon, 17 Feb 2003 12:55:04 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Miles Bader <miles@gnu.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Make sysctl vm subdir dependent on CONFIG_MMU
Message-ID: <20030217125504.A25066@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miles Bader <miles@gnu.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030217105900.5E2683728@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030217105900.5E2683728@mcspd15.ucom.lsi.nec.co.jp>; from miles@lsi.nec.co.jp on Mon, Feb 17, 2003 at 07:59:00PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 07:59:00PM +0900, Miles Bader wrote:
> diff -ruN -X../cludes linux-2.5.61-uc0.orig/kernel/sysctl.c linux-2.5.61-uc0/kernel/sysctl.c
> --- linux-2.5.61-uc0.orig/kernel/sysctl.c	2002-12-16 12:53:59.000000000 +0900
> +++ linux-2.5.61-uc0/kernel/sysctl.c	2003-02-17 19:24:58.000000000 +0900
> @@ -111,7 +111,9 @@
>  	{ root_table, LIST_HEAD_INIT(root_table_header.ctl_entry) };
>  
>  static ctl_table kern_table[];
> +#ifdef CONFIG_MMU
>  static ctl_table vm_table[];
> +#endif

These ifdefs are ugly - please move the whole table into a file that
isn't compiled when CONFIG_MMU isn't set (e.g. memory.c) and use
register_sysctl_table()
