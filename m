Return-Path: <linux-kernel-owner+w=401wt.eu-S1422826AbWLUPDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422826AbWLUPDq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 10:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422832AbWLUPDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 10:03:46 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:31754 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422826AbWLUPDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 10:03:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=L8oMDR0rEjeDN4jegj/dK/ep+6oTX21N1iQml0u2Fso09ahCJAzbxDXfXCY4lMWlAB9PsQ+Pv7UPf9Th5mp4YzICGR1TWU3fCR9d36AiOpyMD8f/3zLrHevaIMzaesAAHS75paEZS+X/atyAh0maJsReUBwDcA6kd0l8hxNTeGQ=
Message-ID: <74d0deb30612210703y735e53kf14e7c800dae7140@mail.gmail.com>
Date: Thu, 21 Dec 2006 16:03:42 +0100
From: "pHilipp Zabel" <philipp.zabel@gmail.com>
To: "Nicolas Pitre" <nico@cam.org>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
Cc: "David Brownell" <david-b@pacbell.net>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Victor" <andrew@sanpeople.com>,
       "Bill Gatliff" <bgat@billgatliff.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       "Kevin Hilman" <khilman@mvista.com>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>
In-Reply-To: <Pine.LNX.4.64.0612210925130.18171@xanadu.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_33797_20942520.1166713422990"
References: <200611111541.34699.david-b@pacbell.net>
	 <200612201312.36616.david-b@pacbell.net>
	 <20061220221252.732f4e97.akpm@osdl.org>
	 <200612202244.03351.david-b@pacbell.net>
	 <Pine.LNX.4.64.0612210925130.18171@xanadu.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_33797_20942520.1166713422990
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/21/06, Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 20 Dec 2006, David Brownell wrote:
>
> > On Wednesday 20 December 2006 10:12 pm, Andrew Morton wrote:
> > > Why not implement them as inline functions?
> >
> > I just collected and forwarded the code from Philip...
> > the better not to lose such stuff!  :)
> >
> >
> > > Or non-inline functions, come to that.
> >
> > In this case I think that'd be preferable; see what those macros
> > expand to on pxa27x CPUs.
>
> Only if the gpio argument is not constant please.  When it is constant
> this expands to a single word store.
>
>
> Nicolas

David suggested to have both inline and non-inline functions depending
on whether gpio is constant. How is this patch?

regards
Philipp

Index: linux-2.6/include/asm-arm/arch-pxa/gpio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/include/asm-arm/arch-pxa/gpio.h	2006-12-21
07:57:12.000000000 +0100
@@ -0,0 +1,86 @@
+/*
+ * linux/include/asm-arm/arch-pxa/gpio.h
+ *
+ * PXA GPIO wrappers for arch-neutral GPIO calls
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
+#ifndef __ASM_ARCH_PXA_GPIO_H
+#define __ASM_ARCH_PXA_GPIO_H
+
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/irqs.h>
+#include <asm/arch/hardware.h>
+
+#include <asm/errno.h>
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
+	if (gpio > PXA_LAST_GPIO)
+		return -EINVAL;
+	pxa_gpio_mode(gpio | GPIO_IN);
+}
+
+static inline int gpio_direction_output(unsigned gpio)
+{
+	if (gpio > PXA_LAST_GPIO)
+		return -EINVAL;
+	pxa_gpio_mode(gpio | GPIO_OUT);
+}
+
+static inline int __gpio_get_value(unsigned gpio)
+{
+	return GPLR(gpio) & GPIO_bit(gpio);
+}
+
+#define gpio_get_value(gpio)			\
+	(__builtin_constant_p(gpio) ?		\
+	 __gpioe_get_value(gpio) :		\
+	 pxa_gpio_get_value(gpio))
+
+static inline void __gpio_set_value(unsigned gpio, int value)
+{
+	if (value)
+		GPSR(gpio) = GPIO_bit(gpio);
+	else
+		GPCR(gpio) = GPIO_bit(gpio);
+}
+
+#define gpio_set_value(gpio,value)		\
+	(__builtin_constant_p(gpio) ?		\
+	 __gpio_set_value(gpio, value) :	\
+	 pxa_gpio_set_value(gpio, value))
+
+#include <asm-generic/gpio.h>			/* cansleep wrappers */
+
+#define gpio_to_irq(gpio)	IRQ_GPIO(gpio)
+#define irq_to_gpio(irq)	IRQ_TO_GPIO(irq)
+
+
+#endif
Index: linux-2.6/arch/arm/mach-pxa/generic.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-pxa/generic.c	2006-12-16
16:47:42.000000000 +0100
+++ linux-2.6/arch/arm/mach-pxa/generic.c	2006-12-16 16:47:45.000000000 +0100
@@ -129,6 +129,29 @@
 EXPORT_SYMBOL(pxa_gpio_mode);

 /*
+ * Return GPIO level, nonzero means high, zero is low
+ */
+int pxa_gpio_get_value(unsigned gpio)
+{
+	return GPLR(gpio) & GPIO_bit(gpio);
+}
+
+EXPORT_SYMBOL(pxa_gpio_get_value);
+
+/*
+ * Set output GPIO level
+ */
+void pxa_gpio_set_value(unsigned gpio, int value)
+{
+	if (value)
+		GPSR(gpio) = GPIO_bit(gpio);
+	else
+		GPCR(gpio) = GPIO_bit(gpio);
+}
+
+EXPORT_SYMBOL(pxa_gpio_set_value);
+
+/*
  * Routine to safely enable or disable a clock in the CKEN
  */
 void pxa_set_cken(int clock, int enable)
