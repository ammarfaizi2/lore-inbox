Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWFQS0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWFQS0O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWFQS0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:26:14 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:36198 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750791AbWFQS0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:26:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=aLyafKYYcBjinFXsTCYTU4jTwmxNB4C1XwI9ttLnimmjgl22ksQnooCh4N/ZzzbyonS8FDpxskeUE5271xTqSUAKL/dIl6i5ow8V7QV+uCh1iqL8TXqzk6KIesL4dB42yR6MU9NH607achjJsOMxsJ3w0QCCQhFTpQfoKaE2kGc=
Message-ID: <4494493F.9000005@gmail.com>
Date: Sat, 17 Jun 2006 12:26:07 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 04/20] chardev: GPIO for SCx200 & PC-8736x: device minor
 numbers are unsigned ints
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4/20. patch.unsigned-minor

Per kernel headers, device minor numbers are unsigned ints.
Do the same in this driver.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.unsigned-minor
 arch/i386/kernel/scx200.c   |    2 +-
 include/linux/scx200_gpio.h |   14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-3/arch/i386/kernel/scx200.c ax-4/arch/i386/kernel/scx200.c
--- ax-3/arch/i386/kernel/scx200.c	2006-06-17 00:55:59.000000000 -0600
+++ ax-4/arch/i386/kernel/scx200.c	2006-06-17 01:07:24.000000000 -0600
@@ -87,7 +87,7 @@ static int __devinit scx200_probe(struct
 	return 0;
 }
 
-u32 scx200_gpio_configure(int index, u32 mask, u32 bits)
+u32 scx200_gpio_configure(unsigned index, u32 mask, u32 bits)
 {
 	u32 config, new_config;
 	unsigned long flags;
diff -ruNp -X dontdiff -X exclude-diffs ax-3/include/linux/scx200_gpio.h ax-4/include/linux/scx200_gpio.h
--- ax-3/include/linux/scx200_gpio.h	2006-06-17 00:55:59.000000000 -0600
+++ ax-4/include/linux/scx200_gpio.h	2006-06-17 01:07:24.000000000 -0600
@@ -1,6 +1,6 @@
 #include <linux/spinlock.h>
 
-u32 scx200_gpio_configure(int index, u32 set, u32 clear);
+u32 scx200_gpio_configure(unsigned index, u32 set, u32 clear);
 
 extern unsigned scx200_gpio_base;
 extern long scx200_gpio_shadow[2];
@@ -17,7 +17,7 @@ extern long scx200_gpio_shadow[2];
 
 /* returns the value of the GPIO pin */
 
-static inline int scx200_gpio_get(int index) {
+static inline int scx200_gpio_get(unsigned index) {
 	__SCx200_GPIO_BANK;
 	__SCx200_GPIO_IOADDR + 0x04;
 	__SCx200_GPIO_INDEX;
@@ -29,7 +29,7 @@ static inline int scx200_gpio_get(int in
    driven if the GPIO is configured as an output, it might not be the
    state of the GPIO right now if the GPIO is configured as an input) */
 
-static inline int scx200_gpio_current(int index) {
+static inline int scx200_gpio_current(unsigned index) {
         __SCx200_GPIO_BANK;
 	__SCx200_GPIO_INDEX;
 		
@@ -38,7 +38,7 @@ static inline int scx200_gpio_current(in
 
 /* drive the GPIO signal high */
 
-static inline void scx200_gpio_set_high(int index) {
+static inline void scx200_gpio_set_high(unsigned index) {
 	__SCx200_GPIO_BANK;
 	__SCx200_GPIO_IOADDR;
 	__SCx200_GPIO_SHADOW;
@@ -49,7 +49,7 @@ static inline void scx200_gpio_set_high(
 
 /* drive the GPIO signal low */
 
-static inline void scx200_gpio_set_low(int index) {
+static inline void scx200_gpio_set_low(unsigned index) {
 	__SCx200_GPIO_BANK;
 	__SCx200_GPIO_IOADDR;
 	__SCx200_GPIO_SHADOW;
@@ -60,7 +60,7 @@ static inline void scx200_gpio_set_low(i
 
 /* drive the GPIO signal to state */
 
-static inline void scx200_gpio_set(int index, int state) {
+static inline void scx200_gpio_set(unsigned index, int state) {
 	__SCx200_GPIO_BANK;
 	__SCx200_GPIO_IOADDR;
 	__SCx200_GPIO_SHADOW;
@@ -73,7 +73,7 @@ static inline void scx200_gpio_set(int i
 }
 
 /* toggle the GPIO signal */
-static inline void scx200_gpio_change(int index) {
+static inline void scx200_gpio_change(unsigned index) {
 	__SCx200_GPIO_BANK;
 	__SCx200_GPIO_IOADDR;
 	__SCx200_GPIO_SHADOW;


