Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263940AbTICSC3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTICSC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:02:29 -0400
Received: from [211.174.50.102] ([211.174.50.102]:39306 "EHLO
	mail.linuxone.co.kr") by vger.kernel.org with ESMTP id S263940AbTICSCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:02:10 -0400
Message-ID: <003601c37245$78c3beb0$2a111796@vaiolaptop>
From: =?ks_c_5601-1987?B?udrAr8L5?= <super@linuxone.co.kr>
To: <linux-kernel@vger.kernel.org>
Subject: How do i change UDP ?
Date: Thu, 4 Sep 2003 03:01:54 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0034_01C37290.E55E5E90"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0034_01C37290.E55E5E90
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

SGkgIHRoZXJlLi4NCg0KSSB3YW50IHRvIGNoYW5nZSBVRFAgY29tbXVuaWNhdGlvbiB0byB1bml4
LWxpa2UuLg0KDQp0aGF0IGlzIGxpbnV4IHNlbmQgVURQIHBhY2tldCBhcyA0LCAzLCAyLCAxIGJ1
dCBpIHdhbnQgdG8gc2VuZCBpdCBhcyAxIDIgMyA0DQoNCnRoZSBhdHRhY2hlZCBmaWxlIGlzIGlj
bXAuYywgaXBfb3V0cHV0LmMgYW5kIHVwZC5jIGhhdmluZyBHRU5JRV9JUF9QQVRDSA0KDQpidXQg
aWYgaSBhcHBseSB0aGlzIHBhdGNoZWQgdGhlbiBpdCBvY2N1cmVzIEJBRCBDSEVDS1NVTS4uYnV0
IHRoZSBzZW5kaW5nIHNlcXVlbmNlIGlzIHNlbnQgd2hpY2ggaSB3YW50IHRvLg0KDQpJIGRvbid0
IGtub3cgd2h5IEJBRCBDSEVDS1NVTSBpcyBvY2N1cnJlZC4NCg0KYW55b25lIGdpdmUgbWUgc29t
ZSBhZHZpY2U/PyANCg0KVGhhbmtzLi4u

------=_NextPart_000_0034_01C37290.E55E5E90
Content-Type: application/octet-stream;
	name="patched-sequence"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patched-sequence"

diff -uNr orginal/icmp.c patched/icmp.c=0A=
--- orginal/icmp.c	Thu Aug 28 21:38:10 2003=0A=
+++ patched/icmp.c	Thu Sep  4 02:52:24 2003=0A=
@@ -91,6 +91,7 @@=0A=
 #include <asm/uaccess.h>=0A=
 #include <net/checksum.h>=0A=
 =0A=
+#define GENIE_IP_PATCH=0A=
 /*=0A=
  *	Build xmit assembly blocks=0A=
  */=0A=
@@ -319,39 +320,37 @@=0A=
 	 *	the other fragments first, so that we get the checksum=0A=
 	 *	for the whole packet here.=0A=
 	 */=0A=
-	=0A=
-	/*=0A=
+#ifndef GENIE_IP_PATCH=0A=
+	csum =3D csum_partial_copy_nocheck((void *)&icmp_param->data,=0A=
+		to, icmp_param->head_len,=0A=
+		icmp_param->csum);=0A=
 	csum=3Dskb_copy_and_csum_bits(icmp_param->skb,=0A=
 				    icmp_param->offset, =0A=
 				    to+icmp_param->head_len,=0A=
 				    fraglen-icmp_param->head_len,=0A=
 				    csum);=0A=
-	csum =3D csum_partial_copy_nocheck((void *)&icmp_param->data,=0A=
-		to, icmp_param->head_len,=0A=
-		icmp_param->csum);=0A=
-		=0A=
-=0A=
-	*/	=0A=
-	{=0A=
-	csum =3D skb_copy_and_csum_bits(icmp_param->skb,=0A=
+#else=0A=
+	csum=3Dskb_copy_and_csum_bits(icmp_param->skb,=0A=
+				    icmp_param->offset, =0A=
+				    to+icmp_param->head_len,=0A=
+				    fraglen-icmp_param->head_len,=0A=
+				    0);=0A=
+	csum =3D 0;=0A=
+	icmp_param->csum =3D 0;=0A=
+	icmp_param->csum =3D skb_checksum(icmp_param->skb,=0A=
 			icmp_param->offset,=0A=
-			to+icmp_param->head_len,=0A=
 			fraglen-icmp_param->head_len,=0A=
-			0);=0A=
-	csum =3D 0 ;=0A=
-	icmp_param->csum =3D 0;=0A=
+			csum);=0A=
 =0A=
-	csum =3D csum_partial(icmp_param->skb,=0A=
-			icmp_param->data_len, 0);=0A=
+//	icmp_param->csum =3D skb_copy_bits(icmp_param->skb,=0A=
+//			icmp_param->offset, to+icmp_param->head_len, csum);=0A=
 	csum =3D csum_partial_copy_nocheck((void *)&icmp_param->data,=0A=
 		to, icmp_param->head_len,=0A=
 		icmp_param->csum);=0A=
-	=0A=
+#endif=0A=
 =0A=
 	icmph=3D(struct icmphdr *)to;=0A=
 	icmph->checksum =3D csum_fold(csum);=0A=
-	}=0A=
-=0A=
 	return 0;=0A=
 }=0A=
 =0A=
