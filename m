Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbTH1RTL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 13:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTH1RTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 13:19:11 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:62482 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S264069AbTH1RTI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 13:19:08 -0400
Subject: Re: 2.6.0-test4-mm2
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030828090240.2cccf4d9.akpm@osdl.org>
References: <20030826221053.25aaa78f.akpm@osdl.org>
	 <1062075227.422.2.camel@lorien>  <20030828090240.2cccf4d9.akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1062090715.484.1.camel@lorien>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 28 Aug 2003 14:11:56 -0300
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qui, 2003-08-28 às 13:02, Andrew Morton escreveu:
> Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br> wrote:
> >
> > when using the hdparm program, thus:
> > 
> >  # hdparm /dev/hda
> > 
> >  I'm getting this:
> > 
> >  Oops: 0000 [#1]
> 
> This should fix it.
> 
> --- 25/include/linux/genhd.h~large-dev_t-12-fix	2003-08-27 10:36:32.000000000 -0700
> +++ 25-akpm/include/linux/genhd.h	2003-08-27 10:36:32.000000000 -0700
> @@ -197,7 +197,7 @@ extern void rand_initialize_disk(struct 
>  
>  static inline sector_t get_start_sect(struct block_device *bdev)
>  {
> -	return bdev->bd_part->start_sect;
> +	return bdev->bd_contains == bdev ? 0 : bdev->bd_part->start_sect;
>  }
>  static inline sector_t get_capacity(struct gendisk *disk)
>  {

 fixed! :)

 thanks,

-- 
Luiz Fernando N. Capitulino

<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

