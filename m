Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSG3V7r>; Tue, 30 Jul 2002 17:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316864AbSG3V7r>; Tue, 30 Jul 2002 17:59:47 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:40662 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316857AbSG3V7i>;
	Tue, 30 Jul 2002 17:59:38 -0400
Date: Wed, 31 Jul 2002 00:02:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
Message-ID: <20020731000243.B24349@ucw.cz>
References: <20020730233542.A23181@ucw.cz> <Pine.LNX.4.33.0207301441050.2051-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0207301441050.2051-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jul 30, 2002 at 02:46:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 02:46:12PM -0700, Linus Torvalds wrote:

>  - in this case, maybe just adding a new cset is the proper thing. 
>    Especially as reversing the cset doesn't actually get you where you
>    want anyway, since you'd still have to do the "unsigned short" -> "u16"  
>    translation as yet another cset.

Ok, here you go:

===================================================================

ChangeSet@1.533, 2002-07-30 23:54:08+02:00, vojtech@suse.cz
  Revert input.h back to kernel types.

 input.h |   84 ++++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 42 insertions(+), 42 deletions(-)

diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Wed Jul 31 00:01:00 2002
+++ b/include/linux/input.h	Wed Jul 31 00:01:00 2002
@@ -32,7 +32,7 @@
 #else
 #include <sys/time.h>
 #include <sys/ioctl.h>
-#include <stdint.h>
+#include <asm/types.h>
 #endif
 
 /*
@@ -41,9 +41,9 @@
 
 struct input_event {
 	struct timeval time;
-	uint16_t type;
-	uint16_t code;
-	int32_t value;
+	__u16 type;
+	__u16 code;
+	__s32 value;
 };
 
 /*
@@ -57,18 +57,18 @@
  */
 
 struct input_id {
-	uint16_t bustype;
-	uint16_t vendor;
-	uint16_t product;
-	uint16_t version;
+	__u16 bustype;
+	__u16 vendor;
+	__u16 product;
+	__u16 version;
 };
 
 struct input_absinfo {
-	int value;
-	int minimum;
-	int maximum;
-	int fuzz;
-	int flat;
+	__s32 value;
+	__s32 minimum;
+	__s32 maximum;
+	__s32 fuzz;
+	__s32 flat;
 };
 
 #define EVIOCGVERSION		_IOR('E', 0x01, int)			/* get driver version */
