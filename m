Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVBDCAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVBDCAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 21:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVBDCAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 21:00:45 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:34908 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263327AbVBDCAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 21:00:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SrvXKL3Gj9t+DD0tkYveKgVEGz8hHvH/aVAChyetKMQkCoK40LdVMzwxv5JZjgq36a5gMhGedkYIyBlEerHlowesuAtE769jh9T4Is1T9pwsHQuVVsCYT7TvZTsomZPrIgo7AoaZazkXkksID788hj9br2nHr0McTmzWr507XZg=
Message-ID: <58cb370e0502031800667e1e06@mail.gmail.com>
Date: Fri, 4 Feb 2005 03:00:09 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 05/29] ide: merge pci driver .h's into .c's
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202024712.GF621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202024712.GF621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:47:12 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 05_ide_merge_pci_driver_hc.patch
> >
> >       Merges drivers/ide/pci/*.h files into their corresponding *.c
> >       files.  Rationales are
> >       1. There's no reason to separate pci drivers into header and
> >          body.  No header file is shared and they're simple enough.
> >       2. struct pde_pci_device_t *_chipsets[] are _defined_ in the
> >          header files.  That isn't the custom and there's no good
> >          reason to do differently in these drivers.
> >       3. Tracking changelogs shows that the bugs fixed by 00 and 01
> >          are introduced during mass-updating ide pci drivers by
> >          forgetting to update *.h files.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

Please kill crap in these .h files before mering them with .c files,
also split this patch on per driver changes.

crap example looks like this: ;)

> +#ifndef SPLIT_BYTE
> +#define SPLIT_BYTE(B,H,L)      ((H)=(B>>4), (L)=(B-((B>>4)<<4)))
> +#endif
> +#ifndef MAKE_WORD
> +#define MAKE_WORD(W,HB,LB)     ((W)=((HB<<8)+LB))
> +#endif
