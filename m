Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbSKOIJK>; Fri, 15 Nov 2002 03:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbSKOIHz>; Fri, 15 Nov 2002 03:07:55 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:52865 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265909AbSKOIHc>;
	Fri, 15 Nov 2002 03:07:32 -0500
Date: Fri, 15 Nov 2002 09:14:22 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - fix open counting in usbmouse/usbkbd [8/13]
Message-ID: <20021115091422.G16779@ucw.cz>
References: <20021115090818.A16761@ucw.cz> <20021115090922.A16779@ucw.cz> <20021115091011.B16779@ucw.cz> <20021115091119.C16779@ucw.cz> <20021115091214.D16779@ucw.cz> <20021115091247.E16779@ucw.cz> <20021115091347.F16779@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021115091347.F16779@ucw.cz>; from vojtech@suse.cz on Fri, Nov 15, 2002 at 09:13:47AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.786.54.5, 2002-10-24 12:56:59+02:00, vojtech@suse.cz
  Fix open counting in usbkbd.c and usbmouse.c in case the irq urb
  submit fails. Bug spotted by Thiemo Seufer.


 usbkbd.c   |    4 +++-
 usbmouse.c |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/usbkbd.c b/drivers/usb/input/usbkbd.c
--- a/drivers/usb/input/usbkbd.c	Fri Nov 15 08:31:06 2002
+++ b/drivers/usb/input/usbkbd.c	Fri Nov 15 08:31:06 2002
@@ -163,8 +163,10 @@
 		return 0;
 
 	kbd->irq->dev = kbd->usbdev;
-	if (usb_submit_urb(kbd->irq, GFP_KERNEL))
+	if (usb_submit_urb(kbd->irq, GFP_KERNEL)) {
+		kbd->open--;
 		return -EIO;
+	}
 
 	return 0;
 }
diff -Nru a/drivers/usb/input/usbmouse.c b/drivers/usb/input/usbmouse.c
--- a/drivers/usb/input/usbmouse.c	Fri Nov 15 08:31:06 2002
+++ b/drivers/usb/input/usbmouse.c	Fri Nov 15 08:31:06 2002
@@ -86,8 +86,10 @@
 		return 0;
 
 	mouse->irq->dev = mouse->usbdev;
-	if (usb_submit_urb(mouse->irq, GFP_KERNEL))
+	if (usb_submit_urb(mouse->irq, GFP_KERNEL)) {
+		mouse->open--;
 		return -EIO;
+	}
 
 	return 0;
 }

===================================================================

This BitKeeper patch contains the following changesets:
1.786.54.5
## Wrapped with gzip_uu ##


begin 664 bkpatch16379
M'XL(`+JBU#T``\V56V^;,!B&K_&O^*3>M.H"/G'*E"KK<5.K+4K7Z\J`"2P%
M,C#9NK'_/D/24]JL335-XRAC^]7KC^>%+;BH9-DWYL47)<,$;<'[HE)]HZHK
M:88_='M<%+IM)44FK>4H*YA::3ZK%=+](Z'"!.:RK/H&,=GM$W4]DWUC?'1R
M<?9NC-!@``>)R"?R7"H8#)`JRKFXBJJA4,E5D9NJ%'F5227,L,B:VZ$-Q9CJ
MW28NP[;3$`=SMPE)1(C@1$:8<L_A:&ELN+2],I_H400SQGA#&<$<'0(Q7<\Q
M;6[:@*E%L$4Y$-JWG;[M[V+:QQA6-&&70@^C??B[S@]0",?I=RAF,H>PJ'.5
MYA-(<ZBK8!I$9@@BC]I&5G0^VJY05!)4(B$MOT)=!EJBJH,L51"+]*HR8;^>
M0#4KE)(1!-?P.4EE5L"YK&-9FN@4**/$1J.[-X)Z&VX(88'1WC/%B,JT!</2
M]JV[)=RK#,?$;6SF.Z1A3B"E9V,W"&/!8KE:_P=B'7VKDHO7;#LV;PCS?+:I
MO:[<J^8X=SW:L-B/.?9<%LE8"!R\S-R=X#UKW.74[_*P?L[S`7F]=12)N<R&
MI8P2H1YI/>E=GQYWJ59T"':[]%#R*#=\76X8],B_R4W+]J*^GZ!7?NL.S>KH
M#Z5^!?F'Q'&`H`_MC2(CC6%;JUTN(GBI\[BME7M[.IQOX.1X='EZ-/YX=+:S
M`S^1871=K>E>[VTKX6HEX]=Z'FYBORD1&V4-34HY&4[+0B3KB7B@Z!.'$N90
MUA#],6$=$\3[7YE8?`Y>PL1RD:^APO-;*/3U:28ZY754+#MON?#Q$HN;OVF8
5R'!:U=E`B)`SX4;H-US`1&"Z!P``
`
end
