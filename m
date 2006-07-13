Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWGMSau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWGMSau (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWGMSau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:30:50 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:15787 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030279AbWGMSat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:30:49 -0400
Date: Thu, 13 Jul 2006 20:29:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arjan van de Ven <arjan@infradead.org>, jakub@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linker error with latest tree on EM64T
Message-ID: <20060713182947.GA32260@mars.ravnborg.org>
References: <1152788160.4838.2.camel@localhost> <1152788387.3024.32.camel@laptopd505.fenrus.org> <1152791882.4838.6.camel@localhost> <20060713132631.GA21657@mars.ravnborg.org> <1152797421.4838.12.camel@localhost> <20060713161020.GA22355@mars.ravnborg.org> <1152807426.4838.59.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152807426.4838.59.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 06:17:06PM +0200, Marcel Holtmann wrote:
> 
> see my previous email. This patch fixed it for me:
> 
> diff --git a/Makefile b/Makefile
> index 7c010f3..b4a2a80 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -308,7 +308,7 @@ LINUXINCLUDE    := -Iinclude \
>  CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
>  
>  CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
> -                   -fno-strict-aliasing -fno-common
> +                   -fno-strict-aliasing -fno-common -fno-stack-protector
>  # Force gcc to behave correct even for buggy distributions
>  CFLAGS          += $(call cc-option, -fno-stack-protector-all \
>                                       -fno-stack-protector)
> 
> > Also could you try executing:
> > if gcc -fno-stack-protector-all -S -o /dev/null -xc /dev/null; then \
> >   echo "y"; else echo "n"; fi
> > And see if this gives a "y" or a "n".
> > Try with -fno-stack-protector-all and with -fno-stack-protector.
> 
> With -fno-stack-protector I get a "y" and with -fno-stack-protector-all
> I get an error:
> 
> cc1: error: unrecognized command line option "-fno-stack-protector-all"
OK. I changed it to apply only -fno-stack-protector (not the -all
version).

	Sam