@@ -415,7 +414,9 @@=0A=
 	struct icmp_bxm icmp_param;=0A=
 	struct rtable *rt =3D (struct rtable*)skb_in->dst;=0A=
 	struct ipcm_cookie ipc;=0A=
+#ifdef GENIE_IP_PATCH=0A=
 	unsigned int offset;=0A=
+#endif=0A=
 	u32 saddr;=0A=
 	u8  tos;=0A=
 =0A=
@@ -541,13 +542,19 @@=0A=
 	room -=3D sizeof(struct iphdr) + icmp_param.replyopts.optlen;=0A=
 	room -=3D sizeof(struct icmphdr);=0A=
 =0A=
+#ifndef GENIE_IP_PATCH=0A=
+	icmp_param.data_len=3Dskb_in->len-icmp_param.offset;=0A=
+#else=0A=
+=0A=
 	if( skb_in->data > skb_in->nh.raw)=0A=
 		offset =3D (skb_in->data - skb_in->nh.raw);=0A=
 	else=0A=
 		offset =3D 0;=0A=
 =0A=
-	icmp_param.data_len=3Dskb_in->len-icmp_param.offset+offset;=0A=
+	icmp_param.data_len=3Dskb_in->len+offset;=0A=
+//	icmp_param.data_len=3Dskb_in->len+icmp_param.offset;=0A=
 =0A=
+#endif=0A=
 	if (icmp_param.data_len > room)=0A=
 		icmp_param.data_len =3D room;=0A=
 	icmp_param.head_len =3D sizeof(struct icmphdr);=0A=
diff -uNr orginal/ip_output.c patched/ip_output.c=0A=
--- orginal/ip_output.c	Thu Aug 28 21:38:10 2003=0A=
+++ patched/ip_output.c	Thu Sep  4 01:27:47 2003=0A=
@@ -78,7 +78,9 @@=0A=
 #include <linux/mroute.h>=0A=
 #include <linux/netlink.h>=0A=
 =0A=
+=0A=
 #define GENIE_IP_PATCH=0A=
+=0A=
 /*=0A=
  *      Shall we try to damage output packets if routing dev changes?=0A=
  */=0A=
@@ -472,9 +474,7 @@=0A=
 		ip_local_error(sk, EMSGSIZE, rt->rt_dst, sk->dport, mtu);=0A=
 		return -EMSGSIZE;=0A=
 	}=0A=
-=0A=
 #ifndef GENIE_IP_PATCH=0A=
-=0A=
 	/*=0A=
 	 *	Start at the end of the frame by handling the remainder.=0A=
 	 */=0A=
@@ -492,45 +492,42 @@=0A=
 		offset -=3D maxfraglen-fragheaderlen;=0A=
 	}=0A=
 #else=0A=
