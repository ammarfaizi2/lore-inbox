Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130465AbQLKJ61>; Mon, 11 Dec 2000 04:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130481AbQLKJ6R>; Mon, 11 Dec 2000 04:58:17 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:59152 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130465AbQLKJ6A>;
	Mon, 11 Dec 2000 04:58:00 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Corisen" <csyap@starnet.gov.sg>
cc: linux-kernel@vger.kernel.org
Subject: Re: warning during make modules 
In-Reply-To: Your message of "Mon, 11 Dec 2000 17:15:53 +0800."
             <004b01c06352$f6e8e4a0$050010ac@starnet.gov.sg> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Dec 2000 20:27:23 +1100
Message-ID: <1186.976526843@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000 17:15:53 +0800, 
"Corisen" <csyap@starnet.gov.sg> wrote:
>i'm compiling kernel 2.4.0-test11 uder RH7. i've changed the CC= line to use
>kgcc, executed "make clean" and "make mrproper". "make menuconfig" and "make
>dep" went smoothly. however during the "make modules" process, several
>warning messages (shown below) appeared:
>
>{standard input}: Assembler messages:
>{standard input}:8: Warning: Ignoring changed section attributes for
>.modinfo
>
>pls kindly advise how can i resolve the warning messages, or can i can
>safely igonre the warning messages?

You can safely ignore the messages.  But if they get too annoying,
upgrade to modutils >= 2.3.19 (current is 2.3.22) and apply this patch.

Index: 0-test12-pre7.1/include/linux/module.h
--- 0-test12-pre7.1/include/linux/module.h Thu, 07 Dec 2000 09:20:04 +1100 kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.3.1.1 644)
+++ 0-test12-pre7.2(w)/include/linux/module.h Mon, 11 Dec 2000 20:26:22 +1100 kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.3.1.2 644)
@@ -247,12 +247,6 @@ static const struct gtype##_id * __modul
   __attribute__ ((unused)) = name
 #define MODULE_DEVICE_TABLE(type,name)		\
   MODULE_GENERIC_TABLE(type##_device,name)
-/* not put to .modinfo section to avoid section type conflicts */
-
-/* The attributes of a section are set the first time the section is
-   seen; we want .modinfo to not be allocated.  */
-
-__asm__(".section .modinfo\n\t.previous");
 
 /* Define the module variable, and usage macros.  */
 extern struct module __this_module;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
