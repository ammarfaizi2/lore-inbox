Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVGKVrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVGKVrN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVGKVon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:44:43 -0400
Received: from pilsener.srv.ualberta.ca ([129.128.5.19]:28656 "EHLO
	pilsener.srv.ualberta.ca") by vger.kernel.org with ESMTP
	id S262786AbVGKVhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:37:52 -0400
Date: Mon, 11 Jul 2005 15:37:47 -0600 (MDT)
From: Marc Aurele La France <tsi@ualberta.ca>
X-X-Sender: tsi@login3.srv.ualberta.ca
To: linux-kernel@vger.kernel.org
Subject: Kernel header policy
Message-ID: <Pine.BSO.4.61.0507111533340.23021@login3.srv.ualberta.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It has been more than a week now...

+----------------------------------+-----------------------------------+
|  Marc Aurele La France           |  work:   1-780-492-9310           |
|  Academic Information and        |  fax:    1-780-492-1729           |
|    Communications Technologies   |  email:  tsi@ualberta.ca          |
|  352 General Services Building   +-----------------------------------+
|  University of Alberta           |                                   |
|  Edmonton, Alberta               |     Standard disclaimers apply    |
|  T6G 2H1                         |                                   |
|  CANADA                          |                                   |
+----------------------------------+-----------------------------------+
XFree86 developer and VP.  ATI driver and X server internals.

---------- Forwarded message ----------
Date: Sun, 3 Jul 2005 11:12:03 -0600 (MDT)
From: Marc Aurele La France <tsi@ualberta.ca>
To: Linus Torvalds
Subject: Kernel header policy

Hi, Linus.  It has been a while since we last talked.  I hope all is well
with you and your family.

I am contacting you to express my concern over a growing trend in kernel
development.  I am specifically referring to changes being made to kernel
headers that break compatibility at the userland level, where __KERNEL__
isn't #define'd.

The most common errors involve the introduction of references, in 
non-__KERNEL__ code, to symbols that ...

1) are only #define'd or typedef'ed in __KERNEL__-bracketed code;  and/or
2) are non-ANSIC C99'isms.

Recent examples include, but are not limited to, ...

a) <linux/fb.h> was temporarily broken during 2.6.9's development cycle.
    The problem here (fixed before 2.6.9's release) was an #include of
    <linux/list.h> not bracketed by __KERNEL__. i.e. "1)" above.

b) <linux/pci.h> has been broken since 2.5.62's development cycle and has
    yet to be fixed.  Here, the #include of <linux/mod_devicetable.h> needs
    to be bracked by __KERNEL__.  This is another occurrence of "1)".

c) <linux/joystick.h> is broken in both ways by 2.6.13-rc1.  This change
    introduces references to <asm/types.h> symbols BITS_PER_LONG (only
    #define'd under __KERNEL__), and __s64 (on 32-bit platforms, only
    typedef'ed under gcc without -ansi).

It is understandable that such errors do not usually show up during kernel
development.  Yet, an unfortunate consequence of the policy against
/usr/include/{linux,asm,...} symlinks is to delay detection of such errors
until someone attempts to rebuild an X server, or some other software,
with a glibc re-generated using the modified kernel headers.

It is certainly possible to report such problems individually and have
done so for most of them.  But, in practice, it has sometimes been
difficult to determine who to contact, let alone convince the relevant
party that there is a problem.  Furthermore, repetition over time turns
the reporting of such errors into an exercise in evangelisation, a
function I feel would be more effectively provided internally within the
kernel development community.

To that end, I would propose, as a possible technical solution, extending
the kernel build process to detect these errors during kernel development.

Your thoughts on this matter would be greatly appreciated.

Thanks.

Marc.

+----------------------------------+-----------------------------------+
|  Marc Aurele La France           |  work:   1-780-492-9310           |
|  Academic Information and        |  fax:    1-780-492-1729           |
|    Communications Technologies   |  email:  tsi@ualberta.ca          |
|  352 General Services Building   +-----------------------------------+
|  University of Alberta           |                                   |
|  Edmonton, Alberta               |     Standard disclaimers apply    |
|  T6G 2H1                         |                                   |
|  CANADA                          |                                   |
+----------------------------------+-----------------------------------+
XFree86 developer and VP.  ATI driver and X server internals.
