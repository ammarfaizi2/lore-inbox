Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAFCNM>; Fri, 5 Jan 2001 21:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAFCNC>; Fri, 5 Jan 2001 21:13:02 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:51160 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S129267AbRAFCMs>; Fri, 5 Jan 2001 21:12:48 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] hisax/sportster dependency error
Reply-To: Daniel Stodden <stodden@in.tum.de>
From: Daniel Stodden <stodden@informatik.tu-muenchen.de>
Message-ID: <87zoh5ig36.fsf@bitch.localnet>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 6 Jan 2001 03:12:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi.

a patch and a question:

patch: just a few missing symbols in 2.4.0-final:

--- linux-2.4/drivers/isdn/hisax/Makefile.orig  Sat Jan  6 02:47:31 2001
+++ linux-2.4/drivers/isdn/hisax/Makefile       Sat Jan  6 02:21:22 2001
@@ -34,7 +34,7 @@
 hisax-objs-$(CONFIG_HISAX_ASUSCOM) += asuscom.o isac.o arcofi.o hscx.o
 hisax-objs-$(CONFIG_HISAX_TELEINT) += teleint.o isac.o arcofi.o hfc_2bs0.o
 hisax-objs-$(CONFIG_HISAX_SEDLBAUER) += sedlbauer.o isac.o arcofi.o hscx.o isar.o
-hisax-objs-$(CONFIG_HISAX_SPORTSTER) += sportster.o isac.o arcofi.o hfc_2bs0.o
+hisax-objs-$(CONFIG_HISAX_SPORTSTER) += sportster.o isac.o arcofi.o hfc_2bs0.o hscx.o
 hisax-objs-$(CONFIG_HISAX_MIC) += mic.o isac.o arcofi.o hfc_2bs0.o
 hisax-objs-$(CONFIG_HISAX_NETJET) += nj_s.o netjet.o isac.o arcofi.o
 hisax-objs-$(CONFIG_HISAX_NETJET_U) += nj_u.o netjet.o icc.o



question: something which i missed to ask for about year now:

bitch[3]:~$ cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
0220-022f : soundblaster
0268-026f : sportster
02f8-02ff : serial(set)
0330-0333 : MPU-401 UART
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
  03c0-03df : matrox
03f8-03ff : serial(set)
0668-066f : sportster
0a68-0a6f : sportster
0cf8-0cff : PCI conf1
0e68-0e6f : sportster
1268-126f : sportster
1668-166f : sportster
1a68-1a6f : sportster
1e68-1e6f : sportster
2268-226f : sportster
2668-266f : sportster
2a68-2a6f : sportster
2e68-2e6f : sportster
3268-326f : sportster
3668-366f : sportster
3a68-3a6f : sportster
3e68-3e6f : sportster
4268-426f : sportster
4668-466f : sportster
4a68-4a6f : sportster
4e68-4e6f : sportster
5268-526f : sportster
5668-566f : sportster
5a68-5a6f : sportster
5c20-5c3f : Acer Laboratories Inc. [ALi] M7101 PMU
5e68-5e6f : sportster
6268-626f : sportster
6668-666f : sportster
6a68-6a6f : sportster
6e68-6e6f : sportster
7268-726f : sportster
7668-766f : sportster
7a68-7a6f : sportster
7e68-7e6f : sportster
8268-826f : sportster
8668-866f : sportster
8a68-8a6f : sportster
8e68-8e6f : sportster
9268-926f : sportster
9668-966f : sportster
9a68-9a6f : sportster
9e68-9e6f : sportster
a268-a26f : sportster
a668-a66f : sportster
aa68-aa6f : sportster
ae68-ae6f : sportster
b268-b26f : sportster
b668-b66f : sportster
ba68-ba6f : sportster
be68-be6f : sportster
c268-c26f : sportster
c668-c66f : sportster
ca68-ca6f : sportster
ce68-ce6f : sportster
d000-d00f : Acer Laboratories Inc. [ALi] M5229 IDE
  d000-d007 : ide0
  d008-d00f : ide1
d268-d26f : sportster
d400-d41f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  d400-d41f : ne2k-pci
d668-d66f : sportster
d800-d8ff : Symbios Logic Inc. (formerly NCR) 53c810
  d800-d87f : ncr53c8xx
da68-da6f : sportster
de68-de6f : sportster
e268-e26f : sportster
e668-e66f : sportster
ea68-ea6f : sportster
ee68-ee6f : sportster
f268-f26f : sportster
f668-f66f : sportster
fa68-fa6f : sportster
fe68-fe6f : sportster

could anyone explain this behaviour?

the card is at io=0x268 irq=7

according to sportster.c:get_io_range, this appears to be perfectly
intentional, request_regioning 64x8 byte from 0x268 in 1024byte-steps.

are these ports actually all in use??
not like it's doing any harm, it just looks -- funny? %)


regards,
dns


-- 
___________________________________________________________________________
 mailto:stodden@in.tum.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
