Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSG3UOO>; Tue, 30 Jul 2002 16:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSG3UOO>; Tue, 30 Jul 2002 16:14:14 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:30162 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316342AbSG3UON>;
	Tue, 30 Jul 2002 16:14:13 -0400
Date: Tue, 30 Jul 2002 22:17:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: [patch] Fix suspend of the kseriod thread
Message-ID: <20020730221722.A22761@ucw.cz>
References: <20020730122638.A11153@ucw.cz> <20020730122918.A11248@ucw.cz> <20020730152255.A20071@ucw.cz> <20020730152342.B20071@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020730152342.B20071@ucw.cz>; from vojtech@suse.cz on Tue, Jul 30, 2002 at 03:23:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.530, 2002-07-30 21:52:03+02:00, pavel@suse.cz
  Move sleep_on() above refrigerator so that the kseriod thread
  in serio.c doesn't exit on suspend because of a pending signal.

 serio.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Tue Jul 30 22:15:57 2002
+++ b/drivers/input/serio/serio.c	Tue Jul 30 22:15:57 2002
@@ -95,9 +95,9 @@
 
 	do {
 		serio_handle_events();
+		interruptible_sleep_on(&serio_wait); 
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_IOTHREAD);
-		interruptible_sleep_on(&serio_wait); 
 	} while (!signal_pending(current));
 
 	printk(KERN_DEBUG "serio: kseriod exiting");

===================================================================

This BitKeeper patch contains the following changesets:
1.530
## Wrapped with gzip_uu ##


begin 664 bkpatch22848
M'XL(`/WS1CT``[64:V_:,!2&/^-?<:1*VZJ*Q,Z5,#%U:W?3-@U1]3,RSH&X
MA!C9#JQ5?OR<E-&UT^BN2619;W)>G^/SQ$=P:5`/>V\TKVZ\"ZE+<@3OE+'#
M7LEKBWK&1>$)M7+R1"DG^X5:H;]15Q9%X<^6OJS6M27N_9A;4<`&M1GVF!?N
M%7N]QF%O\OKMY<>7$T)&(S@K>+7`"[0P&A&K](:7N3GEMBA5Y5F7BEFAY>VR
MS?[3)J`T<'?,TI#&2<,2&J6-8#EC/&*8TR`:)!'9)79J:H.>N'D8[V)9R+(P
M;,)!2F-R#LR+0PHT\&GJNTG`AG$PI.$)=2.%-=]@^<T,3ACT*7D%_S;E,R+@
MD]H@F!)Q/575LV/@LU;0.-=R@9J[!<$HL`6W;D!8NJ9)E;NY1IZ[>%E!)WD"
M<H6F>FH!OT@+RNFU66.5PPP%=W6`F@.'5I'5`HQ<5+STR`<(TR2-R?BN-Z3_
MFQ<AE%/RXI'=R;5L$?%%P;5_I:Z-E6+I[Y+_;L<B2N.&1DF6-"[Q>);A/!^D
M#)'?;\K>L./PUNB^7=OS+';3QOG&24?@@:#'F?S[$O:8VJTLY:*P7BVVOU9,
M$`6,15&T*Z8%./L!7_I3?-E_QM=A-E?Z`+JWR#ZDU'GL.&U9["K[#'V][1Z'
MUOA0Q_Z`U/=9"HST>K)R9YRNUU;.2ISN?\`GG?-TRZ4]?@[DG+F]9'=GG"A0
4+$V]&L48\T'(./D**"&1[T@%````
`
end

-- 
Vojtech Pavlik
SuSE Labs
