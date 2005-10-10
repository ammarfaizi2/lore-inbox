Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVJJSIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVJJSIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 14:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVJJSII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 14:08:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35731 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751131AbVJJSIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 14:08:07 -0400
Date: Mon, 10 Oct 2005 11:07:45 -0700
From: Chris Wright <chrisw@osdl.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Sergey Vlasov <vsu@altlinux.ru>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, security@linux.kernel.org,
       vendor-sec@lst.de
Subject: Re: [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20051010180745.GT5856@shell0.pdx.osdl.net>
References: <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <20050927165206.GB20466@master.mivlgu.local> <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org> <20050930104749.GN4168@sunbeam.de.gnumonks.org> <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org> <20050930184433.GF16352@shell0.pdx.osdl.net> <Pine.LNX.4.64.0509301225190.3378@g5.osdl.org> <20050930220808.GE4168@sunbeam.de.gnumonks.org> <Pine.LNX.4.64.0509301514190.3378@g5.osdl.org> <20051010174429.GH5627@rama>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010174429.GH5627@rama>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Harald Welte (laforge@gnumonks.org) wrote:
> diff --git a/kernel/signal.c b/kernel/signal.c
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1193,6 +1193,40 @@ kill_proc_info(int sig, struct siginfo *
>  	return error;
>  }
>  
> +/* like kill_proc_info(), but doesn't use uid/euid of "current" */

Maybe additional comment reminding that you most likely don't want this
interface.

Also, looks like there's same issue again:

drivers/usb/core/devio.c::usbdev_open()
	...
	ps->disctask = current;

drivers/usb/core/inode.c::usbfs_remove_device()
	...
			send_sig_info(ds->discsignr, &sinfo, ds->disctask);
