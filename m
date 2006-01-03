Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWACNZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWACNZF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWACNZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:25:05 -0500
Received: from mclmx.mail.saic.com ([149.8.64.10]:22181 "EHLO
	mclmx.mail.saic.com") by vger.kernel.org with ESMTP
	id S1750715AbWACNZD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:03 -0500
Message-Id: <1136294594.3768.11.camel@hadji>
From: "Puvvada, Vijay B." <VIJAY.B.PUVVADA@saic.com>
Reply-To: "Puvvada, Vijay B." <vijay.b.puvvada@saic.com>
To: John Stoffel <john@stoffel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Make system and linking static libraries on kernelvers
	ion s2.6.14+
Date: Tue, 3 Jan 2006 08:23:14 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
in-reply-to: <17337.34143.675341.20808@smtp.charter.net>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Can you post the log of all the steps you took to compile the code, 
> the kernel version you're using, and any output of the make commands? 
> That would help.
> 
> John
> 

Hey John,

A full account of my personal crying game is already posted at
http://forums.fedoraforum.org/showthread.php?t=88606&goto=newpost
including the output to all the calls of make.  Below is a repost of my
original message:

Last week, I got a licensed copy of Apini's (Nortel) VPN client for
linux cvc_linux-rh-gcc3-3.3 and I tried to install it against my fedora
core 4 laptop with all the stable updates (including the kernel).
Currently, I am at kernel version 2.6.14.xx.

Out of the box, when I invoked the make on Fedora Core 4 with 2.6.14-1,
I got:

[root@hadji cvc_linux-rh-gcc3-3.3]# make all
cd src && make all
make[1]: Entering directory
`/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src'
cd k2.6 && make
make[2]: Entering directory
`/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6'
make -C /lib/modules/2.6.14-1.1644_FC4/build
SUBDIRS=/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6 modules
make[3]: Entering directory `/usr/src/kernels/2.6.14-1.1644_FC4-i686'
CC
[M] /usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6/linux_wrapper.o
/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6/linux_wrapper.c:
In function ‘nl_ip_rcv’:
/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6/linux_wrapper.c:418:
error: too few arguments to function ‘ip_rcv’
/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6/linux_wrapper.c:
In function ‘nl_skb_dup’:
/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6/linux_wrapper.c:526:
error: ‘struct sk_buff’ has no member named ‘stamp’
/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6/linux_wrapper.c:526:
error: ‘struct sk_buff’ has no member named ‘stamp’
/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6/linux_wrapper.c:527:
error: ‘struct sk_buff’ has no member named ‘security’
/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6/linux_wrapper.c:527:
error: ‘struct sk_buff’ has no member named ‘security’
/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6/linux_wrapper.c:
In function ‘nl_skb_hdr_copy’:
/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6/linux_wrapper.c:553:
error: ‘struct sk_buff’ has no member named ‘stamp’
/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6/linux_wrapper.c:553:
error: ‘struct sk_buff’ has no member named ‘stamp’
make[4]: ***
[/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6/linux_wrapper.o]
Error 1
make[3]: ***
[_module_/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6] Error
2
make[3]: Leaving directory `/usr/src/kernels/2.6.14-1.1644_FC4-i686'
make[2]: *** [kmod_build] Error 2
make[2]: Leaving directory
`/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src/k2.6'
make[1]: *** [all] Error 2
make[1]: Leaving directory
`/usr/src/redhat/TARBALLS/cvc_linux-rh-gcc3-3.3/src'
make: *** [all] Error 2

The compilation errors are due to the fact that sk_buff has undergone
some changes between 2.6.13 and 2.6.14, namely, stamp has been redefined
as tstamp (for time stamp) and security has been redefined to sp (for
security path). I am guessing for clarity ?? Since the functions that
use the sk_buff attributes are simply doing a copy from sk_buff
structure to sk_buff structure, I felt it was safe to just make a global
substitution for these attributes. 

The other change in the 2.6.14 kernel is that ip_rcv takes an extra
pointer to sk_buff than it had previously. If I'm not mistaken, this
change was made several releases prior? The current prototype looks like
this: 

extern int ip_rcv(struct sk_buff *skb, struct net_device *dev,
struct packet_type *pt, struct net_device *orig_dev);

I initially thought by passing the same pointer twice would solve the
problem. When I did this, I got...

[root@hadji cvc_linux-rh-gcc3-3.3]# make all
cd src && make all
make[1]: Entering directory `/usr/local/cvc_linux-rh-gcc3-3.3/src'
cd k2.6 && make
make[2]: Entering directory `/usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6'
make -C /lib/modules/2.6.14-1.1644_FC4/build
SUBDIRS=/usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6 modules
make[3]: Entering directory `/usr/src/kernels/2.6.14-1.1644_FC4-i686'
Building modules, stage 2.
MODPOST
Warning: could not
find /usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/../.libmishim-2.6.a.cmd
for /usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/../libmishim-2.6.a
*** Warning:
"ip_rcv" [/usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/mishim.ko]
undefined!
make[3]: Leaving directory `/usr/src/kernels/2.6.14-1.1644_FC4-i686'
make[2]: Leaving directory `/usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6'
make[1]: Leaving directory `/usr/local/cvc_linux-rh-gcc3-3.3/src'

Unfortunately, the problem with that was that the new kernel (in
ip_input.c) the EXPORT_SYMBOL(ip_rcv) was removed so that modules cannot
directly call on ip routines. I noticed in the kernel mailing lists
somewhere that modules should use netif calls instead (in this case,
netif_rx which takes a single argument, the pointer to sk_buff). After
making that change, I invoked make again and got:

[root@hadji cvc_linux-rh-gcc3-3.3]# make all
cd src && make all
make[1]: Entering directory `/usr/local/cvc_linux-rh-gcc3-3.3/src'
cd k2.6 && make
make[2]: Entering directory `/usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6'
make -C /lib/modules/2.6.14-1.1653_FC4/build
SUBDIRS=/usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6 modules
make[3]: Entering directory `/usr/src/kernels/2.6.14-1.1653_FC4-i686'
CC [M] /usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/linux_wrapper.o
LD [M] /usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/mishim.o
CC [M] /usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/nlvcard.o
Building modules, stage 2.
MODPOST
Warning: could not
find /usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/../.libmishim-2.6.a.cmd
for /usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/../libmishim-2.6.a
CC /usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/mishim.mod.o
LD [M] /usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/mishim.ko
CC /usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/nlvcard.mod.o
LD [M] /usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/nlvcard.ko
make[3]: Leaving directory `/usr/src/kernels/2.6.14-1.1653_FC4-i686'
make[2]: Leaving directory `/usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6'
make[1]: Leaving directory `/usr/local/cvc_linux-rh-gcc3-3.3/src'

This last error is a little puzzling to me. At this current moment, I am
kind of leaning to a problem in the makefile. Maybe someone can shed
some light on it. So far as I can tell, the makefile is trying to link
in some static libraries (archives) but for some reason, the kernel make
system does not seem to know how handle them or that they are not being
specified correctly in the makefile such that the kernel make system can
generate a proper command for linking in these static libraries.

Below is a recursive diff of my "linux_wrapper.c" file which is the only
file in the tarball that I changed so far (at the end of the day, the
changes are rather trivial).


diff -C3 --recursive cvc_linux-rh-gcc3-3.3/src/linux_wrapper.c
reference/cvc_linux-rh-gcc3-3.3/src/linux_wrapper.c
*** cvc_linux-rh-gcc3-3.3/src/linux_wrapper.c   2006-01-02
10:42:07.000000000 -0500
--- reference/cvc_linux-rh-gcc3-3.3/src/linux_wrapper.c 2005-07-12
19:52:40.000000000 -0400
***************
*** 415,422 ****
  
  int nl_ip_rcv(struct sk_buff *skb, struct packet_type *pt)
  {
!       /* return ip_rcv(skb, skb->dev, pt); */
!       return netif_rx(skb);
  }
  
  void nl_ip_send_check(struct iphdr *iph)
--- 415,421 ----
  
  int nl_ip_rcv(struct sk_buff *skb, struct packet_type *pt)
  {
!       return ip_rcv(skb, skb->dev, pt);
  }
  
  void nl_ip_send_check(struct iphdr *iph)
***************
*** 524,531 ****
      memcpy(new_skb->cb, skb->cb, sizeof(skb->cb));
      new_skb->priority = skb->priority;
      new_skb->protocol = skb->protocol;
!     new_skb->tstamp = skb->tstamp;
!     new_skb->sp = skb->sp;
  #if ((LINUX_VERSION_CODE >= 0x020200) && (LINUX_VERSION_CODE <
0x020300))
      new_skb->used = skb->used;
  #endif
