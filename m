Return-Path: <linux-kernel-owner+w=401wt.eu-S1762779AbWLKKqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762779AbWLKKqB (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762780AbWLKKqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:46:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54806 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762779AbWLKKqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:46:00 -0500
Date: Mon, 11 Dec 2006 10:45:56 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Linus Torvalds orton <akpm@osdl.org>" <torvalds@osdl.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-ID: <20061211104556.GF4587@ftp.linux.org.uk>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com> <20061211005557.04643a75.akpm@osdl.org> <20061211011327.f9478117.akpm@osdl.org> <20061211092130.GB4587@ftp.linux.org.uk> <20061211012545.ed945cbd.akpm@osdl.org> <20061211093314.GC4587@ftp.linux.org.uk> <20061211014727.21c4ab25.akpm@osdl.org> <20061211100301.GD4587@ftp.linux.org.uk> <20061211021718.a6954106.akpm@osdl.org> <20061211022746.9ec80c03.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211022746.9ec80c03.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 02:27:46AM -0800, Andrew Morton wrote:
> @@ -115,6 +115,11 @@ extern void setup_arch(char **);
>  #define device_initcall_sync(fn)	__define_initcall("6s",fn,6s)
>  #define late_initcall(fn)		__define_initcall("7",fn,7)
>  #define late_initcall_sync(fn)		__define_initcall("7s",fn,7s)
> +#define populate_rootfs_initcall(fn)	__define_initcall("8",fn,8)
> +#define populate_rootfs_initcall_sync(fn) __define_initcall("8s",fn,8s)
> +#define rootfs_neeeded_initcall(fn)	__define_initcall("9",fn,9)
> +#define rootfs_neeeded_initcall_sync(fn) __define_initcall("9s",fn,9s)

Ewww....  After module_init()?  Please, don't.  Come on, if it can
be a module, it _must_ be ready to run late in the game.
