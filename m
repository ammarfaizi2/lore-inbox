Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318434AbSGYMAl>; Thu, 25 Jul 2002 08:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318436AbSGYMAk>; Thu, 25 Jul 2002 08:00:40 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:46018 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318434AbSGYMAd>;
	Thu, 25 Jul 2002 08:00:33 -0400
Date: Thu, 25 Jul 2002 14:03:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: Re: [cset] Add a input_sync() a method to tell which events belong together.
Message-ID: <20020725140342.B14561@ucw.cz>
References: <20020725083716.A20717@ucw.cz> <20020725140040.A14561@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020725140040.A14561@ucw.cz>; from vojtech@suse.cz on Thu, Jul 25, 2002 at 02:00:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull http://linux-input.bkbits.net:8080/linux-input' should also
work.

===================================================================

ChangeSet@1.445, 2002-07-25 14:02:02+02:00, vojtech@twilight.ucw.cz
  Small cleanup in evdev.c, which copies the data directly from
  input struct to userspace.


 evdev.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)


diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	Thu Jul 25 14:02:19 2002
+++ b/drivers/input/evdev.c	Thu Jul 25 14:02:19 2002
@@ -233,7 +233,6 @@
 	struct evdev_list *list = file->private_data;
 	struct evdev *evdev = list->evdev;
 	struct input_dev *dev = evdev->handle.dev;
-	struct input_devinfo id;
 	int retval, t, u;
 
 	if (!evdev->exist) return -ENODEV;
@@ -244,12 +243,7 @@
 			return put_user(EV_VERSION, (int *) arg);
 
 		case EVIOCGID:
-			id.bustype = dev->id.bustype;
-			id.vendor = dev->id.vendor;
-			id.product = dev->id.product;
-			id.version = dev->id.version;
-			return copy_to_user((void *) arg, &id, sizeof(struct input_devinfo));
-
+			return copy_to_user((void *) arg, &dev->id, sizeof(struct input_devinfo));
 		
 		case EVIOCGREP:
 			if ((retval = put_user(dev->rep[0], ((int *) arg) + 0))) return retval;

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch14675
M'XL(`,OH/ST``[64;6^;,!#'7^-/<5*E*5T3L!T#@2E5MW;:IDU:E*JO(]=<
M`BO@"`Q1*C[\3!JU6]6T>P0+B_-QW/WO9Q_!58U5[+3ZFT&5DB/XJ&L3.V:3
MY=DJ-6ZC-JZZM?:YUM;NI;I`;^_M7=]X6;EN#+'K,VE4"BU6=>PP=WQO,=LU
MQL[\_8>K+V_GA$RG<)[*<H67:&`Z)497K<R3^DR:-->E:RI9U@4:Z2I==/>N
M':>4V]MGX9CZ0<<"*L).L80Q*1@FE(M)(,@^L;-'Z3^.$W*?,3_@D\YGW!?D
M`I@KA`^4>S3TN`],Q)3;<=(_*1P("R<,1I2\@W];Q#E1<%G(/`>5HRR;-60E
M8)M@ZZHA;-+,JJKT.L,:3(J02",AR2I4)M_"LM*%_7[7%JA-U2ACTX/&=KE>
M2X4N^0RV:!&1V4,CR.@W+T*HI.3TA<*3*NMYN&/$VU?P@PC"3EU@Q0@[C"9+
M%BEQG2@IPFAY2/+G8O9=Y93Y41]3L!UK3[J_S-U?9'Z0P6<S%WPL0D8[.@D#
M?\<C&_^,(XO]Z!=P#/\+CG,L=(O0E"5B@LD>K)ZE.ZF_PJC:[(9E8_:TZG\`
MV04?!\#L)$((R"?N<_OF.$Z%IJG*?A-L%T8O>K@'@U9G";P^!EFMAO#*_G)T
MFB5#J+-;U,O!?BOL,EK8Q:Q<ZN/C-P\GETI1W=1-,0VH"D,:C<EW>`,B?!P%
"````
`
end

-- 
Vojtech Pavlik
SuSE Labs
