Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWDGLlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWDGLlU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 07:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWDGLlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 07:41:19 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:9153 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932324AbWDGLlT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 07:41:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EsCKKeRuswjc5k5ZLSaVlYlqSDJk9UR2Os0oPeeqCKDkl+SKNlPlD493pPB4QCTIYi6DdGtm0TaRM4GwIjjsT7SzMfzabJj9CjbYFbmzcAnTndyus2WqWbj+hSEXW8et0lzMxnfwhDD05+l4jOjk+kNWwWrkNgop4GwmqN6hsfQ=
Message-ID: <58cb370e0604070441p5ea09c6fl5a778244db876f6e@mail.gmail.com>
Date: Fri, 7 Apr 2006 13:41:18 +0200
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [2.6 patch] remove the obsolete IDEPCI_FLAG_FORCE_PDC
Cc: "Sergei Shtylylov" <sshtylyov@ru.mvista.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <20060407003101.GF7118@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060122171239.GD10003@stusta.de> <4427F5E7.1000108@ru.mvista.com>
	 <58cb370e0603270640v7c6070a9gb7dbd2aa5fcbbf98@mail.gmail.com>
	 <20060407003101.GF7118@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Mon, Mar 27, 2006 at 04:40:20PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On 3/27/06, Sergei Shtylylov <sshtylyov@ru.mvista.com> wrote:
> >...
> > > >               .flags          = IDEPCI_FLAG_FORCE_PDC,
> > >
> > >     A late question: wasn't that IDEPCI_FLAG_FORCE_PDC flag there for the same
> > > purpose -- to bypass enablebits check? Wasn't it enough?
> >
> > It was for the same purpose but it wasn't enough,
> > now this flag can die...
>
> IOW, we want the patch below?

Yes.  Could you please add my ACK and forward it to akpm?

> > Bartlomiej
>
> cu
> Adrian
>
>
> <--  snip  -->
>
>
> This patch removes the obsolete IDEPCI_FLAG_FORCE_PDC.
>
> Noted by Sergei Shtylylov <sshtylyov@ru.mvista.com>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
>
>  drivers/ide/pci/pdc202xx_old.c |    2 --
>  drivers/ide/setup-pci.c        |   13 -------------
>  include/linux/ide.h            |    1 -
>  3 files changed, 16 deletions(-)
>
> --- linux-2.6.17-rc1-mm1-full/include/linux/ide.h.old   2006-04-07 00:51:49.000000000 +0200
> +++ linux-2.6.17-rc1-mm1-full/include/linux/ide.h       2006-04-07 00:52:03.000000000 +0200
> @@ -1221,7 +1221,6 @@
>  enum {
>         /* Uses ISA control ports not PCI ones. */
>         IDEPCI_FLAG_ISA_PORTS           = (1 << 0),
> -       IDEPCI_FLAG_FORCE_PDC           = (1 << 1),
>  };
>
>  typedef struct ide_pci_device_s {
> --- linux-2.6.17-rc1-mm1-full/drivers/ide/pci/pdc202xx_old.c.old        2006-04-07 00:52:13.000000000 +0200
> +++ linux-2.6.17-rc1-mm1-full/drivers/ide/pci/pdc202xx_old.c    2006-04-07 00:52:19.000000000 +0200
> @@ -798,7 +798,6 @@
>                 .autodma        = AUTODMA,
>                 .bootable       = OFF_BOARD,
>                 .extra          = 48,
> -               .flags          = IDEPCI_FLAG_FORCE_PDC,
>         },{     /* 2 */
>                 .name           = "PDC20263",
>                 .init_setup     = init_setup_pdc202ata4,
> @@ -819,7 +818,6 @@
>                 .autodma        = AUTODMA,
>                 .bootable       = OFF_BOARD,
>                 .extra          = 48,
> -               .flags          = IDEPCI_FLAG_FORCE_PDC,
>         },{     /* 4 */
>                 .name           = "PDC20267",
>                 .init_setup     = init_setup_pdc202xx,
> --- linux-2.6.17-rc1-mm1-full/drivers/ide/setup-pci.c.old       2006-04-07 00:52:27.000000000 +0200
> +++ linux-2.6.17-rc1-mm1-full/drivers/ide/setup-pci.c   2006-04-07 00:54:28.000000000 +0200
> @@ -580,7 +580,6 @@
>         int port;
>         int at_least_one_hwif_enabled = 0;
>         ide_hwif_t *hwif, *mate = NULL;
> -       static int secondpdc = 0;
>         u8 tmp;
>
>         index->all = 0xf0f0;
> @@ -592,21 +591,9 @@
>         for (port = 0; port <= 1; ++port) {
>                 ide_pci_enablebit_t *e = &(d->enablebits[port]);
>
> -               /*
> -                * If this is a Promise FakeRaid controller,
> -                * the 2nd controller will be marked as
> -                * disabled while it is actually there and enabled
> -                * by the bios for raid purposes.
> -                * Skip the normal "is it enabled" test for those.
> -                */
> -               if ((d->flags & IDEPCI_FLAG_FORCE_PDC) &&
> -                   (secondpdc++==1) && (port==1))
> -                       goto controller_ok;
> -
>                 if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) ||
>                     (tmp & e->mask) != e->val))
>                         continue;       /* port not enabled */
> -controller_ok:
>
>                 if (d->channels <= port)
>                         break;
