Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289905AbSAKJXU>; Fri, 11 Jan 2002 04:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289907AbSAKJXL>; Fri, 11 Jan 2002 04:23:11 -0500
Received: from zeus.kernel.org ([204.152.189.113]:31943 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289908AbSAKJWu>;
	Fri, 11 Jan 2002 04:22:50 -0500
Date: Fri, 11 Jan 2002 01:04:50 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: bonganilinux@mweb.co.za, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Compilation error on 2.5.10 linux-2.5/drivers/ide/pdc4030.c
In-Reply-To: <Pine.LNX.4.33.0201111052050.7634-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.10.10201110104050.8792-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am aware of the problem and have if fixed just need to submit to Jens.

On Fri, 11 Jan 2002, Zwane Mwaikambo wrote:

> >This fixes an error when compiling and removes a unused variable warning
> >The following warning I'm not sure about though:
> >
> >pdc4030.c: In function `do_pdc4030_io':
> >pdc4030.c:571: warning: control reaches end of non-void function
> 
> That warning is because the function returns an ide_startstop_t but there
> is no ending return statement. Looking at the code it is possible to
> reach that particular code path. Mind doing a quick patch?
> 
> ide_startstop_t do_pdc4030_io (ide_drive_t *drive, struct request *rq)
> {
> <snip>
>     default:
>                 printk(KERN_ERR "pdc4030: command not READ or WRITE!
> Huh?\n");
>                 ide_end_request(0, HWGROUP(drive));
>                 break;
>         }
> 	<=== [1]
> }
> 
> [1] No return statement here but function is non-void (ie it should return
> something)
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development