--- 523,530 ----
      memcpy(new_skb->cb, skb->cb, sizeof(skb->cb));
      new_skb->priority = skb->priority;
      new_skb->protocol = skb->protocol;
!     new_skb->stamp = skb->stamp;
!     new_skb->security = skb->security;
  #if ((LINUX_VERSION_CODE >= 0x020200) && (LINUX_VERSION_CODE <
0x020300))
      new_skb->used = skb->used;
  #endif
***************
*** 551,557 ****
    memcpy(skb_to->cb, skb_from->cb, sizeof(skb_from->cb));
    skb_to->priority = skb_from->priority;
    skb_to->protocol = skb_from->protocol;
!   skb_to->tstamp = skb_from->tstamp;
  #if ((LINUX_VERSION_CODE >= 0x020200) && (LINUX_VERSION_CODE <
0x020300))
    skb_to->used = skb_from->used;
  #else
--- 550,556 ----
    memcpy(skb_to->cb, skb_from->cb, sizeof(skb_from->cb));
    skb_to->priority = skb_from->priority;
    skb_to->protocol = skb_from->protocol;
!   skb_to->stamp = skb_from->stamp;
  #if ((LINUX_VERSION_CODE >= 0x020200) && (LINUX_VERSION_CODE <
0x020300))
    skb_to->used = skb_from->used;
  #else

