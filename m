Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbSJKA2v>; Thu, 10 Oct 2002 20:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262356AbSJKA2v>; Thu, 10 Oct 2002 20:28:51 -0400
Received: from mx2.redhat.com ([12.150.115.133]:775 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id <S262355AbSJKA2u>;
	Thu, 10 Oct 2002 20:28:50 -0400
Date: Thu, 10 Oct 2002 17:34:34 -0700
From: Richard Henderson <rth@redhat.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] fix alpha atkbd oops
Message-ID: <20021011003434.GA1705@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When called from 

        if (atkbd_reset)
                if (atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT))

in atkbd_probe, we'll crash trying to write back the results
into the null pointer.

The interface to atkbd_command seems more sensible to allow
a null pointer to indicate that the caller doesn't care about
the received data than to supply a dummy pointer here.


r~


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.738, 2002-10-10 17:28:04-07:00, rth@dot.sfbay.redhat.com
  Avoid oops on systems that set atkbd_reset.


 atkbd.c |    5 +++--
 1 files changed, 3 insertions, 2 deletions


diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Thu Oct 10 17:29:28 2002
+++ b/drivers/input/keyboard/atkbd.c	Thu Oct 10 17:29:28 2002
@@ -244,8 +244,9 @@
 
 	while (atkbd->cmdcnt && timeout--) udelay(10);
 
-	for (i = 0; i < receive; i++)
-		param[i] = atkbd->cmdbuf[(receive - 1) - i];
+	if (param)
+		for (i = 0; i < receive; i++)
+			param[i] = atkbd->cmdbuf[(receive - 1) - i];
 
 	if (atkbd->cmdcnt) 
 		return (atkbd->cmdcnt = 0) - 1;

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch1691
M'XL(`&@;ICT``[5474_;,!1]CG_%E7@!H23^2M.&%<%@8M,F477B":')B5WB
MT<25[10ZY<?/#1-HTQAL&HD5);[7YYY[SU%VX,(I6T36UV@'WAOGBT@:G[A%
M*3:)5;(6/JE,$X)S8T(P#=&T%.UU&HZD2]UV=ZFX6\4TR5!(F@E?U;!6UA41
M2=C#CM^L5!'-WYU=?#J>(S2=PDD=0-1GY6$Z1=[8M5A*=R1\O31MXJUH7:.\
MV-;N'U)[BC$-=T9RAK-13T:8YWU%)"&"$R4QY>,11X'9T>^:^`6(8((Q)CEG
M/6$3EJ%3($G.QH!I2G!80/*"C@O,8YP7&,-3N+!/(,;H+?S?-DY0!<=KHR48
MLW)@6G`;YU7CP(?"X,+HA+\IY1>KPGN"/@+A.>=H]CA;%/_EA1`6&!W"VGSU
MJJJ/_*U>ZNO:)UUUFU3?>FGU5MQ4MZO.IS=J4QIA93KP2*K[QG+,",-CCGLR
M&1/2EZ6<*(J5)&PTR=F38WP)>-`LB$;SC/:<XM%DL-*?SVW]]8KM/&"[SJD7
M8H86)B0HG^&>$S)F@_-H]K/Q\B*CSQJ/04Q?Q7CGC0X6"[@*=.L-K(05#>@%
MA&WMH.V6RZWC[D4XA]C>#BLX:/:,'O_@R5/*<Z#H0Z`'#$6!Q>[`9P]%T<)8
MV-4P!7P`&MZ`594*Y</'_OXV'@V9E_HJI`P,XL.JD66WN-S]D0HQD+WPT%<'
:C[^PJE;5C>N:*::+;"091]\!UPXWQ2L%````
`
end
