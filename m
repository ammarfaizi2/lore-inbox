Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSIWSP7>; Mon, 23 Sep 2002 14:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261288AbSIWSP7>; Mon, 23 Sep 2002 14:15:59 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:59583 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261286AbSIWSP4>; Mon, 23 Sep 2002 14:15:56 -0400
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: node affine NUMA scheduler: simple benchmark
Date: Mon, 23 Sep 2002 20:19:55 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <200209221030.32323.efocht@ess.nec.de> <78206124.1032689516@[10.10.2.3]>
In-Reply-To: <78206124.1032689516@[10.10.2.3]>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_7LLWHE2EB2RRQH1F9G5F"
Message-Id: <200209232019.55119.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_7LLWHE2EB2RRQH1F9G5F
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Here is a simple benchmark which is NUMA sensitive and simulates a simple
but normal situation in an environment running number crunching jobs. It
starts N independent tasks which access a large array in a random manner.
This is both bandwidth and latency sensitive. The output shows on which
node(s) the tasks have spent their lives. Additionally it shows (on a
NUMA scheduler kernel) the homenode (iSched).

Could you please run it on the virgin kernel and on the
"Both numasched patches, hack node IDs, alloc from current->node" one?

Maybe we see what's wrong...

Thanks,
Erich

--------------Boundary-00=_7LLWHE2EB2RRQH1F9G5F
Content-Type: application/x-shellscript;
  name="rand_updt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="rand_updt"

#!/bin/bash
#
# Small synthetic benchmark sensitive to both memory
# access latency and memory bandwidth. The perl script
# starts NTASKS processes in parallel which access their
# memory following a random pattern.
#
# This benchmark is thought as test for the capability of
# ccNUMA platforms to provide minimum memory access latency
# and maximize the memory bandwidth available for the
# processes in parallel. The table printed after all NTASKS
# processes finished to run shows the percentage of time
# spent by the "jobs" on each node. It also outputs the
# node on which the job was initially scheduled and the node on
# which the job spent most of its time (iSched, MSched). If
# these are different, an asterisc is printed.
# Ideally most of the time should be spent on the node where the
# memory is allocated.
#
# Copyright 2001, Erich Focht <efocht@ess.nec.de>
#

