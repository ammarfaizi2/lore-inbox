Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVHVXdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVHVXdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVHVXdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:33:04 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:56788 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1751303AbVHVXdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:33:03 -0400
Subject: Re: [patch] suspend: update warnings
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050822081528.GA4418@elf.ucw.cz>
References: <20050822081528.GA4418@elf.ucw.cz>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1124753566.5093.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 23 Aug 2005 09:32:46 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-08-22 at 18:15, Pavel Machek wrote:
> Update suspend documentation. Warnings were a bit overstated, and did
> not point out important stuff.
> 
> ---
> commit 790df7223ac29afec81e7201adc879973311f27e
> tree 97fa2017f8f5aded0c44cfc75ba4903fbdb7f0a4
> parent 63393fcbf056a6fd68142a49ed4e1258560dce2c
> author <pavel@amd.(none)> Mon, 22 Aug 2005 10:13:51 +0200
> committer <pavel@amd.(none)> Mon, 22 Aug 2005 10:13:51 +0200
> 
>  Documentation/power/swsusp.txt |   60 ++++++++++++++++++++++++++++++++--------
>  Documentation/power/video.txt  |    9 +++++-
>  2 files changed, 56 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
> --- a/Documentation/power/swsusp.txt
> +++ b/Documentation/power/swsusp.txt
> @@ -1,22 +1,20 @@
> -From kernel/suspend.c:
> +Some warnings, first.
>  
>   * BIG FAT WARNING *********************************************************
>   *
> - * If you have unsupported (*) devices using DMA...
> - *				...say goodbye to your data.
> - *
>   * If you touch anything on disk between suspend and resume...
>   *				...kiss your data goodbye.
>   *
> - * If your disk driver does not support suspend... (IDE does)
> - *				...you'd better find out how to get along
> - *				   without your data.
> - *
> - * If you change kernel command line between suspend and resume...
> - *			        ...prepare for nasty fsck or worse.
> + * If you do resume from initrd after your filesystems are mounted...
> + *				...bye bye root partition.
> + *			[this is actually same case as above]
>   *
> - * If you change your hardware while system is suspended...
> - *			        ...well, it was not good idea.
> + * If you have unsupported (*) devices using DMA, you may have some
> + * problems. If your disk driver does not support suspend... (IDE does),
> + * it may cause some problems, too. If you change kernel command line 
> + * between suspend and resume, it may do something wrong. If you change 
> + * your hardware while system is suspended... well, it was not good idea;
> + * but it wil probably only crash.

The most common driver issues I see involve:
- USB being built in or as modules that are still loaded while
suspending (getting better, but not there yet)
- DRI being used in X where the drivers don't properly support
suspend/resume (NVidia esp)
- Firewire
- CPU Freq  (improving too)

It might be good to mention these areas too.

Perhaps the 'changing your hardware' could mention that replacing faulty
hardware may be safe.

Regards,

Nigel

>   *
>   * (*) suspend/resume support is needed to make it safe.
>  
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

