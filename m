Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311351AbSCLVu0>; Tue, 12 Mar 2002 16:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311354AbSCLVuH>; Tue, 12 Mar 2002 16:50:07 -0500
Received: from mail12.speakeasy.net ([216.254.0.212]:42148 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S311351AbSCLVtz>; Tue, 12 Mar 2002 16:49:55 -0500
Subject: [PATCH]  Missing PPPoE patch from 2.4.19-pre3
From: Michal Ostrowski <mostrows@speakeasy.net>
To: Paul MacKerras <paulus@samba.org>, marcelo@conectiva.com.br,
        skraw@ithnet.com, jojo.escubil@compass.com.ph
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15502.27007.923468.211270@argo.ozlabs.ibm.com>
In-Reply-To: <15502.27007.923468.211270@argo.ozlabs.ibm.com>
Content-Type: multipart/mixed; boundary="=-3hjXR9g+U7LPsIxC21UZ"
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 12 Mar 2002 16:49:51 -0500
Message-Id: <1015969792.12701.1588.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3hjXR9g+U7LPsIxC21UZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Part of Paul MacKerras's PPP patches got dropped somewhere.

Here's the missing part.

Michal Ostrowski
mostrows@speakeasy.net

> ---------- Forwarded message ----------
> Date: Mon, 11 Mar 2002 23:55:23 +0100
> From: Stephan von Krawczynski <skraw@ithnet.com>
> To: Marcelo Tosatti <marcelo@conectiva.com.br>
> Cc: lkml <linux-kernel@vger.kernel.org>
> Subject: Re: Linux 2.4.19-pre3
> 
> >                                                                     
> > Hi,                                                                 
> >                                                                     
> > Here goes -pre3, with the new IDE code. It has been stable enough   
> time in                                                               
> > the -ac tree, in my and Alan's opinion.                             
> >                                                                     
> > The inclusion of the new IDE code makes me want to have a longer    
> 2.4.19                                                                
> > release cycle, for stress-testing reasons.                          
> >                                                                     
> > Please stress test it with huge amounts of data ;)                  
>                                                                       
> Would like to, but:                                                   
>                                                                       
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-pre3/include -Wall           
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer           
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2   
> -march=i686 -DMODULE  -DKBUILD_BASENAME=pppoe  -c -o pppoe.o pppoe.c  
> pppoe.c: In function `pppoe_flush_dev':                               
> pppoe.c:282: `PPPOX_ZOMBIE' undeclared (first use in this function)   
> pppoe.c:282: (Each undeclared identifier is reported only once        
> pppoe.c:282: for each function it appears in.)                        
> pppoe.c: In function `pppoe_disc_rcv':                                
> pppoe.c:446: `PPPOX_ZOMBIE' undeclared (first use in this function)   
> pppoe.c: In function `pppoe_ioctl':                                   
> pppoe.c:730: `PPPOX_ZOMBIE' undeclared (first use in this function)   
> make[2]: *** [pppoe.o] Error 1                                        
> make[2]: Leaving directory `/usr/src/linux-2.4.19-pre3/drivers/net'   
> make[1]: *** [_modsubdir_net] Error 2                                 
> make[1]: Leaving directory `/usr/src/linux-2.4.19-pre3/drivers'       
> make: *** [_mod_drivers] Error 2                                      
>                                                                       
>                                                                       
> Regards,                                                              
> Stephan                                                               
> 


--=-3hjXR9g+U7LPsIxC21UZ
Content-Disposition: attachment; filename=pppoe.patch3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ISO-8859-1

diff -r -u linux.old/include/linux/if_pppox.h linux/include/linux/if_pppox.=
h
--- linux.old/include/linux/if_pppox.h	Thu Nov 22 14:47:14 2001
+++ linux/include/linux/if_pppox.h	Fri Jan 25 07:39:15 2002
@@ -126,13 +126,14 @@
 extern int pppox_channel_ioctl(struct ppp_channel *pc, unsigned int cmd,
 			       unsigned long arg);
=20
-/* PPPoE socket states */
+/* PPPoX socket states */
 enum {
     PPPOX_NONE		=3D 0,  /* initial state */
     PPPOX_CONNECTED	=3D 1,  /* connection established =3D=3DTCP_ESTABLISHE=
D */
     PPPOX_BOUND		=3D 2,  /* bound to ppp device */
     PPPOX_RELAY		=3D 4,  /* forwarding is enabled */
-    PPPOX_DEAD		=3D 8
+    PPPOX_ZOMBIE	=3D 8,  /* dead, but still bound to ppp device */
+    PPPOX_DEAD		=3D 16  /* dead, useless, please clean me up!*/
 };
=20
 extern struct ppp_channel_ops pppoe_chan_ops;

--=-3hjXR9g+U7LPsIxC21UZ--

