Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbSKVPMz>; Fri, 22 Nov 2002 10:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264946AbSKVPMz>; Fri, 22 Nov 2002 10:12:55 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:29704 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S264943AbSKVPMy> convert rfc822-to-8bit;
	Fri, 22 Nov 2002 10:12:54 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5] pcnet_cs, uninitialized timer when removing
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Fri, 22 Nov 2002 15:11:15 +0100
Message-ID: <87hee9u22k.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I remove the card I get:

Linux version 2.5.47 (root@gswi1164) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Mon Nov 11 19:55:09 CET 2002
[...]
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc6ab9e64, data=0xc4d1a560
Call Trace: [<c0121660>]  [<c6ab9e64>]  [<c01218c0>]  [<c6ab9f81>]  [<c6aa2326>]  [<c6aaafc0>]  [<c6aa2353>]  [<c6aa23d6>]  [<c6aaaf80>]  [<c6aa9e2e>]  [<c6aaaf80>]  [<c01271c1>]  [<c6aaaf80>]  [<c0126fd8>]  [<c6aaaf80>]  [<c6aa9df0>]  [<c0117350>]  [<c0117350>]  [<c0106e79>] 

ksymoops 2.4.6 on i686 2.5.47.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.47/ (default)
     -m /boot/System.map-2.5.47 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
Call Trace: [<c0121660>]  [<c6ab9e64>]  [<c01218c0>]  [<c6ab9f81>]  [<c6aa2326>]  [<c6aaafc0>]  [<c6aa2353>]  [<c6aa23d6>]  [<c6aaaf80>]  [<c6aa9e2e>]  [<c6aaaf80>]  [<c01271c1>]  [<c6aaaf80>]  [<c0126fd8>]  [<c6aaaf80>]  [<c6aa9df0>]  [<c0117350>]  [<c0117350>]  [<c0106e79>] 

Processed with ksymoops:

Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0121660 <check_timer_failed+40/4c>
Trace; c6ab9e64 <[pcnet_cs]pcnet_release+0/74>
Trace; c01218c0 <mod_timer+34/1f0>
Trace; c6ab9f81 <[pcnet_cs]pcnet_event+a9/1a0>
Trace; c6aa2326 <[pcmcia_core]send_event+32/44>
Trace; c6aaafc0 <[yenta_socket].bss.start+40/5bf>
Trace; c6aa2353 <[pcmcia_core]do_shutdown+1b/64>
Trace; c6aa23d6 <[pcmcia_core]parse_events+3a/d8>
Trace; c6aaaf80 <[yenta_socket]pci_socket_array+0/0>
Trace; c6aa9e2e <[yenta_socket]yenta_bh+3e/44>
Trace; c6aaaf80 <[yenta_socket]pci_socket_array+0/0>
Trace; c01271c1 <worker_thread+1e9/2cc>
Trace; c6aaaf80 <[yenta_socket]pci_socket_array+0/0>
Trace; c0126fd8 <worker_thread+0/2cc>
Trace; c6aaaf80 <[yenta_socket]pci_socket_array+0/0>
Trace; c6aa9df0 <[yenta_socket]yenta_bh+0/44>
Trace; c0117350 <default_wake_function+0/34>
Trace; c0117350 <default_wake_function+0/34>
Trace; c0106e79 <kernel_thread_helper+5/c>


2 warnings issued.  Results may not be reliable.

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
