Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265038AbRGEUnM>; Thu, 5 Jul 2001 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265091AbRGEUnB>; Thu, 5 Jul 2001 16:43:01 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:40735 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S265038AbRGEUmt>;
	Thu, 5 Jul 2001 16:42:49 -0400
Message-ID: <20010705224245.A1789@win.tue.nl>
Date: Thu, 5 Jul 2001 22:42:45 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: "Stephen C Burns" <sburns@farpointer.net>, <linux-kernel@vger.kernel.org>
Subject: Re: LILO calling modprobe?
In-Reply-To: <003201c1058c$d9161d30$4201a8c0@lan.farpointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <003201c1058c$d9161d30$4201a8c0@lan.farpointer.net>; from Stephen C Burns on Thu, Jul 05, 2001 at 02:58:18PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 02:58:18PM -0500, Stephen C Burns wrote:

> Each time I run lilo, I receive the following message in syslog:
> 
> modprobe: Can't locate module block-major-3
> 
> This machine has no IDE devices.  when I run lilo in verbose mode, I see
> that it is querying all possible hard disks in /dev (e.g. Caching device
> /dev/hda (0x0300, etc.).  I am, in fact, running an older version of
> LILO (0.21) but upgrading when it is not necessary frightens me.

Well, why not look at the source, then?

void preload_dev_cache(void)
{
    char tmp[10];
    int i;

    cache_add("/dev/hda",0x300);
    for (i = 1; i <= 8; i++) {
        sprintf(tmp,"/dev/hda%d",i);
        cache_add(tmp,0x300+i);
    }
    cache_add("/dev/hdb",0x340);
    for (i = 1; i <= 8; i++) {
        sprintf(tmp,"/dev/hdb%d",i);
        cache_add(tmp,0x340+i);
    }
    cache_add("/dev/sda",0x800);
    for (i = 1; i <= 8; i++) {
        sprintf(tmp,"/dev/sda%d",i);
        cache_add(tmp,0x800+i);
    }
    cache_add("/dev/sdb",0x810);
    for (i = 1; i <= 8; i++) {
        sprintf(tmp,"/dev/sdb%d",i);
        cache_add(tmp,0x810+i);
    }
}

Before doing anything LILO v21 collects the hda, hdb, sda, sdb info.
There is no problem, certainly no kernel problem.
