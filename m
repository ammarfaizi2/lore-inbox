Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWHWE1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWHWE1c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 00:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWHWE1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 00:27:32 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:55923 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932346AbWHWE1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 00:27:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S4gH4ideHSRpnOqz1Iv7JQdMeDpsraC46tQSiFGDjcdHdFK1A3R0IHJNRCEgML3H0eUEzGa2dbtKi/gOLKCK93La3wIwMJPyiMs2G8W4H1G5op4mOHCXCKLbbeEgB0qo3X6JeemKahB8329ekxyYu1xsM6/JhxtlPJqwNdoIzbo=
Message-ID: <36e6b2150608222127y39bb9314h9b0a31f1f8b6b399@mail.gmail.com>
Date: Wed, 23 Aug 2006 08:27:30 +0400
From: "Paul Drynoff" <pauldrynoff@gmail.com>
To: "Jeremy Fitzhardinge" <jeremy@goop.org>
Subject: Re: [BUG] Can not boot linux-2.6.18-rc4-mm2
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Jeremy Fitzhardinge" <jeremy@xensource.com>,
       linux-kernel@vger.kernel.org, "Zachary Amsden" <zach@vmware.com>
In-Reply-To: <44EB7D2D.7000006@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060822125118.12ba1ed4.pauldrynoff@gmail.com>
	 <20060822123850.bdb09717.akpm@osdl.org>
	 <36e6b2150608221413h3b6baf24lf670a2aed61c0c57@mail.gmail.com>
	 <44EB7D2D.7000006@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/06, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> Hm.  Try this:
> --- a/arch/i386/kernel/paravirt.c
> +++ b/arch/i386/kernel/paravirt.c
I have no such file.

> --- a/include/asm-i386/desc.h
> +++ b/include/asm-i386/desc.h
> @@ -97,7 +97,7 @@ static inline void set_ldt(const void *a
>         __u32 low, high;
>
>         pack_descriptor(&low, &high, (unsigned long)addr,
> -                       entries * sizeof(struct desc_struct) - 1,
> +                       entries * sizeof(struct desc_struct),
>                         DESCTYPE_LDT, 0);
>         write_gdt_entry(get_cpu_gdt_table(cpu), GDT_ENTRY_LDT, low, high);

There is no such code in this file.

I adopt your code for linux-2.6.18-rc4-mm2, and looks like it fix bug.

Index: linux-2.6.18-rc4-mm2/include/asm-i386/desc.h
===================================================================
--- linux-2.6.18-rc4-mm2.orig/include/asm-i386/desc.h
+++ linux-2.6.18-rc4-mm2/include/asm-i386/desc.h
@@ -114,7 +114,7 @@ static inline void set_ldt_desc(unsigned
 {
        __u32 a, b;
        pack_descriptor(&a, &b, (unsigned long)addr,
-                       entries * sizeof(struct desc_struct) - 1,
+                       entries * sizeof(struct desc_struct),
                        DESCTYPE_LDT, 0);
        write_gdt_entry(get_cpu_gdt_table(cpu), GDT_ENTRY_LDT, a, b);
 }