@@ -611,62 +611,62 @@
  */
 
 struct ff_replay {
-	uint16_t length; /* Duration of an effect in ms. All other times are also expressed in ms */
-	uint16_t delay;  /* Time to wait before to start playing an effect */
+	__u16 length; /* Duration of an effect in ms. All other times are also expressed in ms */
+	__u16 delay;  /* Time to wait before to start playing an effect */
 };
 
 struct ff_trigger {
-	uint16_t button;   /* Number of button triggering an effect */
-	uint16_t interval; /* Time to wait before an effect can be re-triggered (ms) */
+	__u16 button;   /* Number of button triggering an effect */
+	__u16 interval; /* Time to wait before an effect can be re-triggered (ms) */
 };
 
 struct ff_envelope {
-	uint16_t attack_length;	/* Duration of attack (ms) */
-	uint16_t attack_level;	/* Level at beginning of attack */
-	uint16_t fade_length;	/* Duration of fade (ms) */
-	uint16_t fade_level;	/* Level at end of fade */
+	__u16 attack_length;	/* Duration of attack (ms) */
+	__u16 attack_level;	/* Level at beginning of attack */
+	__u16 fade_length;	/* Duration of fade (ms) */
+	__u16 fade_level;	/* Level at end of fade */
 };
 
 /* FF_CONSTANT */
 struct ff_constant_effect {
-	int16_t level;	    /* Strength of effect. Negative values are OK */
+	__s16 level;	    /* Strength of effect. Negative values are OK */
 	struct ff_envelope envelope;
 };
 
 /* FF_RAMP */
 struct ff_ramp_effect {
-	int16_t start_level;
-	int16_t end_level;
+	__s16 start_level;
+	__s16 end_level;
 	struct ff_envelope envelope;
 };
 
 /* FF_SPRING of FF_FRICTION */
 struct ff_condition_effect {
-	uint16_t right_saturation; /* Max level when joystick is on the right */
-	uint16_t left_saturation;  /* Max level when joystick in on the left */
+	__u16 right_saturation; /* Max level when joystick is on the right */
+	__u16 left_saturation;  /* Max level when joystick in on the left */
 
-	int16_t right_coeff;	/* Indicates how fast the force grows when the
+	__s16 right_coeff;	/* Indicates how fast the force grows when the
 				   joystick moves to the right */
-	int16_t left_coeff;	/* Same for left side */
+	__s16 left_coeff;	/* Same for left side */
 
-	uint16_t deadband;	/* Size of area where no force is produced */
-	int16_t center;	/* Position of dead zone */
+	__u16 deadband;	/* Size of area where no force is produced */
+	__s16 center;	/* Position of dead zone */
 
 };
 
 /* FF_PERIODIC */
 struct ff_periodic_effect {
-	uint16_t waveform;	/* Kind of wave (sine, square...) */
-	uint16_t period;	/* in ms */
-	int16_t magnitude;	/* Peak value */
-	int16_t offset;	/* Mean value of wave (roughly) */
-	uint16_t phase;		/* 'Horizontal' shift */
+	__u16 waveform;	/* Kind of wave (sine, square...) */
+	__u16 period;	/* in ms */
+	__s16 magnitude;	/* Peak value */
+	__s16 offset;	/* Mean value of wave (roughly) */
+	__u16 phase;		/* 'Horizontal' shift */
 
 	struct ff_envelope envelope;
 
 /* Only used if waveform == FF_CUSTOM */
-	uint32_t custom_len;	/* Number of samples  */	
-	int16_t *custom_data;	/* Buffer of samples */
+	__u32 custom_len;	/* Number of samples  */	
+	__s16 *custom_data;	/* Buffer of samples */
 /* Note: the data pointed by custom_data is copied by the driver. You can
  * therefore dispose of the memory after the upload/update */
 };
