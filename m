Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131194AbQLLLeX>; Tue, 12 Dec 2000 06:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131438AbQLLLeN>; Tue, 12 Dec 2000 06:34:13 -0500
Received: from proxy.helios.de ([193.141.98.37]:8201 "EHLO proxy.helios.de")
	by vger.kernel.org with ESMTP id <S131194AbQLLLeF>;
	Tue, 12 Dec 2000 06:34:05 -0500
Date: Tue, 12 Dec 2000 12:03:35 +0100 (MET)
From: Jens-Uwe Mager <jum@helios.de>
Message-Id: <200012121103.MAA01248@isis.helios.de>
To: linux-kernel@vger.kernel.org
Subject: NFS v2 attribute problem with 2.2.18?
X-Sun-Charset: US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just installed the new 2.2.18 kernel and I get a strange problem with
NFS v2 servers (for example AIX 4.1.5). The problem does not appear if
the NFS server is a newer V3 for example from Solaris 7. The problem is
that I am unable to create new files in a newly created directory for a
while:

ramses$ /bin/mkdir yyy; /bin/touch yyy/xxx 
/bin/touch: yyy/xxx: Permission denied

The permission denied error goes away after a while. I did trace the
above command using tcpdump (I hope this helps to diagnose the
problem):

11:56:23.724180 ramses.helios.de.15101265 > ans.nfs: 132 lookup [|nfs] (ttl 64, id 21710)
			 4500 00a0 54ce 0000 4011 cd30 ac10 002d
			 ac10 0001 031f 0801 008c 1a93 00e6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.725265 ans.nfs > ramses.helios.de.15101265: reply ok 28 lookup [|nfs] (ttl 255, id 42181)
			 4500 0038 a4c5 0000 ff11 bea0 ac10 0001
			 ac10 002d 0801 031f 0024 2dfd 00e6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.725361 ramses.helios.de.31878481 > ans.nfs: 164 mkdir [|nfs] (ttl 64, id 21712)
			 4500 00c0 54d0 0000 4011 cd0e ac10 002d
			 ac10 0001 031f 0801 00ac d74b 01e6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 000e 0000
