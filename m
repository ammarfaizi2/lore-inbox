Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318259AbSG3NU3>; Tue, 30 Jul 2002 09:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318261AbSG3NU3>; Tue, 30 Jul 2002 09:20:29 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:59337 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318259AbSG3NUY>;
	Tue, 30 Jul 2002 09:20:24 -0400
Date: Tue, 30 Jul 2002 15:23:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: [patch] Input cleanups for 2.5.29 [2/2]
Message-ID: <20020730152342.B20071@ucw.cz>
References: <20020730122638.A11153@ucw.cz> <20020730122918.A11248@ucw.cz> <20020730152255.A20071@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020730152255.A20071@ucw.cz>; from vojtech@suse.cz on Tue, Jul 30, 2002 at 03:22:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.529, 2002-07-30 15:19:33+02:00, vojtech@suse.cz
  Use stdint.h types instead of __u16 et al in input.h, to make life
  easier for userspace people, as Brad Hards has suggested.


===================================================================

 input.h |   74 ++++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 37 insertions(+), 37 deletions(-)

===================================================================

diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Tue Jul 30 15:21:51 2002
+++ b/include/linux/input.h	Tue Jul 30 15:21:51 2002
@@ -32,7 +32,7 @@
 #else
 #include <sys/time.h>
 #include <sys/ioctl.h>
