Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132056AbRDGXYs>; Sat, 7 Apr 2001 19:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132057AbRDGXYj>; Sat, 7 Apr 2001 19:24:39 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:50440 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132056AbRDGXYU>; Sat, 7 Apr 2001 19:24:20 -0400
Message-Id: <200104072324.f37NOCs90832@aslan.scsiguy.com>
To: lists@sapience.com
cc: "J . A . Magallon" <jamagallon@able.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx 6.1.10 and 2.4.4-pre1 
In-Reply-To: Your message of "Sat, 07 Apr 2001 17:55:05 EDT."
             <20010407175505.A25801@sapience.com> 
Date: Sat, 07 Apr 2001 17:24:12 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   So I started again - installed redhat 7.0.9.
>   took 2.4.4-pre1  and patched it with 
>   linux-aic7xxx-6.1.10-2.4.3.patch
>
>   Patch applied cleanly but when I compile it complains a little:
>
>   In file included from aic7xxx_linux.c:131:
>   aic7xxx_osm.h: In function `ahc_pci_read_config':
>   aic7xxx_osm.h:862: warning: control reaches end of non-void function
>   
>   (for several .c files but always refers to 'ahc_pci_read_config')

This is because panic() is not marked as a "no return" function.  So,
GCC compains that, in the panic() case, we don't return a value from
this particular function.  Since we will never return in that case,
it is, at least in the aic7xxx driver, a harmless warning.

--
Justin