-	/* Patch for skt.=0A=
-	 */=0A=
 	offset =3D 0;=0A=
-	if(length < (maxfraglen - fragheaderlen))=0A=
+	if ( length < ( maxfraglen - fragheaderlen) ) {=0A=
 		fraglen =3D length + fragheaderlen;=0A=
-	else=0A=
+	} else {=0A=
 		fraglen =3D maxfraglen;=0A=
+	}=0A=
+	//printk( KERN_INFO "\n\nbeyond while first : length : %d", length);=0A=
+	//printk( KERN_INFO "\tfraglen : %d", fraglen);=0A=
+	//printk( KERN_INFO "\toffset : %d", offset);=0A=
+	//printk( KERN_INFO "\tfragheaderlen: %d", fragheaderlen);=0A=
 #endif=0A=
-#ifndef GENIE_IP_PATH=0A=
+=0A=
 	/*=0A=
 	 *	The last fragment will not have MF (more fragments) set.=0A=
 	 */=0A=
-=0A=
+#ifndef GENIE_IP_PATCH=0A=
 	mf =3D 0;=0A=
 #else=0A=
-	/* the first fragment will have MFset=0A=
-	 */=0A=
-	if( length < (maxfraglen - fragheaderlen))=0A=
+	if( length <  (maxfraglen - fragheaderlen) )=0A=
 		mf =3D 0;=0A=
-	else=0A=
+	else =0A=
 		mf =3D htons(IP_MF);=0A=
+	printk(KERN_INFO "\n\nmf value is %d\n", mf);=0A=
 #endif=0A=
-=0A=
-#ifndef GENIE_IP_PATCH=0A=
 	/*=0A=
 	 *	Don't fragment packets for path mtu discovery.=0A=
 	 */=0A=
-=0A=
+#ifndef GENIE_IP_PATCH=0A=
 	if (offset > 0 && sk->protinfo.af_inet.pmtudisc=3D=3DIP_PMTUDISC_DO) { =0A=
-		ip_local_error(sk, EMSGSIZE, rt->rt_dst, sk->dport, mtu);=0A=
- 		return -EMSGSIZE;=0A=
-	}=0A=
 #else=0A=
