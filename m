Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSJJEo3>; Thu, 10 Oct 2002 00:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263249AbSJJEo3>; Thu, 10 Oct 2002 00:44:29 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:49825 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S263246AbSJJEo1>; Thu, 10 Oct 2002 00:44:27 -0400
Date: Thu, 10 Oct 2002 01:50:02 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Greg Kroah-Hartman <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] hid-input: fix find_next_zero_bit usage
Message-ID: <20021010045002.GI12775@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

	Please apply this changeset, comments below, and this has to be
applied to both 2.4 and 2.5.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.747, 2002-10-10 01:22:17-03:00, acme@dhcp197.conectiva
  o hid-input: fix find_next_zero_bit usage
  
  It was swapping the parameters, using the bitfield size for the
  offset and the offset for the bitfield size. With this the mouse
  buttons in my wireless USB keyboard finally works 8) 2.4 has the
  same problem.


 hid-input.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	Thu Oct 10 01:26:11 2002
+++ b/drivers/usb/input/hid-input.c	Thu Oct 10 01:26:11 2002
@@ -348,7 +348,7 @@
 	set_bit(usage->type, input->evbit);
 
 	while (usage->code <= max && test_and_set_bit(usage->code, bit)) {
-		usage->code = find_next_zero_bit(bit, max + 1, usage->code);
+		usage->code = find_next_zero_bit(bit, usage->code, max + 1);
 	}
 
 	if (usage->code > max) return;

===================================================================


This BitKeeper patch contains the following changesets:
1.747
## Wrapped with gzip_uu ##


begin 664 bkpatch1780
M'XL(`&,!I3T``^U574_;,!1]KG_%E7@9&DUL)TV:3$4=,&V,24,@M,?*M9W&
M(XFCV&DIRH^?4[HR!$-L&F]+;$7V/??['F4/KHQLT@'CI41[\$D;FPY$SFN2
MQ![7E>16+9F37&CM)'ZN2^GW8/_HS"]4U9HA]4;(`<Z9Y3DL96/2`?&"W8U=
MUS(=7'SX>/7E_05"DPD<YZQ:R$MI83)!5C=+5@@S938O=.79AE6FE)8Y[V6W
M@W848^K>$8D#/(HZ$N$P[C@1A+"02(%I.(Y"=,*62LP^RRR3S7K*!*NMY$]8
M(A@GE.(PP!U)HH"B$R!>',:`J4^P6X!)2FE*XB$.4HRA3WGZJ"[PEL`0HR/X
MMUD<(PX:<B6&JJI;FT*F;MRNQ*R2-W9V*QL]FRL+K6$+Z;!NG5I8,0-FQ>I:
M50NPN82:-<S%X#IRX*`_;YUBIF0AP*A;"9EN^MO>8989UQ)6B0UL>]S*'VIY
M\$U9U]E<F8VPU*WI3<Q;:W5E0%50KF&E&EE(8^#J\@BNY7JN62/Z-%A1.*EN
MK@V,]X%Z(>3,;*,P+F*H&STO9.FA,R!)0`DZOY\9-/S#!R',,#ITU7#3^'1_
M1*/ZN?5;,_=W5??XKEL4DW%`.CIRARX)11:)<13(<1Q$(OC-:#PPNC'XR#3!
M;@Q#YR'N:!(FT88<SZKUA'FM/-!2?W=DR:=VI0JUR*W7\I7';U^0"([IB)!1
M1,-M(CV;"'E()IS2%Y")_"?3ZY'IKCE?8=BL-LN1X_SY@?L+MIT$(P($G=Y]
M!H--78>'7`L)DR<*_\;M`_@%=0`ENX&W0/;?W?]7>"[YM6G+"6=SEHE,HA_O
'(O2CN@8`````
`
end