11:56:23.736633 ans.nfs > ramses.helios.de.31878481: reply ok 128 mkdir [|nfs] (ttl 255, id 42183)
			 4500 009c a4c7 0000 ff11 be3a ac10 0001
			 ac10 002d 0801 031f 0088 adcf 01e6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.740561 ramses.helios.de.48655697 > ans.nfs: 132 lookup [|nfs] (ttl 64, id 21716)
			 4500 00a0 54d4 0000 4011 cd2a ac10 002d
			 ac10 0001 031f 0801 008c 6e2a 02e6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.742417 ans.nfs > ramses.helios.de.48655697: reply ok 28 lookup [|nfs] (ttl 255, id 42184)
			 4500 0038 a4c8 0000 ff11 be9d ac10 0001
			 ac10 002d 0801 031f 0024 2bfd 02e6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.743843 ramses.helios.de.65432913 > ans.nfs: 132 lookup [|nfs] (ttl 64, id 21718)
			 4500 00a0 54d6 0000 4011 cd28 ac10 002d
			 ac10 0001 031e 0801 008c f12d 03e6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.744632 ans.nfs > ramses.helios.de.65432913: reply ok 128 lookup [|nfs] (ttl 255, id 42185)
			 4500 009c a4c9 0000 ff11 be38 ac10 0001
			 ac10 002d 0801 031e 0088 dcc3 03e6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.744951 ramses.helios.de.82210129 > ans.nfs: 132 lookup [|nfs] (ttl 64, id 21719)
			 4500 00a0 54d7 0000 4011 cd27 ac10 002d
			 ac10 0001 031e 0801 008c a93a 04e6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.746059 ans.nfs > ramses.helios.de.82210129: reply ok 128 lookup [|nfs] (ttl 255, id 42186)
			 4500 009c a4ca 0000 ff11 be37 ac10 0001
			 ac10 002d 0801 031e 0088 3d68 04e6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.746381 ramses.helios.de.98987345 > ans.nfs: 140 lookup [|nfs] (ttl 64, id 21721)
			 4500 00a8 54d9 0000 4011 cd1d ac10 002d
			 ac10 0001 031e 0801 0094 4073 05e6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.747517 ans.nfs > ramses.helios.de.98987345: reply ok 128 lookup [|nfs] (ttl 255, id 42187)
			 4500 009c a4cb 0000 ff11 be36 ac10 0001
			 ac10 002d 0801 031e 0088 9cce 05e6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.747855 ramses.helios.de.115764561 > ans.nfs: 136 lookup [|nfs] (ttl 64, id 21723)
			 4500 00a4 54db 0000 4011 cd1f ac10 002d
			 ac10 0001 031e 0801 0090 b185 06e6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.749215 ans.nfs > ramses.helios.de.115764561: reply ok 128 lookup [|nfs] (ttl 255, id 42188)
			 4500 009c a4cc 0000 ff11 be35 ac10 0001
			 ac10 002d 0801 031e 0088 d952 06e6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.749550 ramses.helios.de.132541777 > ans.nfs: 136 lookup [|nfs] (ttl 64, id 21725)
			 4500 00a4 54dd 0000 4011 cd1d ac10 002d
			 ac10 0001 031e 0801 0090 b3e4 07e6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.750285 ans.nfs > ramses.helios.de.132541777: reply ok 128 lookup [|nfs] (ttl 255, id 42189)
			 4500 009c a4cd 0000 ff11 be34 ac10 0001
			 ac10 002d 0801 031e 0088 bace 07e6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.750932 ramses.helios.de.149318993 > ans.nfs: 132 lookup [|nfs] (ttl 64, id 21727)
			 4500 00a0 54df 0000 4011 cd1f ac10 002d
			 ac10 0001 031e 0801 008c 8d9c 08e6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.752234 ans.nfs > ramses.helios.de.149318993: reply ok 128 lookup [|nfs] (ttl 255, id 42190)
			 4500 009c a4ce 0000 ff11 be33 ac10 0001
			 ac10 002d 0801 031e 0088 668c 08e6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.752686 ramses.helios.de.166096209 > ans.nfs: 136 lookup [|nfs] (ttl 64, id 21728)
			 4500 00a4 54e0 0000 4011 cd1a ac10 002d
			 ac10 0001 031e 0801 0090 32c1 09e6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.753414 ans.nfs > ramses.helios.de.166096209: reply ok 128 lookup [|nfs] (ttl 255, id 42191)
			 4500 009c a4cf 0000 ff11 be32 ac10 0001
			 ac10 002d 0801 031e 0088 2092 09e6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.753748 ramses.helios.de.182873425 > ans.nfs: 132 lookup [|nfs] (ttl 64, id 21730)
			 4500 00a0 54e2 0000 4011 cd1c ac10 002d
			 ac10 0001 031e 0801 008c 971c 0ae6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.754796 ans.nfs > ramses.helios.de.182873425: reply ok 128 lookup [|nfs] (ttl 255, id 42192)
			 4500 009c a4d0 0000 ff11 be31 ac10 0001
			 ac10 002d 0801 031e 0088 f5f0 0ae6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.755438 ramses.helios.de.199650641 > ans.nfs: 132 lookup [|nfs] (ttl 64, id 21732)
			 4500 00a0 54e4 0000 4011 cd1a ac10 002d
			 ac10 0001 031e 0801 008c 8d1b 0be6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.756715 ans.nfs > ramses.helios.de.199650641: reply ok 128 lookup [|nfs] (ttl 255, id 42193)
			 4500 009c a4d1 0000 ff11 be30 ac10 0001
			 ac10 002d 0801 031e 0088 e7a2 0be6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.757142 ramses.helios.de.216427857 > ans.nfs: 132 lookup [|nfs] (ttl 64, id 21733)
			 4500 00a0 54e5 0000 4011 cd19 ac10 002d
			 ac10 0001 031e 0801 008c 9a2b 0ce6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.757833 ans.nfs > ramses.helios.de.216427857: reply ok 128 lookup [|nfs] (ttl 255, id 42194)
			 4500 009c a4d2 0000 ff11 be2f ac10 0001
			 ac10 002d 0801 031e 0088 8562 0ce6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.758168 ramses.helios.de.233205073 > ans.nfs: 140 lookup [|nfs] (ttl 64, id 21735)
			 4500 00a8 54e7 0000 4011 cd0f ac10 002d
			 ac10 0001 031e 0801 0094 402a 0de6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.759222 ans.nfs > ramses.helios.de.233205073: reply ok 128 lookup [|nfs] (ttl 255, id 42195)
			 4500 009c a4d3 0000 ff11 be2e ac10 0001
			 ac10 002d 0801 031e 0088 30e9 0de6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.759867 ramses.helios.de.249982289 > ans.nfs: 136 lookup [|nfs] (ttl 64, id 21737)
			 4500 00a4 54e9 0000 4011 cd11 ac10 002d
			 ac10 0001 031e 0801 0090 c4a4 0ee6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.761171 ans.nfs > ramses.helios.de.249982289: reply ok 128 lookup [|nfs] (ttl 255, id 42196)
			 4500 009c a4d4 0000 ff11 be2d ac10 0001
			 ac10 002d 0801 031e 0088 5cae 0ee6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.761599 ramses.helios.de.266759505 > ans.nfs: 140 lookup [|nfs] (ttl 64, id 21738)
			 4500 00a8 54ea 0000 4011 cd0c ac10 002d
			 ac10 0001 031e 0801 0094 353e 0fe6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.762308 ans.nfs > ramses.helios.de.266759505: reply ok 128 lookup [|nfs] (ttl 255, id 42197)
			 4500 009c a4d5 0000 ff11 be2c ac10 0001
			 ac10 002d 0801 031e 0088 136f 0fe6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
11:56:23.762808 ramses.helios.de.283536721 > ans.nfs: 136 lookup [|nfs] (ttl 64, id 21741)
			 4500 00a4 54ed 0000 4011 cd0d ac10 002d
			 ac10 0001 031e 0801 0090 1baf 10e6 6d51
			 0000 0000 0000 0002 0001 86a3 0000 0002
			 0000 0004 0000
11:56:23.763813 ans.nfs > ramses.helios.de.283536721: reply ok 128 lookup [|nfs] (ttl 255, id 42198)
			 4500 009c a4d6 0000 ff11 be2b ac10 0001
			 ac10 002d 0801 031e 0088 d9c1 10e6 6d51
			 0000 0001 0000 0000 0000 0000 0000 0000
			 0000 0000 0000

I know that AIX 4.1.5 is a rather old AIX version, but the problem did
not happen with 2.2.17.

Jens-Uwe Mager

HELIOS Software GmbH
Steinriede 3
30827 Garbsen
Germany

Phone:		+49 5131 709320
FAX:		+49 5131 709325
Internet:	jum@helios.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
