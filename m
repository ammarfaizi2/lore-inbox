Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266008AbUAKX3X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 18:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUAKX3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 18:29:23 -0500
Received: from mail1.kontent.de ([81.88.34.36]:40159 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266008AbUAKX3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 18:29:21 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-usb-devel] Re: USB hangs
Date: Mon, 12 Jan 2004 00:29:26 +0100
User-Agent: KMail/1.5.1
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk> <200401110902.07054.oliver@neukum.org> <1073860735.26585.3.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1073860735.26585.3.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401120029.26971.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 11. Januar 2004 23:39 schrieb Alan Cox:
> On Sul, 2004-01-11 at 08:02, Oliver Neukum wrote:
> > Until recently this line from usb-ohci.h read GFP_KERNEL instead of GFP_NOIO
> > 
> > #define ALLOC_FLAGS (in_interrupt () || current->state != TASK_RUNNING ? GFP_ATOMIC : GFP_NOIO)
> > 
> > Was it an earlier kernel without that change?
> 
> Its an UHCI controller.

OK. I got some more.
Greg please apply.

	Regards
		Oliver
You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1218, 2004-01-12 00:26:13+01:00, oliver@vermuden.neukum.org
  - avoid GFP_KERNEL in block IO path


 usb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/usb/usb.c b/drivers/usb/usb.c
--- a/drivers/usb/usb.c	Mon Jan 12 00:27:37 2004
+++ b/drivers/usb/usb.c	Mon Jan 12 00:27:37 2004
@@ -1198,7 +1198,7 @@
 int usb_control_msg(struct usb_device *dev, unsigned int pipe, __u8 request, __u8 requesttype,
 			 __u16 value, __u16 index, void *data, __u16 size, int timeout)
 {
-	struct usb_ctrlrequest *dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL);
+	struct usb_ctrlrequest *dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_NOIO);
 	int ret;
 	
 	if (!dr)
@@ -1958,7 +1958,7 @@
 	if (result < 0)
 		return result;
 
-	buffer = kmalloc(sizeof(status), GFP_KERNEL);
+	buffer = kmalloc(sizeof(status), GFP_NOIO);
 	if (!buffer) {
 		err("unable to allocate memory for configuration descriptors");
 		return -ENOMEM;

===================================================================


This BitKeeper patch contains the following changesets:
1.1218
## Wrapped with gzip_uu ##


begin 664 bkpatch26304
M'XL(`.G;`4```[V4;V_3,!#&7\>?XJ2]V1A-[FPG:8*""EL9U::U*NSUE#IN
M4Z5I1OX,@?+A<1M4F!H0#(G(D2/?^7>/SX]R`G>5+D.KV*P?=<E.X'U1U:%E
MOO,FT5M[JYNLR>VB7)G8O"A,S$F+7#O=!N=CJ77EK$J]XI*9E%E<JQ1,I`HM
MLL5AI?[RH$-K/KZZNWDS9RR*X"*-MRO]0=<016R1C9)&;^RL+.)T5ZT]A%N.
M2.@B<2$]Y"WZ2&[K^4GL2X&!Z\J$-+%.SZA'^%.41"(DCWO";VGHRX!=`MG$
M:0@H'22'.""&W`M)G".%B/!K-)P3#)"]A7_7?\$4#"!^+-8)7+V;W5^/Y[?C
M&UAO8;$I5`:3*3S$=<JNP?`XL=F/!K+!7SZ,88SL=8_JI-P=M7*::K%[;?63
M>I>,>BFD'[3#P(_=6+E2J2%*J7_3HG[D[A8,DGN$K4`,Y-X21ZG]UGBF2+9S
MZ:C#J"+OQP@<"D*/^^098<*7>WM(<60._`-S<!CP_VR.KIE3&)2?]\-<]NRX
MK\]PS"5Q)"`V^3Y;55TVJ@;#NU=UN2GUIT97-;Q(2H@@R^.-479:K;_J8GG:
MGWOV<G^8V^ED>O;*%`B\KD`W6XMFN=2]L+ANJJ>;#_\9E6J554T>Q<E22"67
*[!M1:89=X@0`````
`
end

