Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWDPAtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWDPAtL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 20:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWDPAtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 20:49:11 -0400
Received: from mail.gmx.de ([213.165.64.20]:9105 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751204AbWDPAtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 20:49:10 -0400
Date: Sun, 16 Apr 2006 02:49:08 +0200 (MEST)
From: "Helge Deller" <deller@gmx.de>
To: Zou Nan hai <nanhai.zou@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Subject: =?ISO-8859-1?Q?Re:_[PATCH_6/8]_IA64_various_hugepage_size_-_introduce_prc?=
 =?ISO-8859-1?Q?tl_options_to_set/get_hugepage_size?=
X-Priority: 3 (Normal)
X-Authenticated: #1045983
Message-ID: <19747.1145148548@www082.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zou Nan hai wrote:
> Introduce 2 prctl option to set/get hugepage size.
> --- a/kernel/sys.c    2006-04-13 08:41:37.000000000 +0800
> +++ b/kernel/sys.c    2006-04-13 08:47:41.000000000 +0800
> +#ifndef GET_HUGEPAGESIZE
> +# define GET_HUGEPAGESIZE(a,b)  (-EINVAL)
> +#endif
> +#ifndef SET_HUGEPAGESIZE
> +# define SET_HUGEPAGESIZE(a,b)  (-EINVAL)
> +#endif
>  
> @@ -2057,6 +2063,12 @@ asmlinkage long sys_prctl(int option, un
>  return -EFAULT;
>  return 0;
>  }
> +             case PR_SET_HUGEPAGE_SIZE:
> +                     error = SET_HUGEPAGESIZE(current, arg2);
> +                     break;
> +             case PR_GET_HUGEPAGE_SIZE:
> +                     error = GET_HUGEPAGESIZE(current, arg2);
> +                     break;
>  default:
>  error = -EINVAL;
>  break;

for architectures which do not support variable hugepage sizes I would 
prefer, that
- prctl(PR_SET_HUGEPAGE_SIZE, DEFAULT_HPAGE_SIZE) returns OK instead of 
FAIL.
- prctl(PR_GET_HUGEPAGE_SIZE) returns the DEFAULT_HPAGE_SIZE  instead of 
FAIL.

Helge

-- 
"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
