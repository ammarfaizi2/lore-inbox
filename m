Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSCOLIe>; Fri, 15 Mar 2002 06:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSCOLGo>; Fri, 15 Mar 2002 06:06:44 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:2275 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S290277AbSCOLGY>; Fri, 15 Mar 2002 06:06:24 -0500
Date: Fri, 15 Mar 2002 12:06:07 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Gerd Knorr <kraxel@bytesex.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK PATCH 2.4] videodev.c oopses in video_exclusive_register 
Message-ID: <20020315110607.GG13625@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Gerd Knorr <kraxel@bytesex.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The recent videodev.c backport doesn't initialise the 'lock' mutex
which is used in video_exclusive_register. Any driver using
this function will cause an oops in this function.

Apply this patch to make it work.

Note to Gerd: I've ported the meye driver (see next patch) to the
new API and I'm pleased to report that it works correctly on
both 2.4 and 2.5 kernel lines. Good job!

Stelian.


You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.198, 2002-03-15 11:47:32+01:00, stelian@popies.net
  Do initialise the vfd->lock or else video_exclusive_register will oops.


 videodev.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
--- a/drivers/media/video/videodev.c	Fri Mar 15 11:55:32 2002
+++ b/drivers/media/video/videodev.c	Fri Mar 15 11:55:32 2002
@@ -582,6 +582,7 @@
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				&video_fops,
 				NULL);
+	init_MUTEX(&vfd->lock);
 	
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
 	sprintf (name, "%s%d", name_base, i - base);

===================================================================


This BitKeeper patch contains the following changesets:
1.198
## Wrapped with gzip_uu ##


begin 664 bkpatch1654
M'XL(`"33D3P``]546XL3,11^;GY%8$&4I3,GD[FT(UVJNXN*BJ5:\*VDF=-.
M:#HI23IM87Z\LZVT*F)7V1>3D(>/D\/Y+N2*3AS:O.,\:B4J<D7?&N?SSMJL
M%;J@0M]"8V-:*"S-"D.O*F4VX1)MA3K4JMKLNE$0=RO<DK9T)+PL:8W6Y1T6
M\!/B]VO,.^/[-Y,/K\:$#`;TMA35`C^CIX,!\<;60A=N*'RI315X*RJW0B\"
M:5;-J;2)`*)V)RSCD*0-2R'.&LD*QD3,L(`H[J4Q60DK49OA6F_D<A\4RGEK
MVDX52J]J\6L_SA(`X,";!/J<D3O*`M;O48A"X"%+*&-YG.4\N@:6`]#O6@W/
M&M%K1KM`7M.GY7%+)+TSM%7<*Z&50^I+I/6\Z-YH(Y?46(JZ16M5H)GB3NJ-
M4S5.+2Y:RFCI5FE-C5F[@+RG+3G&R>@L/.G^Y2($!)";"RP+JQ[\#U=8*!$>
M9CO>!=:!_(%Z#*S?\`RBI$GY/)O)M,`B38M^C_]&XT?U;:UD$,<<&LX9ZQ^"
M]N=WE]/W%'S(THH=ZN%L[]'A+C!V\4@^<<22/B1-2X>GQVC"S\F,<P[_=S*/
M7GVB7;L]G#9IHPNV_4-VWR6]F#+2>1AZ^G'RY?[K\V>GB5^\//]>LD2Y=)O5
1@,$,LF0^(]\`O6"XOR8%````
`
end
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
