Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266506AbRGLSoh>; Thu, 12 Jul 2001 14:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266507AbRGLSo1>; Thu, 12 Jul 2001 14:44:27 -0400
Received: from adsl-207-241-136-214.mpl.michix.net ([207.241.136.214]:60680
	"HELO cobalt.deepthought.org") by vger.kernel.org with SMTP
	id <S266506AbRGLSoU>; Thu, 12 Jul 2001 14:44:20 -0400
Date: Thu, 12 Jul 2001 14:36:27 -0400 (EDT)
From: Martin Murray <mmurray@deepthought.org>
To: linux-kernel@vger.kernel.org
Subject: yenta_socket hangs sager laptop in kernel 2.4.6
Message-ID: <Pine.LNX.4.21.0107112003170.17294-100000@cobalt.deepthought.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I have a sager 9820 laptop with an Ali chipset and a TI 1251B
pcmcia socket. The stock redhat 7.0 kernel works fine (2.2.16-22),
however, booting 2.4.3, 2.4.5, or 2.4.6 all cause the computer to hang
about a second and a half after loading yenta_socket. Someone suggested
that it might be a pci irq routing problem, and I suspect it may still be
an irq problem (see ahead), however, both 2.2.16 and 2.4.6 assign it irq
11. For brevity, I have omitted /proc/pci, but, if someone wants it, or
any other information, I'd be happy to pass it on. 
	To do as much as I could, before I troubled all of you, I booted
in single user mode, and loaded the yenta_socket with the debug output. 
This is what I crudely copied down on a legal pad, from output on the
screen:
(the actual output was different, I just copied the information)
exca_readb c68307e8 6 0
exca_writeb c6807e8 43 0 
exca_writew c6807e8 28 0
exca_writew c6807e8 2a 0
exca_writew c6807e8 2c 0
exca_readb c68307e8 6 0
exca_writeb c6807e8 44 0
exca_writew c6807e8 30 0
exca_writew c6807e8 32 0
exca_writew c6807e8 34 0
exca_readb c6807e8 3 40
exca_writeb c6807e8 3 50

The repeating block (read byte, write byte, 3xwrite word) seems to be the
end of yenta_clear_maps() which is the last thing done by yenta_init() -
so I suspect that the yenta_socket() stuff is loading correctly. The last
two operations seem to be enabling interrupts, and then a short moment
later, the machine hangs. I suspect that the last call is
yenta_set_socket() because that is the only explicit exca_writeb() to
I365_INTCTL. Does anyone have any suggestions? I think its important to
remember that the machine does hang immediately, I generally have time to
scratch off an 'ls' before the machine freezes. 

Thank you, Martin Murray 

-- 
Martin Murray, <mmurray@deepthought.org>
- What is Industrial Music? It's the sound of angry 
  Belgians having a fight with a washing machine.
Fear: Seeing B8:00:4C:CD:21, and knowing what it means.