-	if( length > (maxfraglen - fragheaderlen) && =0A=
-			sk->protinfo.af_inet.pmtudisc=3D=3DIP_PMTUDISC_DO) {=0A=
+	if( length > (maxfraglen - fragheaderlen ) &&  =
sk->protinfo.af_inet.pmtudisc=3D=3DIP_PMTUDISC_DO ) {=0A=
+=0A=
+#endif=0A=
 		ip_local_error(sk, EMSGSIZE, rt->rt_dst, sk->dport, mtu);=0A=
  		return -EMSGSIZE;=0A=
 	}=0A=
-#endif=0A=
 	if (flags&MSG_PROBE)=0A=
 		goto out;=0A=
 =0A=
@@ -542,8 +539,9 @@=0A=
 #ifndef GENIE_IP_PATCH=0A=
 	do {=0A=
 #else=0A=
-	while( offset < length ) {=0A=
+		while(offset < length ) {=0A=
 #endif=0A=
+			=0A=
 		char *data;=0A=
 		struct sk_buff * skb;=0A=
 =0A=
@@ -629,13 +627,17 @@=0A=
 		offset -=3D (maxfraglen-fragheaderlen);=0A=
 		fraglen =3D maxfraglen;=0A=
 #else=0A=
-		offset =3D offset + ( maxfraglen - fragheaderlen);=0A=
-		if( length < offset + ( maxfraglen - fragheaderlen)) {=0A=
+		offset +=3D (maxfraglen - fragheaderlen);=0A=
+		if( length <=3D offset + (maxfraglen - fragheaderlen )) {=0A=
 			fraglen =3D length - offset + fragheaderlen;=0A=
 			mf =3D 0;=0A=
 		} else {=0A=
 			fraglen =3D maxfraglen;=0A=
 		}=0A=
+=0A=
+		//printk(KERN_INFO "\nupper offset size : %d", offset );=0A=
+		//printk(KERN_INFO "\tupper fragheaderlen size : %d", fragheaderlen);=0A=
+		//printk(KERN_INFO "\tupper length size : %d", length);=0A=
 #endif=0A=
 =0A=
 		nfrags++;=0A=
@@ -651,9 +653,11 @@=0A=
 #ifndef GENIE_IP_PATCH=0A=
 	} while (offset >=3D 0);=0A=
 #else=0A=
+		//printk(KERN_INFO "\noffset size : %d", offset );=0A=
+		//printk(KERN_INFO "\tfraglen size : %d", fraglen);=0A=
+		//printk(KERN_INFO "\tmaxfraglen size : %d", maxfraglen);=0A=
 	}=0A=
 #endif=0A=
-=0A=
 	if (nfrags>1)=0A=
 		ip_statistics[smp_processor_id()*2 + !in_softirq()].IpFragCreates =
+=3D nfrags;=0A=
 out:=0A=
diff -uNr orginal/udp.c patched/udp.c=0A=
--- orginal/udp.c	Thu Aug 28 21:38:10 2003=0A=
+++ patched/udp.c	Thu Sep  4 02:35:04 2003=0A=
@@ -94,6 +94,8 @@=0A=
 #include <net/inet_common.h>=0A=
 #include <net/checksum.h>=0A=
 =0A=
+#define GENIE_IP_PATCH=0A=
+=0A=
 /*=0A=
  *	Snmp MIB for the UDP layer=0A=
  */=0A=
@@ -380,18 +382,23 @@=0A=
 		if (csum_partial_copy_fromiovecend(to+sizeof(struct udphdr), =
ufh->iov, offset,=0A=
 						   fraglen-sizeof(struct udphdr), &ufh->wcheck))=0A=
 			return -EFAULT;=0A=
+#ifndef GENIE_IP_PATCH=0A=
+ 		ufh->wcheck =3D csum_partial((char *)ufh, sizeof(struct udphdr),=0A=
+					   ufh->wcheck);=0A=
+		ufh->uh.check =3D csum_tcpudp_magic(ufh->saddr, ufh->daddr, =0A=
+					  ntohs(ufh->uh.len),=0A=
+					  IPPROTO_UDP, ufh->wcheck);=0A=
+#else=0A=
+		ufh->wcheck =3D0;=0A=
+		ufh->wcheck =3D csum_partial((char*) ufh->iov->iov_base, =
ufh->iov->iov_len,0);=0A=
+ 		ufh->wcheck =3D csum_partial((char *)ufh, sizeof(struct udphdr),  0);=0A=
+		ufh->uh.check =3D csum_tcpudp_magic(ufh->saddr, ufh->daddr, =0A=
+					  ntohs(ufh->uh.len),=0A=
+					  IPPROTO_UDP, ufh->wcheck);=0A=
+=0A=
+#endif=0A=
+=0A=
 =0A=
-		ufh->wcheck =3D 0;=0A=
-		ufh->wcheck =3D csum_partial((char *)ufh->iov->iov_base, =
ufh->iov->iov_len, 0);=0A=
-		ufh->wcheck =3D csum_partial((char *)ufh, sizeof(struct udphdr), =
ufh->wcheck);=0A=
-		ufh->uh.check =3D csum_tcpudp_magic(ufh->saddr, ufh->daddr, =
ntohs(ufh->uh.len),=0A=
-				IPPROTO_UDP, ufh->wcheck);=0A=
-=0A=
- 		//ufh->wcheck =3D csum_partial((char *)ufh, sizeof(struct udphdr),=0A=
-		//			   ufh->wcheck);=0A=
-		//ufh->uh.check =3D csum_tcpudp_magic(ufh->saddr, ufh->daddr, =0A=
-		//			  ntohs(ufh->uh.len),=0A=
-		//			  IPPROTO_UDP, ufh->wcheck);=0A=
 		if (ufh->uh.check =3D=3D 0)=0A=
 			ufh->uh.check =3D -1;=0A=
 		memcpy(to, ufh, sizeof(struct udphdr));=0A=

------=_NextPart_000_0034_01C37290.E55E5E90--