Index: linux-2.6/include/asm-arm/arch-pxa/hardware.h
===================================================================
--- linux-2.6.orig/include/asm-arm/arch-pxa/hardware.h	2006-12-17
15:42:36.000000000 +0100
+++ linux-2.6/include/asm-arm/arch-pxa/hardware.h	2006-12-17
15:43:26.000000000 +0100
@@ -68,6 +68,16 @@
 extern void pxa_gpio_mode( int gpio_mode );

 /*
+ * Return GPIO level, nonzero means high, zero is low
+ */
+extern int pxa_gpio_get_value(unsigned gpio);
+
+/*
+ * Set output GPIO level
+ */
+extern void pxa_gpio_set_value(unsigned gpio, int value);
+
+/*
  * Routine to enable or disable CKEN
  */
 extern void pxa_set_cken(int clock, int enable);

------=_Part_33797_20942520.1166713422990
Content-Type: text/x-patch; name=gpio-api-pxa.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_evzaxbyc
Content-Disposition: attachment; filename="gpio-api-pxa.patch"

SW5kZXg6IGxpbnV4LTIuNi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1weGEvZ3Bpby5oCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIC9kZXYvbnVsbAkxOTcwLTAxLTAxIDAwOjAwOjAwLjAwMDAwMDAwMCArMDAwMAorKysg
bGludXgtMi42L2luY2x1ZGUvYXNtLWFybS9hcmNoLXB4YS9ncGlvLmgJMjAwNi0xMi0yMSAwNzo1
NzoxMi4wMDAwMDAwMDAgKzAxMDAKQEAgLTAsMCArMSw4NiBAQAorLyoKKyAqIGxpbnV4L2luY2x1
ZGUvYXNtLWFybS9hcmNoLXB4YS9ncGlvLmgKKyAqCisgKiBQWEEgR1BJTyB3cmFwcGVycyBmb3Ig
YXJjaC1uZXV0cmFsIEdQSU8gY2FsbHMKKyAqCisgKiBXcml0dGVuIGJ5IFBoaWxpcHAgWmFiZWwg
PHBoaWxpcHAuemFiZWxAZ21haWwuY29tPgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hl
ZCBieQorICogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBv
ZiB0aGUgTGljZW5zZSwgb3IKKyAqIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24u
CisgKgorICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQg
d2lsbCBiZSB1c2VmdWwsCisgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZl
biB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1Mg
Rk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiBTZWUgdGhlCisgKiBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZl
ZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiBhbG9uZyB3aXRo
IHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQorICogRm91
bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIx
MTEtMTMwNyBVU0EKKyAqCisgKi8KKworI2lmbmRlZiBfX0FTTV9BUkNIX1BYQV9HUElPX0gKKyNk
ZWZpbmUgX19BU01fQVJDSF9QWEFfR1BJT19ICisKKyNpbmNsdWRlIDxhc20vYXJjaC9weGEtcmVn
cy5oPgorI2luY2x1ZGUgPGFzbS9hcmNoL2lycXMuaD4KKyNpbmNsdWRlIDxhc20vYXJjaC9oYXJk
d2FyZS5oPgorCisjaW5jbHVkZSA8YXNtL2Vycm5vLmg+CisKK3N0YXRpYyBpbmxpbmUgaW50IGdw
aW9fcmVxdWVzdCh1bnNpZ25lZCBncGlvLCBjb25zdCBjaGFyICpsYWJlbCkKK3sKKwlyZXR1cm4g
MDsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGdwaW9fZnJlZSh1bnNpZ25lZCBncGlvKQorewor
CXJldHVybjsKK30KKworc3RhdGljIGlubGluZSBpbnQgZ3Bpb19kaXJlY3Rpb25faW5wdXQodW5z
aWduZWQgZ3BpbykKK3sKKwlpZiAoZ3BpbyA+IFBYQV9MQVNUX0dQSU8pCisJCXJldHVybiAtRUlO
VkFMOworCXB4YV9ncGlvX21vZGUoZ3BpbyB8IEdQSU9fSU4pOworfQorCitzdGF0aWMgaW5saW5l
IGludCBncGlvX2RpcmVjdGlvbl9vdXRwdXQodW5zaWduZWQgZ3BpbykKK3sKKwlpZiAoZ3BpbyA+
IFBYQV9MQVNUX0dQSU8pCisJCXJldHVybiAtRUlOVkFMOworCXB4YV9ncGlvX21vZGUoZ3BpbyB8
IEdQSU9fT1VUKTsKK30KKworc3RhdGljIGlubGluZSBpbnQgX19ncGlvX2dldF92YWx1ZSh1bnNp
Z25lZCBncGlvKQoreworCXJldHVybiBHUExSKGdwaW8pICYgR1BJT19iaXQoZ3Bpbyk7Cit9CisK
KyNkZWZpbmUgZ3Bpb19nZXRfdmFsdWUoZ3BpbykJCQlcCisJKF9fYnVpbHRpbl9jb25zdGFudF9w
KGdwaW8pID8JCVwKKwkgX19ncGlvZV9nZXRfdmFsdWUoZ3BpbykgOgkJXAorCSBweGFfZ3Bpb19n
ZXRfdmFsdWUoZ3BpbykpCisKK3N0YXRpYyBpbmxpbmUgdm9pZCBfX2dwaW9fc2V0X3ZhbHVlKHVu
c2lnbmVkIGdwaW8sIGludCB2YWx1ZSkKK3sKKwlpZiAodmFsdWUpCisJCUdQU1IoZ3BpbykgPSBH
UElPX2JpdChncGlvKTsKKwllbHNlCisJCUdQQ1IoZ3BpbykgPSBHUElPX2JpdChncGlvKTsKK30K
KworI2RlZmluZSBncGlvX3NldF92YWx1ZShncGlvLHZhbHVlKQkJXAorCShfX2J1aWx0aW5fY29u
c3RhbnRfcChncGlvKSA/CQlcCisJIF9fZ3Bpb19zZXRfdmFsdWUoZ3BpbywgdmFsdWUpIDoJXAor
CSBweGFfZ3Bpb19zZXRfdmFsdWUoZ3BpbywgdmFsdWUpKQorCisjaW5jbHVkZSA8YXNtLWdlbmVy
aWMvZ3Bpby5oPgkJCS8qIGNhbnNsZWVwIHdyYXBwZXJzICovCisKKyNkZWZpbmUgZ3Bpb190b19p
cnEoZ3BpbykJSVJRX0dQSU8oZ3BpbykKKyNkZWZpbmUgaXJxX3RvX2dwaW8oaXJxKQlJUlFfVE9f
R1BJTyhpcnEpCisKKworI2VuZGlmCkluZGV4OiBsaW51eC0yLjYvYXJjaC9hcm0vbWFjaC1weGEv
Z2VuZXJpYy5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi5vcmlnL2FyY2gvYXJtL21hY2gtcHhh
L2dlbmVyaWMuYwkyMDA2LTEyLTE2IDE2OjQ3OjQyLjAwMDAwMDAwMCArMDEwMAorKysgbGludXgt
Mi42L2FyY2gvYXJtL21hY2gtcHhhL2dlbmVyaWMuYwkyMDA2LTEyLTE2IDE2OjQ3OjQ1LjAwMDAw
MDAwMCArMDEwMApAQCAtMTI5LDYgKzEyOSwyOSBAQAogRVhQT1JUX1NZTUJPTChweGFfZ3Bpb19t
b2RlKTsKIAogLyoKKyAqIFJldHVybiBHUElPIGxldmVsLCBub256ZXJvIG1lYW5zIGhpZ2gsIHpl
cm8gaXMgbG93CisgKi8KK2ludCBweGFfZ3Bpb19nZXRfdmFsdWUodW5zaWduZWQgZ3BpbykKK3sK
KwlyZXR1cm4gR1BMUihncGlvKSAmIEdQSU9fYml0KGdwaW8pOworfQorCitFWFBPUlRfU1lNQk9M
KHB4YV9ncGlvX2dldF92YWx1ZSk7CisKKy8qCisgKiBTZXQgb3V0cHV0IEdQSU8gbGV2ZWwKKyAq
Lwordm9pZCBweGFfZ3Bpb19zZXRfdmFsdWUodW5zaWduZWQgZ3BpbywgaW50IHZhbHVlKQorewor
CWlmICh2YWx1ZSkKKwkJR1BTUihncGlvKSA9IEdQSU9fYml0KGdwaW8pOworCWVsc2UKKwkJR1BD
UihncGlvKSA9IEdQSU9fYml0KGdwaW8pOworfQorCitFWFBPUlRfU1lNQk9MKHB4YV9ncGlvX3Nl
dF92YWx1ZSk7CisKKy8qCiAgKiBSb3V0aW5lIHRvIHNhZmVseSBlbmFibGUgb3IgZGlzYWJsZSBh
IGNsb2NrIGluIHRoZSBDS0VOCiAgKi8KIHZvaWQgcHhhX3NldF9ja2VuKGludCBjbG9jaywgaW50
IGVuYWJsZSkKSW5kZXg6IGxpbnV4LTIuNi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1weGEvaGFyZHdh
cmUuaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9pbmNsdWRlL2FzbS1hcm0vYXJjaC1w
eGEvaGFyZHdhcmUuaAkyMDA2LTEyLTE3IDE1OjQyOjM2LjAwMDAwMDAwMCArMDEwMAorKysgbGlu
dXgtMi42L2luY2x1ZGUvYXNtLWFybS9hcmNoLXB4YS9oYXJkd2FyZS5oCTIwMDYtMTItMTcgMTU6
NDM6MjYuMDAwMDAwMDAwICswMTAwCkBAIC02OCw2ICs2OCwxNiBAQAogZXh0ZXJuIHZvaWQgcHhh
X2dwaW9fbW9kZSggaW50IGdwaW9fbW9kZSApOwogCiAvKgorICogUmV0dXJuIEdQSU8gbGV2ZWws
IG5vbnplcm8gbWVhbnMgaGlnaCwgemVybyBpcyBsb3cKKyAqLworZXh0ZXJuIGludCBweGFfZ3Bp
b19nZXRfdmFsdWUodW5zaWduZWQgZ3Bpbyk7CisKKy8qCisgKiBTZXQgb3V0cHV0IEdQSU8gbGV2
ZWwKKyAqLworZXh0ZXJuIHZvaWQgcHhhX2dwaW9fc2V0X3ZhbHVlKHVuc2lnbmVkIGdwaW8sIGlu
dCB2YWx1ZSk7CisKKy8qCiAgKiBSb3V0aW5lIHRvIGVuYWJsZSBvciBkaXNhYmxlIENLRU4KICAq
LwogZXh0ZXJuIHZvaWQgcHhhX3NldF9ja2VuKGludCBjbG9jaywgaW50IGVuYWJsZSk7Cg==
------=_Part_33797_20942520.1166713422990--
