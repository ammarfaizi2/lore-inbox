Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289896AbSAKJCN>; Fri, 11 Jan 2002 04:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289904AbSAKJCE>; Fri, 11 Jan 2002 04:02:04 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:17868 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289896AbSAKJBw>; Fri, 11 Jan 2002 04:01:52 -0500
Date: Fri, 11 Jan 2002 11:01:18 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <bonganilinux@mweb.co.za>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Compilation error on 2.5.10 linux-2.5/drivers/ide/pdc4030.c
Message-ID: <Pine.LNX.4.33.0201111052050.7634-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This fixes an error when compiling and removes a unused variable warning
>The following warning I'm not sure about though:
>
>pdc4030.c: In function `do_pdc4030_io':
>pdc4030.c:571: warning: control reaches end of non-void function

That warning is because the function returns an ide_startstop_t but there
is no ending return statement. Looking at the code it is possible to
reach that particular code path. Mind doing a quick patch?

ide_startstop_t do_pdc4030_io (ide_drive_t *drive, struct request *rq)
{
<snip>
    default:
                printk(KERN_ERR "pdc4030: command not READ or WRITE!
Huh?\n");
                ide_end_request(0, HWGROUP(drive));
                break;
        }
	<=== [1]
}

[1] No return statement here but function is non-void (ie it should return
something)


