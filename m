Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUCEKI0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 05:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUCEKI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 05:08:26 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:3285 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261605AbUCEKIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 05:08:24 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Raj <obelix123@toughguy.net>
Date: Fri, 5 Mar 2004 21:08:11 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16456.20875.670811.900445@notabene.cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, okir@monad.swb.de
Subject: Re: [TRIVIAL][PATCH]:/proc/fs/nfsd/
In-Reply-To: message from Raj on Friday March 5
References: <404843B5.1010409@toughguy.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday March 5, obelix123@toughguy.net wrote:
> Hi,
> 
> Kernel Version: 2.6.3
> Even if NFSD is not selected, the proc entry /proc/fs/nfsd is getting 
> created.

Is it a problem??

> 
> The following patch fixes it.

Does it need fixing??

If you remove this, then people who compile a kernel without nfsd
support, and then later decide to compile an nfsd module and load it,
will not be able to mount the nfsd filesystem at the right place.

You might say "that won't happen", but it does, and has.
You might say "they shouldn't do that", and maybe they shouldn't.  But
it still causes a support burden on the mailing list.

I think it is a very small cost, and a measurable gain, to leave it
there.

Do you really think otherwise?

NeilBRown


> 
> Pls apply.
> 
> /Raj
> --- linux-2.6.3/fs/proc/root.c	2004-02-19 09:52:32.000000000 +0530
> +++ linux-2.6.3-fixed/fs/proc/root.c	2004-03-05 13:48:28.448516568 +0530
> @@ -65,7 +65,11 @@ void __init proc_root_init(void)
>  #endif
>  	proc_root_fs = proc_mkdir("fs", 0);
>  	proc_root_driver = proc_mkdir("driver", 0);
> +
> +#if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
>  	proc_mkdir("fs/nfsd", 0); /* somewhere for the nfsd filesystem to be mounted */
> +#endif
> +
>  #if defined(CONFIG_SUN_OPENPROMFS) || defined(CONFIG_SUN_OPENPROMFS_MODULE)
>  	/* just give it a mountpoint */
>  	proc_mkdir("openprom", 0);
