Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVIKAzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVIKAzg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 20:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVIKAzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 20:55:36 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:21984 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964785AbVIKAzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 20:55:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=eytV464y1B/jHa9XF8bJVJBQeHPQrfiz+IKDgANrna0nPXmx/n+N2AyeVi3hTCbHj29/PfIMclGu3FFdi5nuvvDz44Zzlm5MKu35VNOB+3Q0f8kyxHLdSzcy6DalEMwQ4SLxHomSFdWCZ494miCnEDIqH+Y3DmvNicqIBZhtUUc=
Message-ID: <4323804A.3090509@gmail.com>
Date: Sun, 11 Sep 2005 08:54:34 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Dittmer <jdittmer@ppp0.net>
CC: linux-fbdev-devel@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: -git10 undefined reference to `i2c_bit_add_bus'
References: <432313E3.9030208@ppp0.net>
In-Reply-To: <432313E3.9030208@ppp0.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer wrote:
> I didn't look into details, but attached config does not
> compile anymore after selecting the new (compared to
> 2.6.13-rc6-git5) option CONFIG_FB_I810_I2C.
> 
> 
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `i810_setup_i2c_bus':
> i810-i2c.c:(.text+0x657d2): undefined reference to `i2c_bit_add_bus'
> drivers/built-in.o: In function `i810_delete_i2c_busses':
> : undefined reference to `i2c_bit_del_bus'
> drivers/built-in.o: In function `i810_delete_i2c_busses':
> : undefined reference to `i2c_bit_del_bus'
> drivers/built-in.o: In function `i810_do_probe_i2c_edid':
> i810-i2c.c:(.text+0x6599b): undefined reference to `i2c_transfer'
> make: *** [.tmp_vmlinux1] Error 1
> 

Try the attached patch.  Run your make *config again, then recompile.

Fix compile error if CONFIG_FB_I810_I2C is 'y' and CONFIG_I2C = 'm'.

Signed-off-by: Antonino Daplas <adaplas@pol.net>

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -708,7 +708,8 @@ config FB_I810_GTF
 
 config FB_I810_I2C
 	bool "Enable DDC Support"
-	depends on FB_I810 && I2C && FB_I810_GTF
+	depends on FB_I810 && FB_I810_GTF
+	select I2C
 	select I2C_ALGOBIT
 	help
 