-#include <asm/types.h>
+#include <stdint.h>
 #endif
 
 /*
@@ -41,9 +41,9 @@
 
 struct input_event {
 	struct timeval time;
-	unsigned short type;
-	unsigned short code;
-	unsigned int value;
+	uint16_t type;
+	uint16_t code;
+	int32_t value;
 };
 
 /*
@@ -57,10 +57,10 @@
  */
 
 struct input_id {
-	__u16 bustype;
-	__u16 vendor;
-	__u16 product;
-	__u16 version;
+	uint16_t bustype;
+	uint16_t vendor;
+	uint16_t product;
+	uint16_t version;
 };
 
 struct input_absinfo {
@@ -611,62 +611,62 @@
  */
 
 struct ff_replay {
-	__u16 length; /* Duration of an effect in ms. All other times are also expressed in ms */
-	__u16 delay;  /* Time to wait before to start playing an effect */
+	uint16_t length; /* Duration of an effect in ms. All other times are also expressed in ms */
+	uint16_t delay;  /* Time to wait before to start playing an effect */
 };
 
 struct ff_trigger {
-	__u16 button;   /* Number of button triggering an effect */
-	__u16 interval; /* Time to wait before an effect can be re-triggered (ms) */
+	uint16_t button;   /* Number of button triggering an effect */
+	uint16_t interval; /* Time to wait before an effect can be re-triggered (ms) */
 };
 
 struct ff_envelope {
-	__u16 attack_length;	/* Duration of attack (ms) */
-	__u16 attack_level;	/* Level at beginning of attack */
-	__u16 fade_length;	/* Duration of fade (ms) */
-	__u16 fade_level;	/* Level at end of fade */
+	uint16_t attack_length;	/* Duration of attack (ms) */
+	uint16_t attack_level;	/* Level at beginning of attack */
+	uint16_t fade_length;	/* Duration of fade (ms) */
+	uint16_t fade_level;	/* Level at end of fade */
 };
 
 /* FF_CONSTANT */
 struct ff_constant_effect {
-	__s16 level;	    /* Strength of effect. Negative values are OK */
+	int16_t level;	    /* Strength of effect. Negative values are OK */
 	struct ff_envelope envelope;
 };
 
 /* FF_RAMP */
 struct ff_ramp_effect {
-	__s16 start_level;
-	__s16 end_level;
+	int16_t start_level;
+	int16_t end_level;
 	struct ff_envelope envelope;
 };
 
 /* FF_SPRING of FF_FRICTION */
 struct ff_condition_effect {
-	__u16 right_saturation; /* Max level when joystick is on the right */
-	__u16 left_saturation;  /* Max level when joystick in on the left */
+	uint16_t right_saturation; /* Max level when joystick is on the right */
+	uint16_t left_saturation;  /* Max level when joystick in on the left */
 
-	__s16 right_coeff;	/* Indicates how fast the force grows when the
+	int16_t right_coeff;	/* Indicates how fast the force grows when the
 				   joystick moves to the right */
-	__s16 left_coeff;	/* Same for left side */
+	int16_t left_coeff;	/* Same for left side */
 
-	__u16 deadband;	/* Size of area where no force is produced */
-	__s16 center;	/* Position of dead zone */
+	uint16_t deadband;	/* Size of area where no force is produced */
+	int16_t center;	/* Position of dead zone */
 
 };
 
 /* FF_PERIODIC */
 struct ff_periodic_effect {
-	__u16 waveform;	/* Kind of wave (sine, square...) */
-	__u16 period;	/* in ms */
-	__s16 magnitude;	/* Peak value */
-	__s16 offset;	/* Mean value of wave (roughly) */
-	__u16 phase;		/* 'Horizontal' shift */
+	uint16_t waveform;	/* Kind of wave (sine, square...) */
+	uint16_t period;	/* in ms */
+	int16_t magnitude;	/* Peak value */
+	int16_t offset;	/* Mean value of wave (roughly) */
+	uint16_t phase;		/* 'Horizontal' shift */
 
 	struct ff_envelope envelope;
 
 /* Only used if waveform == FF_CUSTOM */
-	__u32 custom_len;	/* Number of samples  */	
-	__s16 *custom_data;	/* Buffer of samples */
+	uint32_t custom_len;	/* Number of samples  */	
+	int16_t *custom_data;	/* Buffer of samples */
 /* Note: the data pointed by custom_data is copied by the driver. You can
  * therefore dispose of the memory after the upload/update */
 };
@@ -677,22 +677,22 @@
    by the heavy motor.
 */
 struct ff_rumble_effect {
-	__u16 strong_magnitude;  /* Magnitude of the heavy motor */
-	__u16 weak_magnitude;    /* Magnitude of the light one */
+	uint16_t strong_magnitude;  /* Magnitude of the heavy motor */
+	uint16_t weak_magnitude;    /* Magnitude of the light one */
 };
 
 /*
  * Structure sent through ioctl from the application to the driver
  */
 struct ff_effect {
-	__u16 type;
+	uint16_t type;
 /* Following field denotes the unique id assigned to an effect.
  * If user sets if to -1, a new effect is created, and its id is returned in the same field
  * Else, the user sets it to the effect id it wants to update.
  */
-	__s16 id;
+	int16_t id;
 
-	__u16 direction;	/* Direction. 0 deg -> 0x0000 (down)
+	uint16_t direction;	/* Direction. 0 deg -> 0x0000 (down)
 					     90 deg -> 0x4000 (left)
 					    180 deg -> 0x8000 (up)
 					    270 deg -> 0xC000 (right)

===================================================================

This BitKeeper patch contains the following changesets:
1.529
## Wrapped with gzip_uu ##


begin 664 bkpatch20062
M'XL(`.^21CT``[5666_;.!!^MG[%`'WH&5FWCVR*'EYL@UY!LGT.:(F2V$BD
M2U)V4OC'[Y"2+<M-6NSE!*9YS#<?9[X9Z1%\453.1VOQ5=.T=![!.Z'T?*0:
M1=WT.\XOA<#YN!0U'7>GQLN;,>.K1CNX?T%T6L*:2C4?^6ZX7]%W*SH?7?[^
MQY</KR\=Y^P,WI:$%_2*:C@[<[20:U)EZA71926XJR7AJJ::N*FHM_NCV\#S
M`OR+_4GHQ<G63[QHLDW]S/=)Y-/,"Z)I$CG+DDC$6K)B)7CF<JI=TARC(((?
M&JQM.`N"F;,`WXV#&7C!V)N,0P_\>.[/YF'XW`OFG@?=;5]UL8#G/IQXSAOX
M;ZF_=5*3`U`Z8UR[;>`4,*XT)1F('*ZO&S\!#!NI<!ELY-WR!?*`FMQ0J%A.
M$802Q:B$7$A`PE*M2$IA1<6JHB^`*'@C$>Z=B1.4.%5-45#TD;G.>PBG$R]V
M+OH4.2=_\^,X'O&<E[\(#N-IU61T7#'>W(Z[FQP&:A;YVR2*_.DV#X/E-`B3
M)*<>)=[T.!T_P[*9]F>AMPVB"6;:J._>X[]6XK]@_(`J?\7;(*-8HMG$*M2/
M?A"H]Y!`PPF<A)/_1:(?Q9H:Q0UE:K33AO@SG,B-_4<M7-P?[7\@JD48@^^<
MV^]''2C\MB/QTEE$$83.>93@]ZC!13^YUI;;Z<$\%9F9XS0,<(JA:7"^2#R(
MG/,DQ._^[+)1Q^9KRC,A#U=64F1-JH>'I&*"&UA,68"X?HQ#?Z"BO-#E*8R?
MP:*11.-A4]V$`\USFFI3V[5RX755@=`EEK)F-78"(BE6OA)`;U>2*D6S]B0\
M&Q^@9[0B=Z=@T/]$,Y.J#6%X'8H-H<L<D<@<CS%>'+A%&*0\LY0#;T!YV6B-
M5P(+^ZFIET@**;?+H"7#%B)_0.OM<:1&B*</T>KM4ORYI"#I20>+UWQ2JZ<M
MO2"RF0HF@U01K4EZ<]T%=G0<6+N[![G';$TK:_7!_,)E)%`PSLV%>ON!:4XR
M^I`_LW>/M\[D!U^HJ;V5O6,8&*6WPZ@7C36$-@576EK?QK"-FPN?:($4L#BM
MJENY?'[?04YM5D.3W#VDU4''J%]%.KNU11+%U@ZKZE`-F)=27RNBNTO;K'XD
MMRU)V)24PU=QIS3#L#$%1B(E;<V&,:EH/@3Z*1+?(1FS]F+1U,;*#J,AOU1@
M9&RHSWG&4J(Q)J788*"5MB@H/'PP%E)L5.L)%Q$R]BRD'48#HCWB%:FM?<M$
ML5WJXL#&*PX'\<KP^;TD/&M-V7=J524I,6XQ2UQT7#!6;4-!S9LX[=L6-?5C
MS2^$8CNA&5SX+OC.^0QB=(YM+#YPOB%K4V*UM7[/6K&917BB&,<W`O6M02ZN
MZQ[I=845+5K.?9O9;=:DX$QC#VY)47+3RFYP2.2YHMJ>^$BQK-L3>_=2-$59
MW1V[Q7<21#5&C]\)R?!^FE2/095LE_2D57,RVT79-O,4^[6H35%:CWV74J3&
M5Q\%:#SJR3WKSF=$$VOPIL%"&AA89U//.IOZ@Y0J+04OKOLP=,KMI@;%2*RD
M9'T'M<#'\/"6&XS8P/I^^\J6S#[#TU;M=CA^R"V266AW[;"_)LOL5MQNQ0/#
MC$GL'*;N;`O;S5SP4%H%G+P$[];##SS)Q(8_[5_RTY*F-ZJISY8DRF=YD#M_
)`4P*E3<_#```
`
end
-- 
Vojtech Pavlik
SuSE Labs
