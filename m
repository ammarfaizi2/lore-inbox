Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVGTNii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVGTNii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 09:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVGTNii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 09:38:38 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:1151 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261223AbVGTNif convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 09:38:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BJ+khqUrUfZxPeQaM/QMQqELrAwQE/0nS9ePQ7WmlXWQY4ZVwHEkn3WZDxWtobqeKXA/F00vVMM0/0Z2OVHMZczEzHil+sjFUoN0s0HlXOXZgPr1l7NVVNK10L5DLRSnJGttF8xDuhICrMNnGhFBT4KdyFRiw6y7aEh24N8Jw6I=
Message-ID: <9a874849050720063872d0c680@mail.gmail.com>
Date: Wed, 20 Jul 2005 15:38:02 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] SCSI_QLA2ABC options must select FW_LOADER
Cc: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Erik Jacobson <erikj@sgi.com>
In-Reply-To: <20050719140419.GI5031@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050715013653.36006990.akpm@osdl.org>
	 <20050715102744.GA3569@stusta.de>
	 <20050715144037.GA25648@plap.qlogic.org> <dbbg0k$p8g$1@sea.gmane.org>
	 <20050719140419.GI5031@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/05, Adrian Bunk <bunk@stusta.de> wrote:
> [ The subject was adapted to linux-kernel spam filters... ]
> 
> On Sat, Jul 16, 2005 at 07:26:44PM +0200, Jindrich Makovicka wrote:
> > Andrew Vasquez wrote:
> > > Yes, quite.  How about the following to correct the intention.
> > >
> > >
> > >
> > > Add correct Kconfig option for ISP24xx support.
> > >
> > > Signed-off-by: Andrew Vasquez <andrew.vasquez@qlogic.com>
> > > ---
> > >
> > > diff --git a/drivers/scsi/qla2xxx/Kconfig b/drivers/scsi/qla2xxx/Kconfig
> > > --- a/drivers/scsi/qla2xxx/Kconfig
> > > +++ b/drivers/scsi/qla2xxx/Kconfig
> > > @@ -39,3 +39,11 @@ config SCSI_QLA6312
> > >     ---help---
> > >     This driver supports the QLogic 63xx (ISP6312 and ISP6322) host
> > >     adapter family.
> > > +
> > > +config SCSI_QLA24XX
> > > +   tristate "QLogic ISP24xx host adapter family support"
> > > +   depends on SCSI_QLA2XXX
> > > +        select SCSI_FC_ATTRS
> >
> > there should be also "select FW_LOADER", as it uses request_firmware &
> > release_firmware
> >...
> 
> You are right, patch below.
> 
> > Jindrich Makovicka
> 
> cu
> Adrian
> 
> 
> <--  snip  -->
> 
> 
> qla_init.c now uses code that requires FW_LOADER.
> 
> Additionally, this patch removes spaces instead of tabs at the
> SCSI_FC_ATTRS selects.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.13-rc3-mm1-full/drivers/scsi/qla2xxx/Kconfig.old  2005-07-17 15:44:26.000000000 +0200
> +++ linux-2.6.13-rc3-mm1-full/drivers/scsi/qla2xxx/Kconfig      2005-07-17 15:45:45.000000000 +0200
> @@ -1,49 +1,55 @@
>  config SCSI_QLA2XXX
>         tristate
>         depends on SCSI && PCI
>         default y
> 
>  config SCSI_QLA21XX
>         tristate "QLogic ISP2100 host adapter family support"
>         depends on SCSI_QLA2XXX
> -        select SCSI_FC_ATTRS
> +       select SCSI_FC_ATTRS
> +       select FW_LOADER
>         ---help---
>         This driver supports the QLogic 21xx (ISP2100) host adapter family.
> 
>  config SCSI_QLA22XX
>         tristate "QLogic ISP2200 host adapter family support"
>         depends on SCSI_QLA2XXX
> -        select SCSI_FC_ATTRS
> +       select SCSI_FC_ATTRS
> +       select FW_LOADER
>         ---help---
>         This driver supports the QLogic 22xx (ISP2200) host adapter family.
> 
>  config SCSI_QLA2300
>         tristate "QLogic ISP2300 host adapter family support"
>         depends on SCSI_QLA2XXX
> -        select SCSI_FC_ATTRS
> +       select SCSI_FC_ATTRS
> +       select FW_LOADER
>         ---help---
>         This driver supports the QLogic 2300 (ISP2300 and ISP2312) host
>         adapter family.
> 
>  config SCSI_QLA2322
>         tristate "QLogic ISP2322 host adapter family support"
>         depends on SCSI_QLA2XXX
> -        select SCSI_FC_ATTRS
> +       select SCSI_FC_ATTRS
> +       select FW_LOADER
>         ---help---
>         This driver supports the QLogic 2322 (ISP2322) host adapter family.
> 
>  config SCSI_QLA6312
>         tristate "QLogic ISP63xx host adapter family support"
>         depends on SCSI_QLA2XXX
> -        select SCSI_FC_ATTRS
> +       select SCSI_FC_ATTRS
> +       select FW_LOADER
>         ---help---
>         This driver supports the QLogic 63xx (ISP6312 and ISP6322) host
>         adapter family.
> 
>  config SCSI_QLA24XX
>         tristate "QLogic ISP24xx host adapter family support"
>         depends on SCSI_QLA2XXX
> -        select SCSI_FC_ATTRS
> +       select SCSI_FC_ATTRS
> +       select FW_LOADER
>         ---help---
>         This driver supports the QLogic 24xx (ISP2422 and ISP2432) host
>         adapter family.

I send a patch for this yesterday that lets SCSI_QLA2XXX select
FW_LOADER. I believe that's a bit better since the other options
depend on SCSI_QLA2XXX anyway, there's no point in having them all set
FW_LOADER. My patch also fixes another little issue; that you cannot
disable SCSI_QLA2XXX if you don't need it.

See the patch here: http://lkml.org/lkml/2005/7/19/147
The mail contains 3 patches, but the third one is the best fix IMHO.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