if [ $# != "1" ]; then
  echo "$#"
  echo "Usage: $0 NTASKS"
  exit 1
fi

NTASKS=$1
PROBLEMSIZE=1000000
tmpdir=rupdt_$$

####################
if [ ! -f cpu_to_node ]; then
  echo "Please create a file called cpu_to_node in the current directory!"
  echo "It must contain the node numbers for each logical CPU in the system,"
  echo "separated by blanks. For example: 4 nodes of 4 cpus each could"
  echo "look like:"
  echo "echo \"0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3\" >cpu_to_node"
  exit 1
fi
mkdir $tmpdir || { echo "Could not create run directory!"; exit 1; }
cd $tmpdir
cp ../cpu_to_node .

uudecode << 'UUU_EOF'
begin 644 randupdt.c.bz2
M0EIH.3%!629368@X[W<``4S?@%`0>__U7S^GWDZ__]_Z4`/\]Y>TGB=1K3KP
M2A(4]3TF1IH]09J-IE-E!IH`T-`>F4:`-3U(Q3R#2>AJGJ9-`/4``&0:```&
MFA3"";2I[0$TF0](T`R`/2:&U!Z0`D20HT/4P0T]0&C0R````!H--!*:B--,
MDIZ>FC4GZ*>4\IZGJ/4;*``-J&@!II))%0&,-6,;E$!GQ#;&AADS532E#<)S
M-&E(@;%<,YL_NB/N>BFE04LN*>DH21.Q)$Z2(N',`9MARV$L#ER3U:JP.:GJ
M>._6O(N@6:WST8K*P/>8]J_?GK&]]*-H;A?ADLQOGSV/$?;BKS26"U7-P=+S
MDD*B&`X0=DLK@3-M?&\!&V<IU$Q&#L($G+*-'@<T8'^UU6M?$;\CSB/L+BV?
M]Q#PJ"`+NC<*P2P$*0=$A@Q@)#0Z,X?9LQP-A-,%4*@124RB`2&JP:4JJHBE
M+!W7PPU0ZO5^<HUZ17?ZQ@&;M,LX>DEK[GLK=ZY;0SLFHC41'$"$$A#D$`0#
MDS+1/N'UA\HLPF1<;L3?JIUJVQ%P&]!\'5K'-P2R"58PXZ)<E;YQDU[U6::&
MWCG>^H/$G2.;EI0HP4\%VAO%X*;MCR74L7E5-+!,V+K&(IFU,!@4'>+$F!&5
M?+4^[D@R1(TF[BK%`*L-MH4`?#PWVU"#/I=8[;VP.HA@F""NJY?D;049#W%2
MH?3,BZ30/E8R/CV4J8I'6C5IK6P</BM8D!EB_)%59;XN)649!O6>A5PXC!CF
MY.-Z[J%*D#,DY+I/(-I3-S>!DX9>G#W*.L6$:K=^!$1Z2,@XV'5TH*KRW0U'
M=,O)(LM?S$C=.;'=B%O<!<XQF2C)+LZW4[V#M5G1Q<R.&SBP#Z]`[-$F&<RB
MJO%8/_=#Z/&.(PSPJ.LO#F#^$&FD+!UT['S38@41TT7T&AT"$2$/^DK(T@)3
MFV$1;C8(C8D`MT.NDL,^R;.LI$$3OVPREP14&5Q>SS,4K.)P6FD>/(>B1N-`
M&!L.<I2223=H+FU8XO;;;E74#V.Q8$VQ.<7#N($;YY32B=;;Y.WY)"VA0V!1
MA44%C6T"1-WL'7'31<$1'@C(`>O.(7);<;,=HW("<7&BRT"UF1&602:INX-H
M=N^NQ[5DQ-65=C#VH[9`X"'@/$*A!#^3-K$>:K@)"5J7*W+&R=H@B(0NG%\<
MP(^6@(MGX!&53;6FB2;H:@@2M-=Q7+B@[PICS4!?4A%XF'&-LFBM^\ID7BVZ
M<\2`W3%@W9'$\305*#UWI0PR$)/?-$,%HNM54"-"AP(9:NL:HUCOSBDE):]!
M.112($S/9ZNQTL4:5$@Z)!8ZXG.!<:@O@1-7K'"LN-\MD6'KYM"3-2PRS9KT
4!@59-YB;54(?^+N2*<*$A$''>[@`
`
end
UUU_EOF
bzip2 -d randupdt.c.bz2
gcc -O3 -o randupdt randupdt.c


############################
cat >print_hz.c <<EOF
#include <asm/param.h>
int main(){ printf("%d\n",HZ);}
EOF
gcc -o print_hz print_hz.c

############################
uudecode << 'UUU_EOF'
begin 644 dispatch.bz2
M0EIH.3%!629364BQHA<``:C?@&!\?O_[/^_SWQ^_____8`8\^O=UYO9=JK=R
M:][=&6M=:X--(*:933T$T],J>:FGHF*/4S4])HTR,GJ8(PRCQ1D]!*":%,"I
MZFVD1A`T/4-&@`-!H``!HT#0T2H9J/4!B#0``:&)D`&@`#0`$B(B:)-/)DU-
M-&$9J!H`TR#(:!ZFF@`/4'#0R::&F1H:9&09&1H9`8FC)H`R9&(82(DU-,1,
M1I3]HBGY"GE/4#(\H,@`#1H;4!II:A&5H18DD?S:;3?(\M#6)7!B/MS131?(
M3;9,Q+8P@:;#8<)C9+$P9#1S7_O-WXNN96EL0YK1A*B9A@2RE/IH4+!Q;&JD
M!I$@"MK1JD.&V0S/,3$-):>,UZV:+;VEGND.?CY;G@K$U.M$2B058DY6,^+M
M%MS;\`?*C2'N7"[-Z8L,P$,D^=EBE.]`2EBN-R6R-90@AI2R^T1$<OB-I-X-
M<F`7G;`OT!\`S7X;.[7QY_/X93TZ>#TLGV+3D)AE+)-G708RLK*3'.*255;K
MG_YX4YEIQP*QF-.4BAWPB%P7O!T50JW&VQ&?^;SNZ[.Q+%0XRYD5;%FIFM:"
MN?0]NI8GL<AI+N9GO8N7HST68H%97T8K0;!MB.8UBO/$!5`V;/]O=FDJ[I]M
MGQS!?T>W9MMRCM2ZZ#.22ILJ'.^9EC:7<-9WWAOB8,&G'#!+#BAPN&:V/P#J
MZ.JTZ3!$*6;#FRE)UZZF:I.MR(S+!"CM(!V1PK!W8I)LPKJC"EE&*BK51A7:
M%G.CR6G`U(;BOFZEESH6%+TD1!7CC797Q0,QP;H8([-D)'71X8%17%XY+'-Q
M&*&0KF]N_`K"A<-/NOP0T_DJ95PP?QQZU$%$6:.J'45DT^182?59"W#`U/EA
MW\$=;&!M#P],N!R[?&\X"R;L7TG0`A'B?Z]C:8B&`".*.6X^;[7>.XCF12%B
M7\*W=EW&W!DF3>XH'U"KPMMY6"SJM0GLZ)`JS6$I5T=&*2*RE!$$LUVXDEX6
MYP%!+\+PP;KU-N%A*5GEK!9,K:/O4VS/&ST=-@WXQNENR&+RK3?`C/N/+0&?
M7)G6;:41-M54;;0VA66<A:9(I4=[#2B+GM6[W.>K-=K*9M]TB()B63\5/>\Q
M\FVJZHM4Q@*/?!U!FJH,\ZR4/!`JZ`F=&IG`:)=7BSC)UI"P3G2!J09.CIQJ
MBGA)R\IA^?%96I^\6+BZ6:6A6IR`1Z!8%%NO6`#`#7FT!Z+R!M?8)+1"SWJ$
M!G,[%+R'$RDH;`SC.MF<]`G=_BM\97W3`@D\3DL8[VLWFH=29-)RTPR:QBQ4
MG(VVQO&UBK(^"2/=,4]!8HI"BQ&HA2T"R,AX6'?IPONDPM)I"5BF"^R:$M*$
M\?1";&-.C(9@"+DF@*(,@ZAF3*>Z4$*2V(@L*G0+YLPP!-A<U%[U0N)>4SRM
M54PR?"*&<B93A,<+E9-9V>:Y519A67X:VW(6=C5XBUFUD2%U+MRRL?,GRAOX
M.60R,2>E&P;FY@V49!F'9:1"EWV2]&$*:]5>3VG951:3$LDJ02EL(TZL?E>!
M,$!P+P/3F8UNYZ\*\Z1*JSLFHM`<:"Q@56D'U&VU';S*;L`O_#"$<#6R`)MQ
M.*1W!PXGGC?P0V%+D%Y?N1/,9%X52T@N2_<N151)!02\L4->0U)B6VS,19CL
MS,<8A:Y0A1%LLE2R$"X40A1'*37'3#C9)O95./:LK2'!!TQ(:['<%M%"5S,S
M0=MAJ!H_R$8@XM8P[S2$;=Q;U5I2SI&8S..H%6@CFWO,&'%WY+3JH5(-[]:(
MLR[M@;-F*-I2J+K2P.DXSI,2LRA5BH^L0LS(1)3O+;D.2^E+8#230L2CA&/;
MTVL+>5GJM0%TM,@-S(FQK1/<^QHT#S,.@H,[E3/XQ0856!6FX.$*F0*#BDJ)
M#NB$/-*Y`7BU:[MF7<D\<W#3DLR9'ZHE$VBEXN#?<*`*Z@349D=:!>5K!J*T
M*M29M`DNXN!R[X)@Q+)T)&PSQJZIROZHT2:DR.AZ*`VQEAT,@38<YC407S4&
FPW;1ID[U*P\"S8S,IA49.5;9$0N6,Q,-O.C_B[DBG"A()%C1"X``
`
end
UUU_EOF
bzip2 -d dispatch.bz2
chmod +x dispatch

################
# Run the tests!
################
'time' --format="ElapsedTime     %e\nTotalUserTime   %U\nTotalSysTime    %S\n" \
   ./dispatch $NTASKS ./randupdt $PROBLEMSIZE

cd ..
rm -rf $tmpdir

--------------Boundary-00=_7LLWHE2EB2RRQH1F9G5F--

