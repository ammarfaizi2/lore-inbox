Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWFZOKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWFZOKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWFZOKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:10:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:15381 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030223AbWFZOKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:10:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pv7vBPqSEHHxDEnHfvkycecjRn07eYRaRYtLEDvg6K98qZT8tEwVWvcEDUFVes8YvdFuoRqX2wQMkgFy7fbJXs6uK395Ds/BZbk72AyQeaUKl/0DN2+tH4jQLCDDqd4CMlaHsrOVHy9IH+MEetEAC/2rLGPGkmPUb9gR1mJ/9PA=
Message-ID: <d120d5000606260710g5f93773fuf7b94d85830fbed5@mail.gmail.com>
Date: Mon, 26 Jun 2006 10:10:16 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/input/misc/wistron_btns.c: section fixes
Cc: mitr@volny.cz, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <200606260750.32863.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060626103509.GQ23314@stusta.de>
	 <200606260750.32863.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/06, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Monday 26 June 2006 06:35, Adrian Bunk wrote:
> > This patch contains the following fixes:
> > - it doesn't make sense to mark a variable on the stack as __initdata
> > - struct dmi_ids is using the __init dmi_matched()
>
> Since when did static variables become allocated on stack?
>

BTW, if I add __intidata to dmi_ids array GCC (3.4.4) bitches at me:

  CC      drivers/input/misc/wistron_btns.o
drivers/input/misc/wistron_btns.c:345: error: dmi_ids causes a section
type conflict
make[1]: *** [drivers/input/misc/wistron_btns.o] Error 1
make: *** [drivers/input/misc/] Error 2

I have to declare it as "static const struct dmi_system_id __initdata
dmi_ids[] = {..." for it to compile successfully, but there is a
comment that we should not use const with __initdata. Although I
checked the assembly oputput and const __initdata endes up in
init.data section - exactly where we want it. Wierd...

-- 
Dmitry
