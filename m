Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262814AbUKRRlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbUKRRlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262809AbUKRRiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:38:50 -0500
Received: from plus.ds14.agh.edu.pl ([149.156.124.14]:47017 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S262804AbUKRRh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:37:27 -0500
Date: Thu, 18 Nov 2004 18:37:24 +0100 (CET)
From: Pawel Sikora <pluto@pld-linux.org>
X-X-Sender: pluto@plus.ds14.agh.edu.pl
To: linux-kernel@vger.kernel.org
Subject: [oops] tcp_set_skb_tso_segs
Message-ID: <Pine.LNX.4.60.0411181835010.594@plus.ds14.agh.edu.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1667953028-1329577057-1100799444=:594"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1667953028-1329577057-1100799444=:594
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

I have two machines:

A: (at home) 2.6.10rc1+cset20041025_0606+pom_ng_snap20040609+ADSL
B: (at work) winxp+putty+DSL

Step 1: I connect from windows system to my PLD-Linux box using putty.
Step 2: I'm getting an oops after random time.

The ooops is caused by divide by zero (line 443: factor /=3D mss_std;)
It happens when A<->B connection is very lagged.

=A0430:net/ipv4/tcp_output.c ****
=A0431:net/ipv4/tcp_output.c **** void tcp_set_skb_tso_segs(
                                      struct sk_buff *skb,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
unsigned int mss_std)
=A0432:net/ipv4/tcp_output.c **** {
=A01826 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.loc 1 432 0
=A01827 0c90 55 =A0 =A0 =A0 =A0 pushl %ebp #
=A01828 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .LCFI28:
=A01829 0c91 89E5 =A0 =A0 =A0 movl %esp, %ebp #,
=A01830 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .LCFI29:
=A01831 0c93 53 =A0 =A0 =A0 =A0 pushl %ebx #
=A01832 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .LCFI30:
=A01833 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.loc 1 432 0
=A01834 0c94 8B5D08 =A0 =A0 movl 8(%ebp), %ebx # skb, skb
=A01835 0c97 8B4D0C =A0 =A0 movl 12(%ebp), %ecx # mss_std, mss_std
=A0433:net/ipv4/tcp_output.c **** =A0if (skb->len <=3D mss_std) {
=A01836 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.loc 1 433 0
=A01837 0c9a 8B4360 =A0 =A0 movl 96(%ebx), %eax # <variable>.len, <variable=
>.len
=A01838 0c9d 39C8 =A0 =A0 =A0 cmpl %ecx, %eax # mss_std, <variable>.len
=A01839 0c9f 771F =A0 =A0 =A0 ja .L229 #,
=A0434:net/ipv4/tcp_output.c **** =A0 /* Avoid the costly divide in the nor=
mal
=A0435:net/ipv4/tcp_output.c **** =A0 =A0* non-TSO case.
=A0436:net/ipv4/tcp_output.c **** =A0 =A0*/
=A0437:net/ipv4/tcp_output.c **** =A0 skb_shinfo(skb)->tso_segs =3D 1;
=A01840 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.loc 1 437 0
=A01841 0ca1 8B83B800 =A0 movl 184(%ebx), %eax # <variable>.end,
                                              <variable>.end
=A01841 =A0 =A0 =A00000
=A01842 0ca7 66C7400A =A0 movw $1, 10(%eax) #, <variable>.tso_segs
=A01842 =A0 =A0 =A00100
=A0438:net/ipv4/tcp_output.c **** =A0 skb_shinfo(skb)->tso_size =3D 0;
=A01843 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.loc 1 438 0
=A01844 0cad 8B83B800 =A0 movl 184(%ebx), %eax # <variable>.end,
                                              <variable>.end
=A01844 =A0 =A0 =A00000
=A01845 0cb3 66C74008 =A0 movw $0, 8(%eax) #, <variable>.tso_size
=A01845 =A0 =A0 =A00000
=A0439:net/ipv4/tcp_output.c **** =A0} else {
=A0440:net/ipv4/tcp_output.c **** =A0 unsigned int factor;
=A0441:net/ipv4/tcp_output.c ****
=A0442:net/ipv4/tcp_output.c **** =A0 factor =3D skb->len + (mss_std - 1);
=A0443:net/ipv4/tcp_output.c **** =A0 factor /=3D mss_std;
=A0444:net/ipv4/tcp_output.c **** =A0 skb_shinfo(skb)->tso_segs =3D factor;
=A0445:net/ipv4/tcp_output.c **** =A0 skb_shinfo(skb)->tso_size =3D mss_std=
;
=A0446:net/ipv4/tcp_output.c **** =A0}
=A0447:net/ipv4/tcp_output.c **** }
=A01846 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.loc 1 447 0
=A01847 0cb9 5B =A0 =A0 =A0 =A0 popl %ebx #
=A01848 0cba 5D =A0 =A0 =A0 =A0 popl %ebp #
=A01849 0cbb C3 =A0 =A0 =A0 =A0 ret
=A01850 0cbc 8D742600 =A0 .p2align 4,,7
=A01851 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .L229:
=A01852 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .LBB194:
=A01853 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.loc 1 442 0
=A01854 0cc0 8D4408FF =A0 leal -1(%eax,%ecx), %eax #, factor
=A01855 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.loc 1 443 0
=A01856 0cc4 31D2 =A0 =A0 =A0 xorl %edx, %edx # tmp67
=A01857 0cc6 F7F1 =A0 =A0 =A0 divl %ecx # mss_std
=A01858 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.loc 1 444 0
=A01859 0cc8 8B93B800 =A0 movl 184(%ebx), %edx # <variable>.end,
                                              <variable>.end
=A01859 =A0 =A0 =A00000
=A01860 0cce 6689420A =A0 movw %ax, 10(%edx) # tmp66, <variable>.tso_segs
=A01861 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.loc 1 445 0
=A01862 0cd2 8B83B800 =A0 movl 184(%ebx), %eax # <variable>.end,
                                              <variable>.end
=A01862 =A0 =A0 =A00000
=A01863 0cd8 66894808 =A0 movw %cx, 8(%eax) # mss_std, <variable>.tso_size
=A01864 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .LBE194:
=A01865 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.loc 1 447 0
=A01866 0cdc 5B =A0 =A0 =A0 =A0 popl %ebx #
=A01867 0cdd 5D =A0 =A0 =A0 =A0 popl %ebp #
=A01868 0cde C3 =A0 =A0 =A0 =A0 ret

--=20
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property.=20
*/

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#define say(x) lie(x=
)
---1667953028-1329577057-1100799444=:594--
