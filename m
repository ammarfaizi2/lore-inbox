Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279857AbRJ3E1O>; Mon, 29 Oct 2001 23:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279861AbRJ3E0W>; Mon, 29 Oct 2001 23:26:22 -0500
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:28662 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S279860AbRJ3E0M>; Mon, 29 Oct 2001 23:26:12 -0500
Message-ID: <3BDE2BB8.F926AE04@cisco.com>
Date: Tue, 30 Oct 2001 09:55:28 +0530
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for warnings for i2o
In-Reply-To: <Pine.GSO.4.33.0110291733020.28035-100000@cbin2-view1.cisco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The warnings i am try to fix are as follows ....

i2o_block.c: In function `i2ob_install_device':
i2o_block.c:1375: warning: comparison is always zero due to width of bitfield

i2o_block.c:1378: warning: comparison is always zero due to width of bitfield

FYI ...

Manik Raina wrote:

> i2o code compilation gives a warning which is due
> to the fact that queue_buggy (i2o_block.c:1375, 1378)
> is compared to 1 and 2, even though it's 1 bit in size.
>
> queue_buggy is set to 0, 1 and 2 and hence the warnings
> go away when the size is increased.
>
> diffs attached ....
>
> Index: i2o.h
> ===================================================================
> RCS file: /vger/linux/include/linux/i2o.h,v
> retrieving revision 1.17
> diff -u -r1.17 i2o.h
> --- i2o.h       22 Oct 2001 06:46:34 -0000      1.17
> +++ i2o.h       29 Oct 2001 11:34:55 -0000
> @@ -82,7 +82,7 @@
>  struct i2o_pci
>  {
>         int             irq;
> -       int             queue_buggy:1;  /* Don't send a lot of messages */
> +       int             queue_buggy:3;  /* Don't send a lot of messages */
>         int             short_req:1;    /* Use small block sizes        */
>         int             dpt:1;          /* Don't quiesce                */
>  #ifdef CONFIG_MTRR
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

