Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268035AbUJDLx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268035AbUJDLx5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 07:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268054AbUJDLx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 07:53:57 -0400
Received: from mail1.kontent.de ([81.88.34.36]:59866 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S268035AbUJDLwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 07:52:18 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH]adding documentation about power management
Date: Mon, 4 Oct 2004 13:53:59 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410041353.59911.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the first part of added documentation about power management
in drivers.

	Regards
		Oliver

Signed-Off-By: Oliver Neukum <oliver@neukum.name>

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.2047, 2004-10-04 13:50:42+02:00, oliver@oenone.homelinux.org
  - adding Documentation about kernel threads and power management


 kernel_threads.txt |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+)


diff -Nru a/Documentation/power/kernel_threads.txt b/Documentation/power/kernel_threads.txt
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/power/kernel_threads.txt	Mon Oct  4 13:51:47 2004
@@ -0,0 +1,41 @@
+KERNEL THREADS
+
+
+Freezer
+
+Upon entering a suspended state the system will freeze all
+tasks. This is done by delivering pseudosignals. This affects
+kernel threads, too. To successfully freeze a kernel thread
+the thread has to check for the pseudosignal and enter the
+refrigerator. Code to do this looks like this:
+
+	do {
+		hub_events();
+		wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list)); 
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+	} while (!signal_pending(current));
+
+from drivers/usb/core/hub.c::hub_thread()
+
+
+The Unfreezable
+
+Some kernel threads however, must not be frozen. The kernel must
+be able to finish pending IO operations and later on be able to
+write the memory image to disk. Kernel threads needed to do IO
+must stay awake. Such threads must mark themselves unfreezable
+like this:
+
+	/*
+	 * This thread doesn't need any user-level access,
+	 * so get rid of all our resources.
+	 */
+	daemonize("usb-storage");
+
+	current->flags |= PF_NOFREEZE;
+
+from drivers/usb/storage/usb.c::usb_stor_control_thread()
+
+Such drivers are themselves responsible for staying quiet during
+the actual snapshotting.

===================================================================


This BitKeeper patch contains the following changesets:
1.2047
## Wrapped with gzip_uu ##


M'XL( %,Y84$  [U6;7/:1A#^S/V*33*3XL3H#2%C,F22V+CQ.&-[L-WIM.DP
MA[1"-T@Z>G<RQJ7_O7L"OY"F'9)) @C0[=[>[O,\MZ=G<*51]1HR%]>HV#-X
M+[6A6RQEB4XF"\Q%6=TX4DW(.)22C*X==F6>B\"]5(C:G4LU#2)&'N?<Q!E0
M*-UK^$[[?L0L9MAK# <_7WUX.V2LWX>#C)<3O$ #_3XS4EWS/-%ON,ER63I&
M\5(7:+@3RV)Y[[H,/"^@=\??:WN=:.E'7KBWC/W$]WGH8^(%83<*V9AK(WCY
M9DXAA8.5S?[WNR7^V P7^G1YGM<.HV5[+]R/V"'X3D!QP0M=WW.]$/QVK^/U
MPN"E%_0\#U98O?D<1O#2AY;'WL&W+>B Q= "GB2BG,"AC*L"2\.-D"7PL:P,
M3%&5F(/)%/)$ R\3F,DY*BAXR2=HW=D)=,*N%[+S!^A9ZPM?C'G<8Z__#X+E
M1GYNG8:[RF^TSL\Q-P_8^W[8#;I+HF _6N[M81A%:3OE02<<1\DW7VA_V8Y\
M L$J<+OY5IZG.(=4Y-C;<@Y+ 2%DO]#%?A14M6Z]#=&&W5[0W4:TWO<0;0SO
MA#E!G)$,+7CP7WW#W1+4$Z#=>;XM!4/X%T*_@G?3#?RO4/V/9='_.A;#[]1[
MCL G[%?[Y@Q::EY_"):MN?ARP(\]"&G5P?!T\ $NWP\';P\OV$=Z'Y%P;NFD
M^LBN9M3^:&U4MBMRT)6>89E@ IKR06J&"'JA#18P%WD.:3T3>)XSP_54.W"9
M"0WT20A,&"\@P1I>&VZFL4JD%I.2YW>>/$TQ-IIM-MM=PEN2AZ0$XABU3JL\
M7]ROMMF:F4UJ]1<RKFDJQ!G&4TBEJA-^O&[=QNL"K8DI3)68H.+$KP,',D$[
M/9%DI.1R*:?T+:98W_<(H ;9_F*-1E:-1WA-@71SYQ7=S[DPJX&1L-%5-3-B
MG&-S2I[)R)IWX4DN-'D5,[-H/K^/,+*C.SNO@,*(%)IQI10-MUZG.9]H> [G
M1Z.CX6#PVV"'/!J/4VX^F"B)OV&>V9[0?+*J=62I(^#O(M(:5$&J9 &)LJ1H
MM])C-Y8*7<K&B7L]F]0*RN9.+8U+PN^JK('G5 Z-7- &^?1LS$BD%&\7BDH;
M**6!,1);\A9+R_.]OS4S,ME0%NA4E$)GL,X3CL] SFQE)/S5@9MSRQ1I\F$2
MFRNQ5F*!A50+$ 4=QS5O0D\=.-G,K42T^EW1>GS&ZA1)S0O@<SY%!RXJ^RRU
M]JZM!5=3NT"A,;]&#=4C #;5X+Y@#7BQDO):@HE$7?YDZG6IA@54]##8R@D?
M$E\MYMUZCI8PH0<U)>A 3NT. EDI4*CIA[P<Z^22WC@568I;;#XELEJ:6*=J
MG]94-CZ1RK)OM7)ZMI+$9\E>S[?_+=_T,[)#HUB61LG\,?DU+NNYP!4^1H32
MI$ZAK<+K;6;QM S^60FJ*:GL?J_W)8]-1;M.EWRF,VD,C3L/S[3U/M55T<<@
/2;I1)V#_ ,N[A3X\"P  
