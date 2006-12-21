Return-Path: <linux-kernel-owner+w=401wt.eu-S1422740AbWLUP3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422740AbWLUP3q (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 10:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422861AbWLUP3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 10:29:46 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:49448 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422740AbWLUP3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 10:29:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=eb12bPI1ZDg8yXui+r8jtifScUWBfx5C9iuz5sfvTrZrJatN1cRbm0d5vtyv82lpNoF5KusRugGSmyFOnFz1RL3vS1HZIodU1qd/s1YveJlYmMMv21LE3r/3MMKoA4wvEgdhirdIWH3DNCJye8kNT2tu38bLd9FzjAVj/6JYYn8=
Message-ID: <74d0deb30612210729g65dd6b3cr7594ae6cd0f8055e@mail.gmail.com>
Date: Thu, 21 Dec 2006 16:29:44 +0100
From: "pHilipp Zabel" <philipp.zabel@gmail.com>
To: "Arnaud Patard" <apatard@mandriva.com>
Subject: Re: [patch 2.6.20-rc1 6/6] S3C2410 GPIO wrappers
Cc: "David Brownell" <david-b@pacbell.net>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Andrew Victor" <andrew@sanpeople.com>,
       "Bill Gatliff" <bgat@billgatliff.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       "Kevin Hilman" <khilman@mvista.com>, "Nicolas Pitre" <nico@cam.org>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>, "Ben Dooks" <ben-linux@fluff.org>
In-Reply-To: <m3ac1h7d3s.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_34249_9091914.1166714984301"
References: <200611111541.34699.david-b@pacbell.net>
	 <200612201304.03912.david-b@pacbell.net>
	 <200612201314.19905.david-b@pacbell.net>
	 <m3ac1h7d3s.fsf@anduin.mandriva.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_34249_9091914.1166714984301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/21/06, Arnaud Patard <apatard@mandriva.com> wrote:
> (adding Ben Dooks as he's taking care of s3c24xx stuff)
>
> David Brownell <david-b@pacbell.net> writes:
>
>
> Note that I neither tested it nor build tested it. It's only remarks I
> have when I read the code.

Thanks for looking through this. I originally just sent this
(admittedly rushed) patch to kernel-discuss@handhelds.org
to get some eyes on it. Sorry about that.
I have no S3C24xx machine, so I'd like very much somebody
and with some insight to S3C24xx who can test to try and
correct this.

> > Arch-neutral GPIO calls for S3C24xx.
> >
> > From: Philipp Zabel <philipp.zabel@gmail.com>
> >
> > Index: at91/include/asm-arm/arch-s3c2410/gpio.h
> > ===================================================================
> > --- /dev/null 1970-01-01 00:00:00.000000000 +0000
> > +++ at91/include/asm-arm/arch-s3c2410/gpio.h  2006-12-19 02:05:52.000000000 -0800
> > @@ -0,0 +1,65 @@
> > +/*
> > + * linux/include/asm-arm/arch-pxa/gpio.h
>
> arch-pxa ? forgot to change it ? :)

Exactly.

> > + *
> > + * S3C2400 GPIO wrappers for arch-neutral GPIO calls
>
> you meant S3C2410 ?

I got a little confused with s3c2410 being the name for all s3c24xx
architectures.

> > + *
> > + * Written by Philipp Zabel <philipp.zabel@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> > + *
> > + */
> > +
> > +#ifndef __ASM_ARCH_PXA_GPIO_H
> > +#define __ASM_ARCH_PXA_GPIO_H
>
> pxa again :(

Not anymore.

> > +
> > +#include <asm/arch/pxa-regs.h>
>
> That's annoying. include/asm-arm/arch-s3c2410/pxa-regs.h doesn't
> exist. Lack of build testing ?

Yes, see above.

> > +#include <asm/arch/irqs.h>
>
> imho, this is not needed. The user who will use irq will add it in his
> code anyway.

Ok.

> > +#include <asm/arch/hardware.h>
> > +
> > +#include <asm/errno.h>
>
> Is it really needed ?

No. I copied this from David's example,
but with gpio_request and gpio_free not
implemented and missing error handling
in s3c2410_gpio_cfgpin, no error codes
are needed.

> > +
> > +static inline int gpio_request(unsigned gpio, const char *label)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline void gpio_free(unsigned gpio)
> > +{
> > +     return;
> > +}
> > +
> > +static inline int gpio_direction_input(unsigned gpio)
> > +{
> > +     s3c2410_gpio_cfgpin(gpio, S3C2410_GPIO_INPUT);
> > +     return 0;
> > +}
> > +
> > +static inline int gpio_direction_output(unsigned gpio)
> > +{
> > +     s3c2410_gpio_cfgpin(gpio, S3C2410_GPIO_OUTPUT);
> > +     return 0;
> > +}
> > +
> > +#define gpio_get_value(gpio)         s3c2410_gpio_getpin(gpio)
> > +#define gpio_set_value(gpio,value)   s3c2410_gpio_setpin(gpio, value)
> > +
> > +#include <asm-generic/gpio.h>                        /* cansleep wrappers */
> > +
> > +/* FIXME or maybe s3c2400_gpio_getirq() ... */
> > +#define gpio_to_irq(gpio)            s3c2410_gpio_getirq(gpio)
>
> imho, this should be fixed even if the s3c2400 is not 100% supported in
> mainline.

Ok. Could anybody knowledgeable provide an irq_to_gpio function?

regards
Philipp

Index: linux-2.6/include/asm-arm/arch-s3c2410/gpio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/include/asm-arm/arch-s3c2410/gpio.h	2006-12-21
13:25:44.000000000 +0100
@@ -0,0 +1,65 @@
+/*
+ * linux/include/asm-arm/arch-pxa/gpio.h
+ *
+ * S3C2410 GPIO wrappers for arch-neutral GPIO calls
+ *
+ * Written by Philipp Zabel <philipp.zabel@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#ifndef __ASM_ARCH_S3C2410_GPIO_H
+#define __ASM_ARCH_S3C2410_GPIO_H
+
+#include <asm/arch/irqs.h>
+#include <asm/arch/hardware.h>
+
+static inline int gpio_request(unsigned gpio, const char *label)
+{
+	return 0;
+}
+
+static inline void gpio_free(unsigned gpio)
+{
+	return;
+}
+
+static inline int gpio_direction_input(unsigned gpio)
+{
+	s3c2410_gpio_cfgpin(gpio, S3C2410_GPIO_INPUT);
+	return 0;
+}
+
+static inline int gpio_direction_output(unsigned gpio)
+{
+	s3c2410_gpio_cfgpin(gpio, S3C2410_GPIO_OUTPUT);
+	return 0;
+}
+
+#define gpio_get_value(gpio)		s3c2410_gpio_getpin(gpio)
+#define gpio_set_value(gpio,value)	s3c2410_gpio_setpin(gpio, value)
+
+#include <asm-generic/gpio.h>			/* cansleep wrappers */
+
+#ifdef CONFIG_CPU_S3C2400
+#define gpio_to_irq(gpio)		s3c2400_gpio_getirq(gpio)
+#else
+#define gpio_to_irq(gpio)		s3c2410_gpio_getirq(gpio)
+#endif /* CONFIG_CPU_S3C2400 */
+
+/* FIXME implement irq_to_gpio() */
+
+#endif

------=_Part_34249_9091914.1166714984301
Content-Type: text/x-patch; name=gpio-calls-s3c24xx.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_evzbsw5t
Content-Disposition: attachment; filename="gpio-calls-s3c24xx.patch"

SW5kZXg6IGxpbnV4LTIuNi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1zM2MyNDEwL2dwaW8uaAo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Ci0tLSAvZGV2L251bGwJMTk3MC0wMS0wMSAwMDowMDowMC4wMDAwMDAwMDAgKzAwMDAK
KysrIGxpbnV4LTIuNi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1zM2MyNDEwL2dwaW8uaAkyMDA2LTEy
LTIxIDEzOjI1OjQ0LjAwMDAwMDAwMCArMDEwMApAQCAtMCwwICsxLDY1IEBACisvKgorICogbGlu
dXgvaW5jbHVkZS9hc20tYXJtL2FyY2gtcHhhL2dwaW8uaAorICoKKyAqIFMzQzI0MTAgR1BJTyB3
cmFwcGVycyBmb3IgYXJjaC1uZXV0cmFsIEdQSU8gY2FsbHMKKyAqCisgKiBXcml0dGVuIGJ5IFBo
aWxpcHAgWmFiZWwgPHBoaWxpcHAuemFiZWxAZ21haWwuY29tPgorICoKKyAqIFRoaXMgcHJvZ3Jh
bSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5
CisgKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IGFzIHB1Ymxpc2hlZCBieQorICogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVy
IHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqIChhdCB5b3VyIG9wdGlvbikgYW55IGxh
dGVyIHZlcnNpb24uCisgKgorICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBo
b3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7
IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogTUVSQ0hBTlRBQklMSVRZ
IG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiBTZWUgdGhlCisgKiBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqIFlvdSBzaG91bGQg
aGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisg
KiBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0
d2FyZQorICogRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJv
c3RvbiwgTUEgMDIxMTEtMTMwNyBVU0EKKyAqCisgKi8KKworI2lmbmRlZiBfX0FTTV9BUkNIX1Mz
QzI0MTBfR1BJT19ICisjZGVmaW5lIF9fQVNNX0FSQ0hfUzNDMjQxMF9HUElPX0gKKworI2luY2x1
ZGUgPGFzbS9hcmNoL2lycXMuaD4KKyNpbmNsdWRlIDxhc20vYXJjaC9oYXJkd2FyZS5oPgorCitz
dGF0aWMgaW5saW5lIGludCBncGlvX3JlcXVlc3QodW5zaWduZWQgZ3BpbywgY29uc3QgY2hhciAq
bGFiZWwpCit7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBncGlvX2ZyZWUo
dW5zaWduZWQgZ3BpbykKK3sKKwlyZXR1cm47Cit9CisKK3N0YXRpYyBpbmxpbmUgaW50IGdwaW9f
ZGlyZWN0aW9uX2lucHV0KHVuc2lnbmVkIGdwaW8pCit7CisJczNjMjQxMF9ncGlvX2NmZ3Bpbihn
cGlvLCBTM0MyNDEwX0dQSU9fSU5QVVQpOworCXJldHVybiAwOworfQorCitzdGF0aWMgaW5saW5l
IGludCBncGlvX2RpcmVjdGlvbl9vdXRwdXQodW5zaWduZWQgZ3BpbykKK3sKKwlzM2MyNDEwX2dw
aW9fY2ZncGluKGdwaW8sIFMzQzI0MTBfR1BJT19PVVRQVVQpOworCXJldHVybiAwOworfQorCisj
ZGVmaW5lIGdwaW9fZ2V0X3ZhbHVlKGdwaW8pCQlzM2MyNDEwX2dwaW9fZ2V0cGluKGdwaW8pCisj
ZGVmaW5lIGdwaW9fc2V0X3ZhbHVlKGdwaW8sdmFsdWUpCXMzYzI0MTBfZ3Bpb19zZXRwaW4oZ3Bp
bywgdmFsdWUpCisKKyNpbmNsdWRlIDxhc20tZ2VuZXJpYy9ncGlvLmg+CQkJLyogY2Fuc2xlZXAg
d3JhcHBlcnMgKi8KKworI2lmZGVmIENPTkZJR19DUFVfUzNDMjQwMAorI2RlZmluZSBncGlvX3Rv
X2lycShncGlvKQkJczNjMjQwMF9ncGlvX2dldGlycShncGlvKQorI2Vsc2UKKyNkZWZpbmUgZ3Bp
b190b19pcnEoZ3BpbykJCXMzYzI0MTBfZ3Bpb19nZXRpcnEoZ3BpbykKKyNlbmRpZiAvKiBDT05G
SUdfQ1BVX1MzQzI0MDAgKi8KKworLyogRklYTUUgaW1wbGVtZW50IGlycV90b19ncGlvKCkgKi8K
KworI2VuZGlmCg==
------=_Part_34249_9091914.1166714984301--
