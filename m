Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVCOINn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVCOINn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 03:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVCOINn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 03:13:43 -0500
Received: from fmr20.intel.com ([134.134.136.19]:44242 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262330AbVCOINd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 03:13:33 -0500
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
From: Li Shaohua <shaohua.li@intel.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Jan De Luyck <lkml@kcore.org>, lkml <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>, seife@suse.de,
       rjw@sisk.pl
In-Reply-To: <20050314080029.GF22635@elf.ucw.cz>
References: <20050314080029.GF22635@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1110874241.32535.44.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Mar 2005 16:10:41 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, 2005-03-14 at 16:00, Pavel Machek wrote:
> Hi!
> 
> >   * MySQL (hinders the actual suspension process and kicks the pc
> back to 
> >     where it was)
> 
> Try this patch...
>                                                                 Pavel
> 
> --- clean/kernel/signal.c       2005-02-03 22:27:26.000000000 +0100
> +++ linux/kernel/signal.c       2005-02-03 22:28:19.000000000 +0100
> @@ -2222,6 +2222,7 @@
>                         ret = -EINTR;
>         }
>  
> +       try_to_freeze(1);
>         return ret;
>  }
I also encounter a similar issue. syslogd can't be stopped. It's waiting
for kjournald to flush some works but kjournald is stopped first. Looks
like the kernel thread should be stopped later than user thread just
like Nigel's suspend2 patch does.

Thanks,
Shaohua

