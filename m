Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130394AbQKVARt>; Tue, 21 Nov 2000 19:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130022AbQKVARk>; Tue, 21 Nov 2000 19:17:40 -0500
Received: from digger1.defence.gov.au ([203.5.217.4]:35752 "EHLO
	digger1.defence.gov.au") by vger.kernel.org with ESMTP
	id <S129692AbQKVARZ>; Tue, 21 Nov 2000 19:17:25 -0500
Message-ID: <2149A0BABC77D311AF890090274E00B2024C9C55@salex005.dsto.defence.gov.au>
From: "Shahin, Mofeed" <Mofeed.Shahin@dsto.defence.gov.au>
To: "'Vitali Lieder'" <vitali@physik.TU-Berlin.DE>,
        linux-kernel@vger.kernel.org
Subject: RE: NVdriver-problem with 2.4.0-test11
Date: Wed, 22 Nov 2000 10:11:11 +1030
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Umm what worked for me was to do the following :

change the following line in os-interface.c (Part of NVIDIA_kernel package):
    symbol_value = get_module_symbol(NV_MODULE_NAME, symbol_name);
to :
    symbol_value = inter_module_get_request(NV_MODULE_NAME, symbol_name);

and then remove the following lines which appear after the above lines :

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
    put_module_symbol(symbol_value);
#endif

Now there may be something else that needs changing, but after doing the
above, the driver loaded up fine as did XFree86.

Mof.


> From: Vitali Lieder [mailto:vitali@physik.TU-Berlin.DE]
> 
> Hallo!
> 
> With new 2.4.0-test11 kernel i have the problem with NVdriver-0.95:
> 
> depmod: *** unresolved symbols in 
> /lib/modules/2.4.0-test11/video/NVdriver
> 
> /lib/modules/2.4.0-test11/video/Nvdriver:unresolved symbol in 
> put_module_symbol
> /lib/modules/2.4.0-test11/video/NVdriver:unresolved symbol in 
> get_module_symbol
> 
> Please, could you explain me, how i can find in patch the 
> #define's lines
> with this symbols, that was cleaned from kernel, so that i 
> can place that
> lines by myself in future.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
