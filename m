Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267206AbTAFXbu>; Mon, 6 Jan 2003 18:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267207AbTAFXbu>; Mon, 6 Jan 2003 18:31:50 -0500
Received: from vsmtp1.tin.it ([212.216.176.221]:42722 "EHLO smtp1.cp.tin.it")
	by vger.kernel.org with ESMTP id <S267206AbTAFXbq>;
	Mon, 6 Jan 2003 18:31:46 -0500
Message-ID: <3E1A145A.2060008@tin.it>
Date: Tue, 07 Jan 2003 00:42:18 +0100
From: AnonimoVeneziano <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Fix for ATAPI CD/DVD-ROMs and burners with vt8235 (and
 other chipsets)
References: <20021227111116.A2614@ucw.cz>
In-Reply-To: <20021227111116.A2614@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>Hi!
>
>Attached are two patches, one for recent 2.4 and one for 2.5, which
>enlarge the address setup timing for ATAPI devices. This is needed for
>several CD/DVD-ROMs and burners that won't work with standard timings.
>So far problems were reported only on vt8233a and vt8235, but I suppose
>other chipsets where the drivers actually program the address setup
>timing according to the spec can be affected.
>
>Please apply, thanks.
>
>  
>
>------------------------------------------------------------------------
>
>You can import this changeset into BK by piping this whole message to:
>'| bk receive [path to repository]' or apply the patch as usual.
>
>===================================================================
>
>
>ChangeSet@1.897, 2002-12-27 10:59:52+01:00, vojtech@suse.cz
>   Workaround (ide-timing.h) for many ATAPI CD/DVD-ROMs and burners.
>   They need extended (beyond spec) address setup timing, and as such
>   don't work on recent VIA chipsets.
>
>
> ide-timing.h |    8 ++++++++
> 1 files changed, 8 insertions(+)
>
>
>diff -Nru a/drivers/ide/ide-timing.h b/drivers/ide/ide-timing.h
>--- a/drivers/ide/ide-timing.h	Fri Dec 27 11:00:15 2002
>+++ b/drivers/ide/ide-timing.h	Fri Dec 27 11:00:15 2002
>@@ -245,6 +245,14 @@
> 	}
> 
> /*
>+ * If the drive is an ATAPI device it may need slower address setup timing,
>+ * so we stay on the safe side.
>+ */
>+
>+	if (drive->media != ide_disk)
>+		p.setup = 120;
>+
>+/*
>  * Convert the timing to bus clock counts.
>  */
> 
>
>===================================================================
>
>
>This BitKeeper patch contains the following changesets:
>+
>## Wrapped with gzip_uu ##
>
>
>begin 664 bkpatch2571
>M'XL(`*\D##X``^V476_3,!2&K^M?<=`NV`=-;.>S19U66@05H%5E&S=(R+-/
>ME]`FKF*WI2@_'J>MMFG:D(;@CB1*8N?X]3GO>90#N#18=5LK_=VBS,@!O-?&
>M=EMF:="3/]UXHK4;^YDNT-]'^=<SOQ"5Q+DF+F(LK,Q@A97IMI@7W,[8S0*[
>MK<G;=Y<?^Q-">CT89**\P<]HH=<C5E<K,5?F3-ALKDO/5J(T!5KA25W4MZ$U
>MIY2[,V))0*.X9C$-DUHRQ9@(&2K*PS0.2;:\R<Y<#KD5YA$!QGE">9#0J':/
>M(")#8%[:28!RGW&?)\!H-^IT(WY"69=2V)=ZMC<"3ABT*7D#?S?K`9$`7W0U
>M$Y5>E@H.<X5MFQ=Y>>-E1S#5%12BW$#_HC\>P6#H#Z^&[<GY)P/"15\OJ]*Y
>M[C4B%QENH$14@#\LELJ]'%[C1KLPLT!Y!$*I"HT!@W:Y@-T>K[8RPDTN7>^=
>MBM+E2PMKEQ#H$BJ46%JX&O5!9OG"K71[?0`>A`$9WS63M)]Y$$(%):>P:#!Y
>MW$A5Y0U0OO/#O^_)/5^C@"=NF,91':L8(Q&QSE3%`1?R8?=^+[=EHQ-UPK@.
>MXB1E6U2?6M&0^\_R)L_*FP:\P](PX&GMR`Z2+=/!0Z+#^"FBT_]$[XG>M?T<
>MVM5Z>SE$QT\2\`>XCWB80$K@&$93L!GNM"%OBMX[H7"52S=EG3W[LLU<K[%Z
>MO,Q&RVA8(QCKXEUIC:P14W=SR7KNNT^^DE8^A</M9NW3`E4NX$4/W/=O*C>S
>H(])J+;R=;`\8IZ_="O_X[I<N,Y0SLRQZBH5*1E-!?@&ZOKMG+P8`````
>`
>end
>  
>
>------------------------------------------------------------------------
>
>You can import this changeset into BK by piping this whole message to:
>'| bk receive [path to repository]' or apply the patch as usual.
>
>===================================================================
>
>
>ChangeSet@1.957, 2002-12-27 10:46:29+01:00, vojtech@suse.cz
>  Workaround (ide-timing.h) for many ATAPI CD/DVD-ROMs and burners.
>  They need extended (beyond spec) address setup timing, and as such
>  don't work on recent VIA chipsets.
>
>
> ide-timing.h |    8 ++++++++
> 1 files changed, 8 insertions(+)
>
>
>diff -Nru a/drivers/ide/ide-timing.h b/drivers/ide/ide-timing.h
>--- a/drivers/ide/ide-timing.h	Fri Dec 27 10:47:10 2002
>+++ b/drivers/ide/ide-timing.h	Fri Dec 27 10:47:10 2002
>@@ -245,6 +245,14 @@
> 	}
> 
> /*
>+ * If the drive is an ATAPI device it may need slower address setup timing,
>+ * so we stay on the safe side.
>+ */
>+
>+	if (drive->media != ide_disk)
>+		p.setup = 120;
>+
>+/*
>  * Convert the timing to bus clock counts.
>  */
> 
>
>===================================================================
>
>
>This BitKeeper patch contains the following changesets:
>+
>## Wrapped with gzip_uu ##
>
>
>begin 664 bkpatch1702
>M'XL(`)XA##X``[V46V_3,!3'G^M/<=`>V(4F=JY-4*>.%4$%:%79Q@L2<FUW
>M"6WC*G;:%>7#<])6&XP-,6Y)%,4^Y_Q]+C]E#RZ,*M/64G^V2F1D#UYK8].6
>MJ8QRQ!=<C[3&M9OIN7)W7NYXZL[RHC($[4-N109+59JTQ1S_9L>N%RIMC5Z^
>MNGA[,B*DVX73C!=7ZKVRT.T2J\LEGTG3XS:;Z<*Q)2_,7%GN"#VO;UQKCU(/
>M[Y#%/@VCFD4TB&O!)&,\8$I2+^A$`5GPI9KU*K'"G.\$,\^+6$(CG]9^%"<>
>MZ0-SDC`&ZKG,<[T8&$V#*/62(\I22F%79&_7`CABT*;D!?S=C$^)@`^ZG/)2
>M5X6$_5RJMLWG>7'E9`<PT27,>;&&D_.3X0!.^V[_LM\>G;TSP-%[7)4%-MQ!
>MC?-,K:%02H*ZMJJ0^+$_5FN-7F:AQ`%P*4ME#!AEJP5LCWBV4>&X6>',!4A=
>M/+6PPG1`%U`JH0H+EX,3$%F^P$`\Z0WX8=P)R/!VC*3]R(L0RBDY!GX]UJK7
>M%&&<ABMGJK">F2.GM2SS!B47V^%^VY)M5SLL8AZ-65B'":6T[HQID(1C7XQC
>MGD@QN3N[G\LA&3%-@C!(&C(Z;`/I0Q$-L_\L[S]7CFK/C_UX`[?W/=IA&CR(
>M=N<_H/V++-]#,NH\DN5[24:9'UC>S/L,VN5J\R";PP='_QN<#[P@A@Z!0QA,
>MP&9JJPUY4_*N#U(M<X%;%INSJ]O,]$J5]U?9:!D-*P7&HC\6U\@:/L$7)NN@
>MW24?22N?P/[FL/;Q7,F<PY,NH/V3S,WT@+1:"V<KVP7DYCE&N(>W?W&1*3$U
>2U;PKPTXH/"[)5_MR+Q\@!@``
>`
>end
>  
>
Hi  again :)

Excuse me for the disturb.

But I haven't understood very well the last 2 patches.

I haven't understood if these patches (vt8235-marcelo , vt8235-linus ) 
are stand alone patches , or them works with vt8235-atapi patch . Alone 
this two patches (I've tried both) does not work , The problem persists.

Them are to use with the precedent patch?

Bye

Marcello

