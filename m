Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267754AbTAMCDI>; Sun, 12 Jan 2003 21:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267757AbTAMCDI>; Sun, 12 Jan 2003 21:03:08 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:48539 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S267754AbTAMCDH>;
	Sun, 12 Jan 2003 21:03:07 -0500
Date: Mon, 13 Jan 2003 03:11:50 +0100
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Subject: [PATCH] fix locking in /net/ipv4/tcp_ipv4.c
Message-ID: <20030113021150.GB4140@gagarin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18Xu4s-0002iL-00*CpdBMRgexUc* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the goto-discussion* reminded me of the locking for the seq_file reading in
/net/ipv4/tcp_ipv4.c. If only the header** is read tcp_listen_unlock() is
called without the lock taken. 

*  there are some lovely gotos in /net/ipv4/tcp_ipv4.c:listening_get_next
** (void *)1 is a marker for the header.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.973, 2003-01-07 03:27:31+01:00, andersg@0x63.nu
  Don't tcp_listen_unlock unless it was locked.


 tcp_ipv4.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
--- a/net/ipv4/tcp_ipv4.c	Tue Jan  7 03:41:35 2003
+++ b/net/ipv4/tcp_ipv4.c	Tue Jan  7 03:41:35 2003
@@ -2412,7 +2412,8 @@
 			read_unlock_bh(&tp->syn_wait_lock);
 		}
 	case TCP_SEQ_STATE_LISTENING:
-		tcp_listen_unlock();
+		if (v != (void *)1)
+			tcp_listen_unlock();
 		break;
 	case TCP_SEQ_STATE_TIME_WAIT:
 	case TCP_SEQ_STATE_ESTABLISHED:

===================================================================


This BitKeeper patch contains the following changesets:
1.973
## Wrapped with gzip_uu ##


begin 664 bkpatch14669
M'XL(`%\^&CX``\V446_3,!#'G^-/<6@/K$Q-[FPG:8*"!BL"!!)5T9ZG-'&7
MJ&E<Q6X+4CX\;JDVZ%9-3#S@1+%]OIS^_OLGG\&U45WJY6VI.G/+SN"C-C;U
M\'LD_';MYE.MW3RH]%(%AZQ@H;I6-<%L$<P:O64N:Y+;HH*-6TT]\L5=Q/Y8
MJ=2;OO]P_>7ME+$L@ZLJ;V_5-V4ARYC5W29O2G.9VZK1K6^[O#5+97._T,O^
M+K7GB-P](<4"PZBG"&7<%U02Y9)4B5R.(LD.\BX/XO_\7R!AC)Q"'O8RX5'(
MQD!^$@M`$2`%&+M!RN-4T`52B@A'Y>""8(CL'?Q;T5>L@+%N7UJPQ>JFJ8U5
M[<VZ;72Q`-<I8Z"VL,T-[$*J]-EG</KCA$WNO63#OVR,88[LS1-[:94-ZM5&
M!CMINX%?_+ZK)!SU4LHH[KG@LW!>CF:)*B(4\V/O3E4Z'`J/*>DC+B3?(_)(
M\M.P/%OK`VQ.52+.)1&AY'WD9-,>((G'_%!RBA\.0_HO^/EE]5<8=MO]ZWB8
M/.;Z,[`:.X]"(/9IWW/F>?4<SC?P(G-?79?P:D`#%_4>J#T?O+Z_28I*%0NS
17F:81%(H$;.?-(*R):H$````
`
end
