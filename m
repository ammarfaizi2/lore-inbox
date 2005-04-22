Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVDVKad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVDVKad (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 06:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVDVKac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 06:30:32 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:25827 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262019AbVDVK13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 06:27:29 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Subject: Re: [PATCH extra/3] crypto: random changes
Date: Fri, 22 Apr 2005 13:26:49 +0300
User-Agent: KMail/1.5.4
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200504221259.06596.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200504221259.06596.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pFNaC5ACvB4csUm"
Message-Id: <200504221326.49151.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_pFNaC5ACvB4csUm
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 22 April 2005 12:59, Denis Vlasenko wrote:
> This one is for comments only.
> 
> These changes were found to bring small size/speed
> improvements by use of BYTEn() and other changes.
> 
> des.c can be less heavily unrolled, 10k -> 5k in object size.
> 
> Any objections to this?


--Boundary-00=_pFNaC5ACvB4csUm
Content-Type: text/x-diff;
  charset="koi8-r";
  name="z.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="z.patch"

diff -urpN linux-2.6.12-rc2.3.twofish/crypto/anubis.c linux-2.6.12-rc2.z.cur/crypto/anubis.c
--- linux-2.6.12-rc2.3.twofish/crypto/anubis.c	Thu Apr 21 23:36:20 2005
+++ linux-2.6.12-rc2.z.cur/crypto/anubis.c	Thu Apr 21 23:36:52 2005
@@ -496,31 +496,31 @@ static int anubis_setkey(void *ctx_arg, 
 		/*
 		 * generate r-th round key K^r:
 		 */
-		K0 = T4[(kappa[N - 1] >> 24)       ];
-		K1 = T4[(kappa[N - 1] >> 16) & 0xff];
-		K2 = T4[(kappa[N - 1] >>  8) & 0xff];
-		K3 = T4[(kappa[N - 1]      ) & 0xff];
+		K0 = T4[BYTE3(kappa[N - 1])];
+		K1 = T4[BYTE2(kappa[N - 1])];
+		K2 = T4[BYTE1(kappa[N - 1])];
+		K3 = T4[BYTE0(kappa[N - 1])];
 		for (i = N - 2; i >= 0; i--) {
-			K0 = T4[(kappa[i] >> 24)       ] ^
-				(T5[(K0 >> 24)       ] & 0xff000000U) ^
-				(T5[(K0 >> 16) & 0xff] & 0x00ff0000U) ^
-				(T5[(K0 >>  8) & 0xff] & 0x0000ff00U) ^
-				(T5[(K0      ) & 0xff] & 0x000000ffU);
-			K1 = T4[(kappa[i] >> 16) & 0xff] ^
-				(T5[(K1 >> 24)       ] & 0xff000000U) ^
-				(T5[(K1 >> 16) & 0xff] & 0x00ff0000U) ^
-				(T5[(K1 >>  8) & 0xff] & 0x0000ff00U) ^
-				(T5[(K1      ) & 0xff] & 0x000000ffU);
-			K2 = T4[(kappa[i] >>  8) & 0xff] ^
-				(T5[(K2 >> 24)       ] & 0xff000000U) ^
-				(T5[(K2 >> 16) & 0xff] & 0x00ff0000U) ^
-				(T5[(K2 >>  8) & 0xff] & 0x0000ff00U) ^
-				(T5[(K2      ) & 0xff] & 0x000000ffU);
-			K3 = T4[(kappa[i]      ) & 0xff] ^
-				(T5[(K3 >> 24)       ] & 0xff000000U) ^
-				(T5[(K3 >> 16) & 0xff] & 0x00ff0000U) ^
-				(T5[(K3 >>  8) & 0xff] & 0x0000ff00U) ^
-				(T5[(K3      ) & 0xff] & 0x000000ffU);
+			K0 = T4[BYTE3(kappa[i])] ^
+				(T5[BYTE3(K0)] & 0xff000000U) ^
+				(T5[BYTE2(K0)] & 0x00ff0000U) ^
+				(T5[BYTE1(K0)] & 0x0000ff00U) ^
+				(T5[BYTE0(K0)] & 0x000000ffU);
+			K1 = T4[BYTE2(kappa[i])] ^
+				(T5[BYTE3(K1)] & 0xff000000U) ^
+				(T5[BYTE2(K1)] & 0x00ff0000U) ^
+				(T5[BYTE1(K1)] & 0x0000ff00U) ^
+				(T5[BYTE0(K1)] & 0x000000ffU);
+			K2 = T4[BYTE1(kappa[i])] ^
+				(T5[BYTE3(K2)] & 0xff000000U) ^
+				(T5[BYTE2(K2)] & 0x00ff0000U) ^
+				(T5[BYTE1(K2)] & 0x0000ff00U) ^
+				(T5[BYTE0(K2)] & 0x000000ffU);
+			K3 = T4[BYTE0(kappa[i])] ^
+				(T5[BYTE3(K3)] & 0xff000000U) ^
+				(T5[BYTE2(K3)] & 0x00ff0000U) ^
+				(T5[BYTE1(K3)] & 0x0000ff00U) ^
+				(T5[BYTE0(K3)] & 0x000000ffU);
 		}
 
 		ctx->E[r][0] = K0;
@@ -536,13 +536,13 @@ static int anubis_setkey(void *ctx_arg, 
 		}
 		for (i = 0; i < N; i++) {
 			int j = i;
-			inter[i]  = T0[(kappa[j--] >> 24)       ];
+			inter[i]  = T0[BYTE3(kappa[j--])];
 			if (j < 0) j = N - 1;
-			inter[i] ^= T1[(kappa[j--] >> 16) & 0xff];
+			inter[i] ^= T1[BYTE2(kappa[j--])];
 			if (j < 0) j = N - 1;
-			inter[i] ^= T2[(kappa[j--] >>  8) & 0xff];
+			inter[i] ^= T2[BYTE1(kappa[j--])];
 			if (j < 0) j = N - 1;
-			inter[i] ^= T3[(kappa[j  ]      ) & 0xff];
+			inter[i] ^= T3[BYTE0(kappa[j  ])];
 		}
 		kappa[0] = inter[0] ^ rc[r];
 		for (i = 1; i < N; i++) {
@@ -562,10 +562,10 @@ static int anubis_setkey(void *ctx_arg, 
 		for (i = 0; i < 4; i++) {
 			u32 v = ctx->E[R - r][i];
 			ctx->D[r][i] =
-				T0[T4[(v >> 24)       ] & 0xff] ^
-				T1[T4[(v >> 16) & 0xff] & 0xff] ^
-				T2[T4[(v >>  8) & 0xff] & 0xff] ^
-				T3[T4[(v      ) & 0xff] & 0xff];
+				T0[BYTE0(T4[BYTE3(v)])] ^
+				T1[BYTE0(T4[BYTE2(v)])] ^
+				T2[BYTE0(T4[BYTE1(v)])] ^
+				T3[BYTE0(T4[BYTE0(v)])];
 		}
 	}
 
@@ -593,28 +593,28 @@ static void anubis_crypt(u32 roundKey[AN
 
 	for (i = 1; i < R; i++) {
 		inter[0] =
-			T0[(state[0] >> 24)       ] ^
-			T1[(state[1] >> 24)       ] ^
-			T2[(state[2] >> 24)       ] ^
-			T3[(state[3] >> 24)       ] ^
+			T0[BYTE3(state[0])] ^
+			T1[BYTE3(state[1])] ^
+			T2[BYTE3(state[2])] ^
+			T3[BYTE3(state[3])] ^
 			roundKey[i][0];
 		inter[1] =
-			T0[(state[0] >> 16) & 0xff] ^
-			T1[(state[1] >> 16) & 0xff] ^
-			T2[(state[2] >> 16) & 0xff] ^
-			T3[(state[3] >> 16) & 0xff] ^
+			T0[BYTE2(state[0])] ^
+			T1[BYTE2(state[1])] ^
+			T2[BYTE2(state[2])] ^
+			T3[BYTE2(state[3])] ^
 			roundKey[i][1];
 		inter[2] =
-			T0[(state[0] >>  8) & 0xff] ^
-			T1[(state[1] >>  8) & 0xff] ^
-			T2[(state[2] >>  8) & 0xff] ^
-			T3[(state[3] >>  8) & 0xff] ^
+			T0[BYTE1(state[0])] ^
+			T1[BYTE1(state[1])] ^
+			T2[BYTE1(state[2])] ^
+			T3[BYTE1(state[3])] ^
 			roundKey[i][2];
 		inter[3] =
-			T0[(state[0]      ) & 0xff] ^
-			T1[(state[1]      ) & 0xff] ^
-			T2[(state[2]      ) & 0xff] ^
-			T3[(state[3]      ) & 0xff] ^
+			T0[BYTE0(state[0])] ^
+			T1[BYTE0(state[1])] ^
+			T2[BYTE0(state[2])] ^
+			T3[BYTE0(state[3])] ^
 			roundKey[i][3];
 		state[0] = inter[0];
 		state[1] = inter[1];
@@ -627,28 +627,28 @@ static void anubis_crypt(u32 roundKey[AN
 	 */
 
 	inter[0] =
-		(T0[(state[0] >> 24)       ] & 0xff000000U) ^
-		(T1[(state[1] >> 24)       ] & 0x00ff0000U) ^
-		(T2[(state[2] >> 24)       ] & 0x0000ff00U) ^
-		(T3[(state[3] >> 24)       ] & 0x000000ffU) ^
+		(T0[BYTE3(state[0])] & 0xff000000U) ^
+		(T1[BYTE3(state[1])] & 0x00ff0000U) ^
+		(T2[BYTE3(state[2])] & 0x0000ff00U) ^
+		(T3[BYTE3(state[3])] & 0x000000ffU) ^
 		roundKey[R][0];
 	inter[1] =
-		(T0[(state[0] >> 16) & 0xff] & 0xff000000U) ^
-		(T1[(state[1] >> 16) & 0xff] & 0x00ff0000U) ^
-		(T2[(state[2] >> 16) & 0xff] & 0x0000ff00U) ^
-		(T3[(state[3] >> 16) & 0xff] & 0x000000ffU) ^
+		(T0[BYTE2(state[0])] & 0xff000000U) ^
+		(T1[BYTE2(state[1])] & 0x00ff0000U) ^
+		(T2[BYTE2(state[2])] & 0x0000ff00U) ^
+		(T3[BYTE2(state[3])] & 0x000000ffU) ^
 		roundKey[R][1];
 	inter[2] =
-		(T0[(state[0] >>  8) & 0xff] & 0xff000000U) ^
-		(T1[(state[1] >>  8) & 0xff] & 0x00ff0000U) ^
-		(T2[(state[2] >>  8) & 0xff] & 0x0000ff00U) ^
-		(T3[(state[3] >>  8) & 0xff] & 0x000000ffU) ^
+		(T0[BYTE1(state[0])] & 0xff000000U) ^
+		(T1[BYTE1(state[1])] & 0x00ff0000U) ^
+		(T2[BYTE1(state[2])] & 0x0000ff00U) ^
+		(T3[BYTE1(state[3])] & 0x000000ffU) ^
 		roundKey[R][2];
 	inter[3] =
-		(T0[(state[0]      ) & 0xff] & 0xff000000U) ^
-		(T1[(state[1]      ) & 0xff] & 0x00ff0000U) ^
-		(T2[(state[2]      ) & 0xff] & 0x0000ff00U) ^
-		(T3[(state[3]      ) & 0xff] & 0x000000ffU) ^
+		(T0[BYTE0(state[0])] & 0xff000000U) ^
+		(T1[BYTE0(state[1])] & 0x00ff0000U) ^
+		(T2[BYTE0(state[2])] & 0x0000ff00U) ^
+		(T3[BYTE0(state[3])] & 0x000000ffU) ^
 		roundKey[R][3];
 
 	/*
diff -urpN linux-2.6.12-rc2.3.twofish/crypto/des.c linux-2.6.12-rc2.z.cur/crypto/des.c
--- linux-2.6.12-rc2.3.twofish/crypto/des.c	Fri Apr 22 11:48:48 2005
+++ linux-2.6.12-rc2.z.cur/crypto/des.c	Fri Apr 22 12:20:56 2005
@@ -297,11 +297,50 @@ static void des_small_fips_encrypt(u32 *
 	z  = ((y >> 010) ^ x) & 0x00FF00FFL;
 	y ^= z << 010;
 	x ^= z;
-	x  = x >> 1 | x << 31;
+	x  = ror32(x, 1);
 	z  = (x ^ y) & 0x55555555L;
 	y ^= z;
 	x ^= z;
-	y  = y >> 1 | y << 31;
+	y  = ror32(y, 1);
+#if 1
+	u32 *p = expkey;
+	expkey += 32;
+	do {	/* ~80 insns */
+		z  = *p++ ^ y;
+		x ^= * (u32 *) ((u8 *) (des_keymap + 192) + (0xFC & z));
+		z >>= 8;
+		x ^= * (u32 *) ((u8 *) (des_keymap + 128) + (0xFC & z));
+		z >>= 8;
+		x ^= * (u32 *) ((u8 *) (des_keymap + 64) + (0xFC & z));
+		z >>= 8;
+		x ^= * (u32 *) ((u8 *) des_keymap + (0xFC & z));
+		z  = rol32(*p++ ^ y, 4);
+		x ^= * (u32 *) ((u8 *) (des_keymap + 448) + (0xFC & z));
+		z >>= 8;
+		x ^= * (u32 *) ((u8 *) (des_keymap + 384) + (0xFC & z));
+		z >>= 8;
+		x ^= * (u32 *) ((u8 *) (des_keymap + 320) + (0xFC & z));
+		z >>= 8;
+		x ^= * (u32 *) ((u8 *) (des_keymap + 256) + (0xFC & z));
+
+		z  = *p++ ^ x;
+		y ^= * (u32 *) ((u8 *) (des_keymap + 192) + (0xFC & z));
+		z >>= 8;
+		y ^= * (u32 *) ((u8 *) (des_keymap + 128) + (0xFC & z));
+		z >>= 8;
+		y ^= * (u32 *) ((u8 *) (des_keymap + 64) + (0xFC & z));
+		z >>= 8;
+		y ^= * (u32 *) ((u8 *) des_keymap + (0xFC & z));
+		z  = rol32(*p++ ^ x, 4);
+		y ^= * (u32 *) ((u8 *) (des_keymap + 448) + (0xFC & z));
+		z >>= 8;
+		y ^= * (u32 *) ((u8 *) (des_keymap + 384) + (0xFC & z));
+		z >>= 8;
+		y ^= * (u32 *) ((u8 *) (des_keymap + 320) + (0xFC & z));
+		z >>= 8;
+		y ^= * (u32 *) ((u8 *) (des_keymap + 256) + (0xFC & z));
+	} while(p!=expkey);
+#else
 	z  = expkey[0];
 	z ^= y;
 	x ^= * (u32 *) ((u8 *) (des_keymap + 192) + (0xFC & z));
@@ -606,11 +645,12 @@ static void des_small_fips_encrypt(u32 *
 	y ^= * (u32 *) ((u8 *) (des_keymap + 320) + (0xFC & z));
 	z >>= 8;
 	y ^= * (u32 *) ((u8 *) (des_keymap + 256) + (0xFC & z));
-	x  = x << 1 | x >> 31;
+#endif
+	x  = rol32(x, 1);
 	z  = (x ^ y) & 0x55555555L;
 	y ^= z;
 	x ^= z;
-	y  = y << 1 | y >> 31;
+	y  = rol32(y, 1);
 	z  = ((x >> 010) ^ y) & 0x00FF00FFL;
 	x ^= z << 010;
 	y ^= z;
@@ -647,11 +687,49 @@ static void des_small_fips_decrypt(u32 *
 	z  = ((y >> 010) ^ x) & 0x00FF00FFL;
 	y ^= z << 010;
 	x ^= z;
-	x  = x >> 1 | x << 31;
+	x  = ror32(x, 1);
 	z  = (x ^ y) & 0x55555555L;
 	y ^= z;
 	x ^= z;
-	y  = y >> 1 | y << 31;
+	y  = ror32(y, 1);
+#if 1
+	u32 *p = expkey+31;
+	do {	/* ~80 insns */
+		z  = rol32(*p-- ^ y, 4);
+		x ^= * (u32 *) ((u8 *) (des_keymap + 448) + (0xFC & z));
+		z >>= 8;
+		x ^= * (u32 *) ((u8 *) (des_keymap + 384) + (0xFC & z));
+		z >>= 8;
+		x ^= * (u32 *) ((u8 *) (des_keymap + 320) + (0xFC & z));
+		z >>= 8;
+		x ^= * (u32 *) ((u8 *) (des_keymap + 256) + (0xFC & z));
+		z  = *p-- ^ y;
+		x ^= * (u32 *) ((u8 *) (des_keymap + 192) + (0xFC & z));
+		z >>= 8;
+		x ^= * (u32 *) ((u8 *) (des_keymap + 128) + (0xFC & z));
+		z >>= 8;
+		x ^= * (u32 *) ((u8 *) (des_keymap + 64) + (0xFC & z));
+		z >>= 8;
+		x ^= * (u32 *) ((u8 *) des_keymap + (0xFC & z));
+
+		z  = rol32(*p-- ^ x, 4);
+		y ^= * (u32 *) ((u8 *) (des_keymap + 448) + (0xFC & z));
+		z >>= 8;
+		y ^= * (u32 *) ((u8 *) (des_keymap + 384) + (0xFC & z));
+		z >>= 8;
+		y ^= * (u32 *) ((u8 *) (des_keymap + 320) + (0xFC & z));
+		z >>= 8;
+		y ^= * (u32 *) ((u8 *) (des_keymap + 256) + (0xFC & z));
+		z  = *p-- ^ x;
+		y ^= * (u32 *) ((u8 *) (des_keymap + 192) + (0xFC & z));
+		z >>= 8;
+		y ^= * (u32 *) ((u8 *) (des_keymap + 128) + (0xFC & z));
+		z >>= 8;
+		y ^= * (u32 *) ((u8 *) (des_keymap + 64) + (0xFC & z));
+		z >>= 8;
+		y ^= * (u32 *) ((u8 *) des_keymap + (0xFC & z));
+	} while(p >= expkey);
+#else
 	z  = expkey[31];
 	z ^= y;
 	z  = z << 4 | z >> 28;
@@ -956,11 +1034,12 @@ static void des_small_fips_decrypt(u32 *
 	y ^= * (u32 *) ((u8 *) (des_keymap + 64) + (0xFC & z));
 	z >>= 8;
 	y ^= * (u32 *) ((u8 *) des_keymap + (0xFC & z));
-	x  = x << 1 | x >> 31;
+#endif
+	x  = rol32(x, 1);
 	z  = (x ^ y) & 0x55555555L;
 	y ^= z;
 	x ^= z;
-	y  = y << 1 | y >> 31;
+	y  = rol32(y, 1);
 	z  = ((x >> 010) ^ y) & 0x00FF00FFL;
 	x ^= z << 010;
 	y ^= z;
diff -urpN linux-2.6.12-rc2.3.twofish/crypto/khazad.c linux-2.6.12-rc2.z.cur/crypto/khazad.c
--- linux-2.6.12-rc2.3.twofish/crypto/khazad.c	Thu Apr 21 23:36:20 2005
+++ linux-2.6.12-rc2.z.cur/crypto/khazad.c	Thu Apr 21 23:37:00 2005
@@ -773,14 +773,14 @@ static int khazad_setkey(void *ctx_arg, 
 
 	/* setup the encrypt key */
 	for (r = 0; r <= KHAZAD_ROUNDS; r++) {
-		ctx->E[r] = T0[(int)(K1 >> 56)       ] ^
-			    T1[(int)(K1 >> 48) & 0xff] ^
-			    T2[(int)(K1 >> 40) & 0xff] ^
-			    T3[(int)(K1 >> 32) & 0xff] ^
-			    T4[(int)(K1 >> 24) & 0xff] ^
-			    T5[(int)(K1 >> 16) & 0xff] ^
-			    T6[(int)(K1 >>  8) & 0xff] ^
-			    T7[(int)(K1      ) & 0xff] ^
+		ctx->E[r] = T0[BYTE7(K1)] ^
+			    T1[BYTE6(K1)] ^
+			    T2[BYTE5(K1)] ^
+			    T3[BYTE4(K1)] ^
+			    T4[BYTE3(K1)] ^
+			    T5[BYTE2(K1)] ^
+			    T6[BYTE1(K1)] ^
+			    T7[BYTE0(K1)] ^
 			    c[r] ^ K2;
 		K2 = K1; 
 		K1 = ctx->E[r];
@@ -789,14 +789,14 @@ static int khazad_setkey(void *ctx_arg, 
 	ctx->D[0] = ctx->E[KHAZAD_ROUNDS];
 	for (r = 1; r < KHAZAD_ROUNDS; r++) {
 		K1 = ctx->E[KHAZAD_ROUNDS - r];
-		ctx->D[r] = T0[(int)S[(int)(K1 >> 56)       ] & 0xff] ^
-			    T1[(int)S[(int)(K1 >> 48) & 0xff] & 0xff] ^
-			    T2[(int)S[(int)(K1 >> 40) & 0xff] & 0xff] ^
-			    T3[(int)S[(int)(K1 >> 32) & 0xff] & 0xff] ^
-			    T4[(int)S[(int)(K1 >> 24) & 0xff] & 0xff] ^
-			    T5[(int)S[(int)(K1 >> 16) & 0xff] & 0xff] ^
-			    T6[(int)S[(int)(K1 >>  8) & 0xff] & 0xff] ^
-			    T7[(int)S[(int)(K1      ) & 0xff] & 0xff];
+		ctx->D[r] = T0[BYTE0(S[BYTE7(K1)])] ^
+			    T1[BYTE0(S[BYTE6(K1)])] ^
+			    T2[BYTE0(S[BYTE5(K1)])] ^
+			    T3[BYTE0(S[BYTE4(K1)])] ^
+			    T4[BYTE0(S[BYTE3(K1)])] ^
+			    T5[BYTE0(S[BYTE2(K1)])] ^
+			    T6[BYTE0(S[BYTE1(K1)])] ^
+			    T7[BYTE0(S[BYTE0(K1)])];
 	}
 	ctx->D[KHAZAD_ROUNDS] = ctx->E[0];
 
@@ -813,25 +813,25 @@ static void khazad_crypt(const u64 round
 	state = load_be64(plaintext,0) ^ roundKey[0];
 
 	for (r = 1; r < KHAZAD_ROUNDS; r++) {
-		state = T0[(int)(state >> 56)       ] ^
-			T1[(int)(state >> 48) & 0xff] ^
-			T2[(int)(state >> 40) & 0xff] ^
-			T3[(int)(state >> 32) & 0xff] ^
-			T4[(int)(state >> 24) & 0xff] ^
-			T5[(int)(state >> 16) & 0xff] ^
-			T6[(int)(state >>  8) & 0xff] ^
-			T7[(int)(state      ) & 0xff] ^
+		state = T0[BYTE7(state)] ^
+			T1[BYTE6(state)] ^
+			T2[BYTE5(state)] ^
+			T3[BYTE4(state)] ^
+			T4[BYTE3(state)] ^
+			T5[BYTE2(state)] ^
+			T6[BYTE1(state)] ^
+			T7[BYTE0(state)] ^
 			roundKey[r];
     	}
 
-	state = (T0[(int)(state >> 56)       ] & 0xff00000000000000ULL) ^
-		(T1[(int)(state >> 48) & 0xff] & 0x00ff000000000000ULL) ^
-		(T2[(int)(state >> 40) & 0xff] & 0x0000ff0000000000ULL) ^
-		(T3[(int)(state >> 32) & 0xff] & 0x000000ff00000000ULL) ^
-		(T4[(int)(state >> 24) & 0xff] & 0x00000000ff000000ULL) ^
-		(T5[(int)(state >> 16) & 0xff] & 0x0000000000ff0000ULL) ^
-		(T6[(int)(state >>  8) & 0xff] & 0x000000000000ff00ULL) ^
-		(T7[(int)(state      ) & 0xff] & 0x00000000000000ffULL) ^
+	state = (T0[BYTE7(state)] & 0xff00000000000000ULL) ^
+		(T1[BYTE6(state)] & 0x00ff000000000000ULL) ^
+		(T2[BYTE5(state)] & 0x0000ff0000000000ULL) ^
+		(T3[BYTE4(state)] & 0x000000ff00000000ULL) ^
+		(T4[BYTE3(state)] & 0x00000000ff000000ULL) ^
+		(T5[BYTE2(state)] & 0x0000000000ff0000ULL) ^
+		(T6[BYTE1(state)] & 0x000000000000ff00ULL) ^
+		(T7[BYTE0(state)] & 0x00000000000000ffULL) ^
 		roundKey[KHAZAD_ROUNDS];
 
 	store_be64(ciphertext,0, state);
diff -urpN linux-2.6.12-rc2.3.twofish/crypto/tgr192.c linux-2.6.12-rc2.z.cur/crypto/tgr192.c
--- linux-2.6.12-rc2.3.twofish/crypto/tgr192.c	Thu Apr 21 23:36:20 2005
+++ linux-2.6.12-rc2.z.cur/crypto/tgr192.c	Fri Apr 22 09:17:58 2005
@@ -405,11 +405,13 @@ static void tgr192_round(u64 * ra, u64 *
 	u64 c = *rc;
 
 	c ^= x;
-	a -= sbox1[c         & 0xff] ^ sbox2[(c >> 16) & 0xff]
-	   ^ sbox3[(c >> 32) & 0xff] ^ sbox4[(c >> 48) & 0xff];
-	b += sbox4[(c >>  8) & 0xff] ^ sbox3[(c >> 24) & 0xff]
-	   ^ sbox2[(c >> 40) & 0xff] ^ sbox1[(c >> 56) & 0xff];
+	a -= sbox1[BYTE0(c)] ^ sbox2[BYTE2(c)]
+	   ^ sbox3[BYTE4(c)] ^ sbox4[BYTE6(c)];
+	b += sbox4[BYTE1(c)] ^ sbox3[BYTE3(c)]
+	   ^ sbox2[BYTE5(c)] ^ sbox1[BYTE7(c)];
 	b *= mul;
+	//if mul==5 b=(b<<2)+b
+	//else b=(b<<3) + (mul=7? -b : b)
 
 	*ra = a;
 	*rb = b;
@@ -419,22 +421,14 @@ static void tgr192_round(u64 * ra, u64 *
 
 static void tgr192_pass(u64 * ra, u64 * rb, u64 * rc, u64 * x, int mul)
 {
-	u64 a = *ra;
-	u64 b = *rb;
-	u64 c = *rc;
-
-	tgr192_round(&a, &b, &c, x[0], mul);
-	tgr192_round(&b, &c, &a, x[1], mul);
-	tgr192_round(&c, &a, &b, x[2], mul);
-	tgr192_round(&a, &b, &c, x[3], mul);
-	tgr192_round(&b, &c, &a, x[4], mul);
-	tgr192_round(&c, &a, &b, x[5], mul);
-	tgr192_round(&a, &b, &c, x[6], mul);
-	tgr192_round(&b, &c, &a, x[7], mul);
-
-	*ra = a;
-	*rb = b;
-	*rc = c;
+	tgr192_round(ra, rb, rc, x[0], mul);
+	tgr192_round(rb, rc, ra, x[1], mul);
+	tgr192_round(rc, ra, rb, x[2], mul);
+	tgr192_round(ra, rb, rc, x[3], mul);
+	tgr192_round(rb, rc, ra, x[4], mul);
+	tgr192_round(rc, ra, rb, x[5], mul);
+	tgr192_round(ra, rb, rc, x[6], mul);
+	tgr192_round(rb, rc, ra, x[7], mul);
 }
 
 
@@ -465,7 +459,7 @@ static void tgr192_key_schedule(u64 * x)
 
 static void tgr192_transform(struct tgr192_ctx *tctx, const u8 * data)
 {
-	u64 a, b, c, aa, bb, cc;
+	u64 a, b, c;
 	u64 x[8];
 	int i;
 
@@ -473,10 +467,10 @@ static void tgr192_transform(struct tgr1
 		x[i] = load_le64(data,i);
 	}
 
-	/* save */
-	a = aa = tctx->a;
-	b = bb = tctx->b;
-	c = cc = tctx->c;
+	/* load */
+	a = tctx->a;
+	b = tctx->b;
+	c = tctx->c;
 
 	tgr192_pass(&a, &b, &c, x, 5);
 	tgr192_key_schedule(x);
@@ -484,15 +478,10 @@ static void tgr192_transform(struct tgr1
 	tgr192_key_schedule(x);
 	tgr192_pass(&b, &c, &a, x, 9);
 
-
-	/* feedforward */
-	a ^= aa;
-	b -= bb;
-	c += cc;
-	/* store */
-	tctx->a = a;
-	tctx->b = b;
-	tctx->c = c;
+	/* feedforward and store */
+	tctx->a = a ^ tctx->a;
+	tctx->b = b - tctx->b;
+	tctx->c = c + tctx->c;
 }
 
 static void tgr192_init(void *ctx)
@@ -659,7 +648,7 @@ static struct crypto_alg tgr128 = {
 
 static int __init init(void)
 {
-	int ret = 0;
+	int ret;
 
 	ret = crypto_register_alg(&tgr192);
 
diff -urpN linux-2.6.12-rc2.3.twofish/crypto/wp512.c linux-2.6.12-rc2.z.cur/crypto/wp512.c
--- linux-2.6.12-rc2.3.twofish/crypto/wp512.c	Thu Apr 21 23:43:00 2005
+++ linux-2.6.12-rc2.z.cur/crypto/wp512.c	Thu Apr 21 23:42:50 2005
@@ -1018,14 +1018,14 @@ static void wp512_update(void *ctx, cons
 
 	u64 value = bits_len;
 	for (i = 31, carry = 0; i >= 0 && (carry != 0 || value != 0ULL); i--) {
-		carry += bitLength[i] + ((u32)value & 0xff);
+		carry += bitLength[i] + ((u8)value);
 		bitLength[i] = (u8)carry;
 		carry >>= 8;
 		value >>= 8;
 	}
 	while (bits_len > 8) {
-		b = ((source[sourcePos] << sourceGap) & 0xff) |
-		((source[sourcePos + 1] & 0xff) >> (8 - sourceGap));
+		b = ((u8)(source[sourcePos] << sourceGap)) |
+		(((u8)source[sourcePos + 1]) >> (8 - sourceGap));
 		buffer[bufferPos++] |= (u8)(b >> bufferRem);
 		bufferBits += 8 - bufferRem;
 		if (bufferBits == WP512_BLOCK_SIZE * 8) {
@@ -1038,7 +1038,7 @@ static void wp512_update(void *ctx, cons
 		sourcePos++;
 	}
 	if (bits_len > 0) {
-		b = (source[sourcePos] << sourceGap) & 0xff;
+		b = (u8)(source[sourcePos] << sourceGap);
 		buffer[bufferPos] |= b >> bufferRem;
 	} else {
 		b = 0;

--Boundary-00=_pFNaC5ACvB4csUm--