@@ -677,22 +677,22 @@
    by the heavy motor.
 */
 struct ff_rumble_effect {
-	uint16_t strong_magnitude;  /* Magnitude of the heavy motor */
-	uint16_t weak_magnitude;    /* Magnitude of the light one */
+	__u16 strong_magnitude;  /* Magnitude of the heavy motor */
+	__u16 weak_magnitude;    /* Magnitude of the light one */
 };
 
 /*
  * Structure sent through ioctl from the application to the driver
  */
 struct ff_effect {
-	uint16_t type;
+	__u16 type;
 /* Following field denotes the unique id assigned to an effect.
  * If user sets if to -1, a new effect is created, and its id is returned in the same field
  * Else, the user sets it to the effect id it wants to update.
  */
-	int16_t id;
+	__s16 id;
 
-	uint16_t direction;	/* Direction. 0 deg -> 0x0000 (down)
+	__u16 direction;	/* Direction. 0 deg -> 0x0000 (down)
 					     90 deg -> 0x4000 (left)
 					    180 deg -> 0x8000 (up)
 					    270 deg -> 0xC000 (right)

===================================================================

This BitKeeper patch contains the following changesets:
1.533
## Wrapped with gzip_uu ##


begin 664 bkpatch24435
M'XL(`)P,1ST``[56V7+;.!!\%K]BJO*0:TV!IPZO4SFTF[ARN>S-LPLB(1$Q
M"2@$*-DN??P.`%*4;">I[&&[2.&8GIZ>!N1'\$6Q>CI8RZ^:987W"-Y)I:<#
MU2CF9[<X/I<2Q\-"5FS8[AK.KX9<K!KMX?H9U5D!:U:KZ2#PH]V,OEFQZ>#\
MC[=?/KPZ][R3$WA34+%D%TS#R8FG9;VF9:Y>4EV44OBZID)53%,_D]5VMW4;
M$A+B;Q*,(I*DVR`E\6B;!7D0T#A@.0GC<1I[?V+TK7_!Z_)E21O-ZCG-BH>0
M$`7?XR#91NF$1-X,`C^)(B#AD(R&$8$PFB;QE(R?DW!*"+05OVSU@.<!'!'O
M-?RW]-]X&9PSU%"#U=4O``NXPBQPQ6K!2JNF\KWW8&BGWEDOIG?TBS^>1RCQ
M7ORD!"ZRLLG9L.2BN1ZVK/;+F<3!-HWC8+Q=1.%\'$9INF"$43*^*]J/L$P_
M@B0FR3:()NG8^N3![3_WS+]@[/T:XR`*)A'9AO$HG%@'!<D]`R7?,U`<PE$<
M_B\6>BMWMKF\;(+TGGF<QI_AJ-[8/S3#V<-R_P-7S:($`N_4/A^UH/`[5=70
MY2]>>+,XAL@[C5-\#AQ%LW;<#3*9NX&*0D!Q&AS-4@*Q=YI&^&RWS1MU$+9F
M(I?U;KBJ9=YD>F^Y5EP*`S6"Q#L=!?@\3-*.*BYXU53]F%X?C!?-[6T_**DV
MF$$,(?)##X1=QI*)I2Z.8?@,9DU--68'N0`J@"T6+#.G'"KEPZNR!*D+5H/F
M%5-`:P:T5!+8]:IF2K'<[81GPPXZ9R6].08#_1?&F%YO*-<P9PM9VZ'2%.^1
M%6[C8KF7$S&0[,22#4E/=MYHC>J`Q?S45'.D@V3=-.B:+Y>LO@?5!G.!ERV*
M>/P]0GU0AA_G#&IVU&)B=4\J]=01"V/;Y7#4MYEJC6Z^;,4<W!73KNX0[L:L
M66E#/IA/.(VIEUP(4T<?W,<M:,Z^E\FLW<W3[K^7!9VX"[%UH5$"XU[S,L:Q
M[K!AX!2_T+5-:\*<4CY\8DO,OF;.GLX7G]^W@&/;P6CB.F@`;<=;-MT<$NEF
M9FF<V!@\=[NN8PL*?:FH;@NU#?Q(KQT[V!1,P%=YHS1'G;@"8X6"N;`]'4JV
M.$3Y(8SH8$R8*R<>6WWLJZ7NJ&42U;#BGHJ<9U2C#H7<H+1*6PRT5\9@6<N-
M<GEP$@$38@'M:R?X8A_O@E8VVK%0O&M5$EJ5DJA7*6<TGU.1NSA^RZQY:D9-
M1FR*D"T-5,A=.VAJIXY)G#%S/&SPF52\,Y1!A5LINKP3<RNE>,,E7=X-79OC
M4]G0]]R9RDS"$\4%^PW4MP9I^+Z_;\H5GE/IN.Y?&X9)19>":[R1'1E&KYRW
M]K;(Q4(Q;=<_,CRK;GV7MY;-LBAO#O(55"&@B7C\3M8<2]*T?`RJX%U[4^?6
MM'5K@^<@P]M;5N:PV5S]C:-HM2JQRQ@YZ$@]:W?G5%.[_76#9^1@N\TS)C;/
M..A[IW0MQ?*RK[SU9CLT$,9&!:/K&Z@D?AWOE;9!A0Y"'PXN[7'8=7+LS#QN
MS=Q_O\W22627[*NMC>=V(7$+21^3\QJO`7.<[%74C7P@:)TE'+T`<DWP!Y[D
=<B.>]O^%9P7+KE13G:0Q96F>Q=[?IV!"D>`+````
`
end

-- 
Vojtech Pavlik
SuSE Labs
