Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129244AbQJ3LRO>; Mon, 30 Oct 2000 06:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129410AbQJ3LRE>; Mon, 30 Oct 2000 06:17:04 -0500
Received: from oe58.law11.hotmail.com ([64.4.16.193]:54535 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129244AbQJ3LQ2>;
	Mon, 30 Oct 2000 06:16:28 -0500
X-Originating-IP: [24.164.154.68]
From: "Linux Kernel Developer" <linux_developer@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Need info on the use of certain datastructures and the first C++ keyword patch for 2.2.17
Date: Mon, 30 Oct 2000 06:09:49 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Message-ID: <OE58erOc0Ne0PaLI9mK000004a6@hotmail.com>
X-OriginalArrivalTime: 30 Oct 2000 11:16:21.0888 (UTC) FILETIME=[D5483000:01C04262]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

    After a delay on some other project I've again started up the process of
fixing up the Linux headers, i.e. removing the use of C++ keywords as
variable and stuff.  I have questions on the use of three datastructures
which happen to use the C++ keyword new but first a couple of things.

    First thing.  Some had commented on my previous post that this did not
belong on the Linux kernel mailing list.  I disagree with that assertion.
The goal of this project is to clean up the kernel headers so as they are
useable/compatible with those who wish to program their kernel modules in
C++.  It is not my goal to rewrite the kernel in C++ or anything like that,
merely to give those interested the option to program their modules in C++.
In order to accomplish this goal I may occasionally need to ask the various
kernel gods on this list whether changing a particular variable or structure
member name would cause a problem as I am also doing in this post.  The
other reason I am posting, occasionally, on this list is to hopefully get
eyeballs and testers, from among those whom are most intimately familiar
with the kernel, to tryout my latest patch.  And as a final note to some of
those whom responded negatively to my previous post I did not start the
previous flame war nor did I post a ton of messages.  My previous posts on
the subject totaled 1 before I accepted someone's challenge to fix the
headers myself and since then I've only posted twice once to announce the
project and once with a script that would allow those interested to update
their header files with the 'extern "C" {}' compile conditional wrappers as
the starting point of the project.  Any future posts will be limited to more
header fixes and/or questions on certain pieces of code I am looking to
modify.  If and when I decide to start experimental kernel C++ projects such
as perhaps a generic virtual device driver classes that can be inheritable,
which by the way is not even near to my current goal, I will take those off
this list unless a question is required on the use of a particular data
structure or interface.  And before the flames begin again I restate my
current goal is to fix the headers so they are useable in C++ and nothing
more.

    Ok now the second thing I wish to announce in this post is that the
included C++ compatible header fixing patch fixes most references of the C++
keyword of "new" in the header files.  The following files have been
updated.  A couple of C files had to be updated as well due to parameters,
defined in the header files, being called "new".  All of these were
straightforward fixes and should be correct, testing is welcome.

include/linux/arch/mips/kernel/irq.c
include/linux/include/asm-mips/irq.h
include/linux/include/asm-mips/mipsregs.h
include/linux/include/Linux/hdlcdrv.h
include/linux/include/Linux/list.h
include/linux/include/Linux/lists.h
include/linux/include/net/neighbour.h
include/linux/net/core/neighbour.c

    Ok now on to the questions I have.  In include/linux/joystick.h,
include/linux/raid5.h, and include/linux/adfs_fs.h I've found members of
structures and a union which were called "new".  The datastructures in
question are union adfs_dirtail::new, struct stripe_head::new, struct
js_dev::new.  My questions are basically this.  If I update these data
structure members' names along with the references to them in various C
files in the kernel will all be happy in Linuxland.  Can any external
utilities be broken or anything like that.  Or more precisely are there any
known external utilities that would be broken by this change?  Thanks to all
those whom can give me a hand in this.

- A. B.


begin 666 c++-0.0.1.patch
M9&EF9B M<B M=2!L:6YU>"TR+C(N,3<N;W)G+V%R8V@O;6EP<R]K97)N96PO
M:7)Q+F,@;&EN=7@O87)C:"]M:7!S+VME<FYE;"]I<G$N8PHM+2T@;&EN=7@M
M,BXR+C$W+F]R9R]A<F-H+VUI<',O:V5R;F5L+VER<2YC"5=E9"!-87D@(#,@
M,C Z,38Z,S$@,C P, HK*RL@;&EN=7@O87)C:"]M:7!S+VME<FYE;"]I<G$N
M8PE-;VX@3V-T(#,P(# Q.C(X.C(W(#(P,# *0$ @+3(Q-"PW("LR,30L-R! 
M0 H@"2\J('5N;6%S:VEN9R!A;F0@8F]T=&]M(&AA;&8@:&%N9&QI;F<@:7,@
M9&]N92!M86=I8V%L;'D@9F]R('5S+B J+PH@?0H@"BUI;G0@:3@R-3E?<V5T
M=7!?:7)Q*&EN="!I<G$L('-T<G5C="!I<G%A8W1I;VX@*B!N97<I"BMI;G0@
M:3@R-3E?<V5T=7!?:7)Q*&EN="!I<G$L('-T<G5C="!I<G%A8W1I;VX@*B!N
M97=?86-T:6]N*0H@>PH@"6EN="!S:&%R960@/2 P.PH@"7-T<G5C="!I<G%A
M8W1I;VX@*F]L9"P@*BIP.PI 0" M,C(S+#$Q("LR,C,L,3$@0$ *( EP(#T@
M:7)Q7V%C=&EO;B K(&ER<3L*( EI9B H*&]L9" ]("IP*2 A/2!.54Q,*2![
M"B )"2\J($-A;B=T('-H87)E(&EN=&5R<G5P=',@=6YL97-S(&)O=&@@86=R
M964@=&\@*B\*+0D):68@*"$H;VQD+3YF;&%G<R F(&YE=RT^9FQA9W,@)B!3
M05]32$E242DI"BL)"6EF("@A*&]L9"T^9FQA9W,@)B!N97=?86-T:6]N+3YF
M;&%G<R F(%-!7U-(25)1*2D*( D)"7)E='5R;B M14)54UD["B *( D)+RH@
M0V%N)W0@<VAA<F4@:6YT97)R=7!T<R!U;FQE<W,@8F]T:"!A<F4@<V%M92!T
M>7!E("HO"BT)"6EF("@H;VQD+3YF;&%G<R!>(&YE=RT^9FQA9W,I("8@4T%?
M24Y415)255!4*0HK"0EI9B H*&]L9"T^9FQA9W,@7B!N97=?86-T:6]N+3YF
M;&%G<RD@)B!305])3E1%4E)54%0I"B )"0ER971U<FX@+45"55-9.PH@"B )
M"2\J(&%D9"!N97<@:6YT97)R=7!T(&%T(&5N9"!O9B!I<G$@<75E=64@*B\*
M0$ @+3(S."PQ,2 K,C,X+#$Q($! "B )"7-H87)E9" ](#$["B )?0H@"BT)
M:68@*&YE=RT^9FQA9W,@)B!305]304U03$5?4D%.1$]-*0HK"6EF("AN97=?
M86-T:6]N+3YF;&%G<R F(%-!7U-!35!,15]204Y$3TTI"B )"7)A;F1?:6YI
M=&EA;&EZ95]I<G$H:7)Q*3L*( H@"7-A=F5?86YD7V-L:2AF;&%G<RD["BT)
M*G @/2!N97<["BL)*G @/2!N97=?86-T:6]N.PH@"B ):68@*"%S:&%R960I
M('L*( D)=6YM87-K7VER<2AI<G$I.PID:69F("UR("UU(&QI;G5X+3(N,BXQ
M-RYO<F<O:6YC;'5D92]A<VTM;6EP<R]I<G$N:"!L:6YU>"]I;F-L=61E+V%S
M;2UM:7!S+VER<2YH"BTM+2!L:6YU>"TR+C(N,3<N;W)G+VEN8VQU9&4O87-M
M+6UI<',O:7)Q+F@)36]N($%U9R @.2 Q-3HP-#HT,2 Q.3DY"BLK*R!L:6YU
M>"]I;F-L=61E+V%S;2UM:7!S+VER<2YH"4UO;B!/8W0@,S @,#$Z,C@Z,C<@
M,C P, I 0" M,3<L-R K,3<L-R! 0 H@97AT97)N(&EN=" H*FER<5]C86YN
M;VYI8V%L:7IE*2AI;G0@:7)Q*3L*( H@<W1R=6-T(&ER<6%C=&EO;CL*+65X
M=&5R;B!I;G0@:3@R-3E?<V5T=7!?:7)Q*&EN="!I<G$L('-T<G5C="!I<G%A
M8W1I;VX@*B!N97<I.PHK97AT97)N(&EN="!I.#(U.5]S971U<%]I<G$H:6YT
M(&ER<2P@<W1R=6-T(&ER<6%C=&EO;B J(&YE=U]A8W1I;VXI.PH@97AT97)N
M('9O:60@9&ES86)L95]I<G$H=6YS:6=N960@:6YT*3L*(&5X=&5R;B!V;VED
M(&5N86)L95]I<G$H=6YS:6=N960@:6YT*3L*( ID:69F("UR("UU(&QI;G5X
M+3(N,BXQ-RYO<F<O:6YC;'5D92]A<VTM;6EP<R]M:7!S<F5G<RYH(&QI;G5X
M+VEN8VQU9&4O87-M+6UI<',O;6EP<W)E9W,N: HM+2T@;&EN=7@M,BXR+C$W
M+F]R9R]I;F-L=61E+V%S;2UM:7!S+VUI<'-R96=S+F@)36]N($%U9R @.2 Q
M-3HP-#HT,2 Q.3DY"BLK*R!L:6YU>"]I;F-L=61E+V%S;2UM:7!S+VUI<'-R
M96=S+F@)36]N($]C=" S," P,3HR.#HR-R R,# P"D! ("TQ-C$L,3,@*S$V
M,2PQ,R! 0 H@("HO"B C9&5F:6YE(%]?0E5)3$1?4T547T-0,"AN86UE+')E
M9VES=&5R*2 @(" @(" @(" @(" @(" @(" @(" @(" @7 H@97AT97)N(%]?
M:6YL:6YE7U\@=6YS:6=N960@:6YT(" @(" @(" @(" @(" @(" @(" @(" @
M(" @(" @(" @(%P*+7-E=%]C<#!?(R-N86UE*'5N<VEG;F5D(&EN="!C:&%N
M9V4L('5N<VEG;F5D(&EN="!N97<I(" @(" @(" @("!<"BMS971?8W P7R,C
M;F%M92AU;G-I9VYE9"!I;G0@8VAA;F=E+"!U;G-I9VYE9"!I;G0@;&M?;F5W
M*2 @(" @(" @(" @7 H@>R @(" @(" @(" @(" @(" @(" @(" @(" @(" @
M(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @(%P*( EU;G-I9VYE
M9"!I;G0@<F5S.R @(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @
M(" @(%P*(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @
M(" @(" @(" @(" @(" @(" @(" @(" @("!<"B )<F5S(#T@<F5A9%\S,F)I
M=%]C<#!?<F5G:7-T97(H<F5G:7-T97(I.R @(" @(" @(" @(" @("!<"B )
M<F5S("8]('YC:&%N9V4[(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @
M(" @(" @(" @("!<"BT)<F5S('P]("AN97<@)B!C:&%N9V4I.R @(" @(" @
M(" @(" @(" @(" @(" @(" @(" @(" @("!<"BL)<F5S('P]("AL:U]N97<@
M)B!C:&%N9V4I.R @(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @("!<
M"B ):68H8VAA;F=E*2 @(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @
M(" @(" @(" @(" @("!<"B )"7=R:71E7S,R8FET7V-P,%]R96=I<W1E<BAR
M96=I<W1E<BP@<F5S*3L@(" @(" @(%P*(" @(" @(" @(" @(" @(" @(" @
M(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @(" @("!<
M"F1I9F8@+7(@+74@;&EN=7@M,BXR+C$W+F]R9R]I;F-L=61E+VQI;G5X+VAD
M;&-D<G8N:"!L:6YU>"]I;F-L=61E+VQI;G5X+VAD;&-D<G8N: HM+2T@;&EN
M=7@M,BXR+C$W+F]R9R]I;F-L=61E+VQI;G5X+VAD;&-D<G8N: E3=6X@2G5N
M(" W(#$T.C$S.C0U(#$Y.3@**RLK(&QI;G5X+VEN8VQU9&4O;&EN=7@O:&1L
M8V1R=BYH"4UO;B!/8W0@,S @,#$Z,C@Z,C8@,C P, I 0" M,3,V+#$R("LQ
M,S8L,3(@0$ *(&5X=&5R;B!I;FQI;F4@=F]I9"!H9&QC9')V7V%D9%]B:71B
M=69F97(H<W1R=6-T(&AD;&-D<G9?8FET8G5F9F5R("IB=68L( H@"0D)"0D@
M=6YS:6=N960@:6YT(&)I="D*('L*+0EU;G-I9VYE9"!C:&%R(&YE=SL**PEU
M;G-I9VYE9"!C:&%R(&ES7VYE=SL*( HM"6YE=R ](&)U9BT^<VAR96<@)B Q
M.PHK"6ES7VYE=R ](&)U9BT^<VAR96<@)B Q.PH@"6)U9BT^<VAR96<@/CX]
M(#$["B )8G5F+3YS:')E9R!\/2 H(2%B:70I(#P\(#<["BT):68@*&YE=RD@
M>PHK"6EF("AI<U]N97<I('L*( D)8G5F+3YB=69F97);8G5F+3YW<ET@/2!B
M=68M/G-H<F5G.PH@"0EB=68M/G=R(#T@*&)U9BT^=W(K,2D@)2!S:7IE;V8H
M8G5F+3YB=69F97(I.PH@"0EB=68M/G-H<F5G(#T@,'@X,#L*9&EF9B M<B M
M=2!L:6YU>"TR+C(N,3<N;W)G+VEN8VQU9&4O;&EN=7@O;&ES="YH(&QI;G5X
M+VEN8VQU9&4O;&EN=7@O;&ES="YH"BTM+2!L:6YU>"TR+C(N,3<N;W)G+VEN
M8VQU9&4O;&EN=7@O;&ES="YH"4UO;B!$96,@(#$@,30Z,38Z-3<@,3DY-PHK
M*RL@;&EN=7@O:6YC;'5D92]L:6YU>"]L:7-T+F@)36]N($]C=" S," P,3HR
M.#HR-B R,# P"D! ("TS,"PR,B K,S L,C(@0$ *(" J(%1H:7,@:7,@;VYL
M>2!F;W(@:6YT97)N86P@;&ES="!M86YI<'5L871I;VX@=VAE<F4@=V4@:VYO
M=PH@("H@=&AE('!R978O;F5X="!E;G1R:65S(&%L<F5A9'DA"B @*B\*+7-T
M871I8R!?7VEN;&EN95]?('9O:60@7U]L:7-T7V%D9"AS=')U8W0@;&ES=%]H
M96%D("H@;F5W+ HK<W1A=&EC(%]?:6YL:6YE7U\@=F]I9"!?7VQI<W1?861D
M*'-T<G5C="!L:7-T7VAE860@*B!N97=?;F]D92P*( ES=')U8W0@;&ES=%]H
M96%D("H@<')E=BP*( ES=')U8W0@;&ES=%]H96%D("H@;F5X="D*('L*+0EN
M97AT+3YP<F5V(#T@;F5W.PHM"6YE=RT^;F5X=" ](&YE>'0["BT);F5W+3YP
M<F5V(#T@<')E=CL*+0EP<F5V+3YN97AT(#T@;F5W.PHK"6YE>'0M/G!R978@
M/2!N97=?;F]D93L**PEN97=?;F]D92T^;F5X=" ](&YE>'0["BL);F5W7VYO
M9&4M/G!R978@/2!P<F5V.PHK"7!R978M/FYE>'0@/2!N97=?;F]D93L*('T*
M( H@+RH*(" J($EN<V5R="!A(&YE=R!E;G1R>2!A9G1E<B!T:&4@<W!E8VEF
M:65D(&AE860N+@H@("HO"BUS=&%T:6,@7U]I;FQI;F5?7R!V;VED(&QI<W1?
M861D*'-T<G5C="!L:7-T7VAE860@*FYE=RP@<W1R=6-T(&QI<W1?:&5A9" J
M:&5A9"D**W-T871I8R!?7VEN;&EN95]?('9O:60@;&ES=%]A9&0H<W1R=6-T
M(&QI<W1?:&5A9" J;F5W7VYO9&4L('-T<G5C="!L:7-T7VAE860@*FAE860I
M"B!["BT)7U]L:7-T7V%D9"AN97<L(&AE860L(&AE860M/FYE>'0I.PHK"5]?
M;&ES=%]A9&0H;F5W7VYO9&4L(&AE860L(&AE860M/FYE>'0I.PH@?0H@"B O
M*@ID:69F("UR("UU(&QI;G5X+3(N,BXQ-RYO<F<O:6YC;'5D92]L:6YU>"]L
M:7-T<RYH(&QI;G5X+VEN8VQU9&4O;&EN=7@O;&ES=',N: HM+2T@;&EN=7@M
M,BXR+C$W+F]R9R]I;F-L=61E+VQI;G5X+VQI<W1S+F@)36]N($UA<B S," P
M,SHR,3HT,2 Q.3DX"BLK*R!L:6YU>"]I;F-L=61E+VQI;G5X+VQI<W1S+F@)
M36]N($]C=" S," P,3HR.#HR-B R,# P"D! ("TQ."PQ." K,3@L,3@@0$ *
M("-D969I;F4@1$Q)4U1?3D585"AL:7-T;F%M*0EL:7-T;F%M+F1L7VYE>'0*
M("-D969I;F4@1$Q)4U1?4%)%5BAL:7-T;F%M*0EL:7-T;F%M+F1L7W!R978*
M( HM(V1E9FEN92!$3$E35%])3E-%4E1?049415(H;F]D92P@;F5W+"!L:7-T
M;F%M*0ED;R!["0E<"BT)*&YE=RDM/FQI<W1N86TN9&Q?<')E=B ]("AN;V1E
M*3L)"0E<"BT)*&YE=RDM/FQI<W1N86TN9&Q?;F5X=" ]("AN;V1E*2T^;&ES
M=&YA;2YD;%]N97AT.PE<"BT)*&YO9&4I+3YL:7-T;F%M+F1L7VYE>'0M/FQI
M<W1N86TN9&Q?<')E=B ]("AN97<I.PE<"BT)*&YO9&4I+3YL:7-T;F%M+F1L
M7VYE>'0@/2 H;F5W*3L)"0E<"BLC9&5F:6YE($1,25-47TE.4T525%]!1E1%
M4BAN;V1E+"!N97=?;F]D92P@;&ES=&YA;2D)9&\@>PD)7 HK"2AN97=?;F]D
M92DM/FQI<W1N86TN9&Q?<')E=B ]("AN;V1E*3L)"0E<"BL)*&YE=U]N;V1E
M*2T^;&ES=&YA;2YD;%]N97AT(#T@*&YO9&4I+3YL:7-T;F%M+F1L7VYE>'0[
M"5P**PDH;F]D92DM/FQI<W1N86TN9&Q?;F5X="T^;&ES=&YA;2YD;%]P<F5V
M(#T@*&YE=U]N;V1E*3L)7 HK"2AN;V1E*2T^;&ES=&YA;2YD;%]N97AT(#T@
M*&YE=U]N;V1E*3L)"0E<"B )?2!W:&EL92 H,"D*( HM(V1E9FEN92!$3$E3
M5%])3E-%4E1?0D5&3U)%*&YO9&4L(&YE=RP@;&ES=&YA;2D)9&\@>PD)7 HM
M"2AN97<I+3YL:7-T;F%M+F1L7VYE>'0@/2 H;F]D92D["0D)7 HM"2AN97<I
M+3YL:7-T;F%M+F1L7W!R978@/2 H;F]D92DM/FQI<W1N86TN9&Q?<')E=CL)
M7 HM"2AN;V1E*2T^;&ES=&YA;2YD;%]P<F5V+3YL:7-T;F%M+F1L7VYE>'0@
M/2 H;F5W*3L)7 HM"2AN;V1E*2T^;&ES=&YA;2YD;%]P<F5V(#T@*&YE=RD[
M"0D)7 HK(V1E9FEN92!$3$E35%])3E-%4E1?0D5&3U)%*&YO9&4L(&YE=U]N
M;V1E+"!L:7-T;F%M*0ED;R!["0E<"BL)*&YE=U]N;V1E*2T^;&ES=&YA;2YD
M;%]N97AT(#T@*&YO9&4I.PD)"5P**PDH;F5W7VYO9&4I+3YL:7-T;F%M+F1L
M7W!R978@/2 H;F]D92DM/FQI<W1N86TN9&Q?<')E=CL)7 HK"2AN;V1E*2T^
M;&ES=&YA;2YD;%]P<F5V+3YL:7-T;F%M+F1L7VYE>'0@/2 H;F5W7VYO9&4I
M.PE<"BL)*&YO9&4I+3YL:7-T;F%M+F1L7W!R978@/2 H;F5W7VYO9&4I.PD)
M"5P*( E]('=H:6QE("@P*0H@"B C9&5F:6YE($1,25-47T1%3$5412AN;V1E
M+"!L:7-T;F%M*0ED;R!["0E<"D! ("TU,BPQ,2 K-3(L,3$@0$ *( DH*%%5
M155%7T9)4E-4*&AE860L(&QI<W1N86TI(#T](%%5155%7TQ!4U0H:&5A9"P@
M;&ES=&YA;2DI("8F(%P*( D@*"AU7VQO;F<I455%545?1DE24U0H:&5A9"P@
M;&ES=&YA;2D@/3T@*'5?;&]N9REH96%D*2D@"B *+2-D969I;F4@455%545?
M14Y415(H:&5A9"P@;F5W+"!L:7-T;F%M+"!P='EP92D@9&\@>PD)7 HM"2AN
M97<I+3YL:7-T;F%M+F1L7W!R978@/2 H<'1Y<&4I*&AE860I.PD)"5P*+0DH
M;F5W*2T^;&ES=&YA;2YD;%]N97AT(#T@*&AE860I+3YL:7-T;F%M+F1L7VYE
M>'0["5P*+0DH:&5A9"DM/FQI<W1N86TN9&Q?;F5X="T^;&ES=&YA;2YD;%]P
M<F5V(#T@*&YE=RD["5P*+0DH:&5A9"DM/FQI<W1N86TN9&Q?;F5X=" ]("AN
M97<I.PD)"5P**R-D969I;F4@455%545?14Y415(H:&5A9"P@;F5W7VYO9&4L
M(&QI<W1N86TL('!T>7!E*2!D;R!["0E<"BL)*&YE=U]N;V1E*2T^;&ES=&YA
M;2YD;%]P<F5V(#T@*'!T>7!E*2AH96%D*3L)"0E<"BL)*&YE=U]N;V1E*2T^
M;&ES=&YA;2YD;%]N97AT(#T@*&AE860I+3YL:7-T;F%M+F1L7VYE>'0["5P*
M*PDH:&5A9"DM/FQI<W1N86TN9&Q?;F5X="T^;&ES=&YA;2YD;%]P<F5V(#T@
M*&YE=U]N;V1E*3L)7 HK"2AH96%D*2T^;&ES=&YA;2YD;%]N97AT(#T@*&YE
M=U]N;V1E*3L)"0E<"B )?2!W:&EL92 H,"D*( H@(V1E9FEN92!1545515]2
M14U/5D4H:&5A9"P@;F]D92P@;&ES=&YA;2D@1$Q)4U1?1$5,151%*&YO9&4L
M(&QI<W1N86TI"F1I9F8@+7(@+74@;&EN=7@M,BXR+C$W+F]R9R]I;F-L=61E
M+VYE="]N96EG:&)O=7(N:"!L:6YU>"]I;F-L=61E+VYE="]N96EG:&)O=7(N
M: HM+2T@;&EN=7@M,BXR+C$W+F]R9R]I;F-L=61E+VYE="]N96EG:&)O=7(N
M: E4=64@36%Y(#$Q(#$S.C,V.C,X(#$Y.3D**RLK(&QI;G5X+VEN8VQU9&4O
M;F5T+VYE:6=H8F]U<BYH"4UO;B!/8W0@,S @,#$Z,C@Z,C<@,C P, I 0" M
M,3<P+#<@*S$W,"PW($! "B )"0D)"2 @(" @("!I;G0@8W)E870I.PH@97AT
M97)N('9O:60)"0EN96EG:%]D97-T<F]Y*'-T<G5C="!N96EG:&)O=7(@*FYE
M:6=H*3L*(&5X=&5R;B!I;G0)"0E?7VYE:6=H7V5V96YT7W-E;F0H<W1R=6-T
M(&YE:6=H8F]U<B J;F5I9V@L('-T<G5C="!S:U]B=69F("IS:V(I.PHM97AT
M97)N(&EN= D)"6YE:6=H7W5P9&%T92AS=')U8W0@;F5I9VAB;W5R("IN96EG
M:"P@=3@@*FQL861D<BP@=3@@;F5W+"!I;G0@;W9E<G)I9&4L(&EN="!A<G I
M.PHK97AT97)N(&EN= D)"6YE:6=H7W5P9&%T92AS=')U8W0@;F5I9VAB;W5R
M("IN96EG:"P@=3@@*FQL861D<BP@=3@@;F5W7W-T871E+"!I;G0@;W9E<G)I
M9&4L(&EN="!A<G I.PH@97AT97)N(&EN= D)"6YE:6=H7VEF9&]W;BAS=')U
M8W0@;F5I9VA?=&%B;&4@*G1B;"P@<W1R=6-T(&1E=FEC92 J9&5V*3L*(&5X
M=&5R;B!I;G0)"0EN96EG:%]R97-O;'9E7V]U='!U="AS=')U8W0@<VM?8G5F
M9B J<VMB*3L*(&5X=&5R;B!I;G0)"0EN96EG:%]C;VYN96-T961?;W5T<'5T
M*'-T<G5C="!S:U]B=69F("IS:V(I.PID:69F("UR("UU(&QI;G5X+3(N,BXQ
M-RYO<F<O;F5T+V-O<F4O;F5I9VAB;W5R+F,@;&EN=7@O;F5T+V-O<F4O;F5I
M9VAB;W5R+F,*+2TM(&QI;G5X+3(N,BXQ-RYO<F<O;F5T+V-O<F4O;F5I9VAB
M;W5R+F,)36]N($%U9R @.2 Q-3HP-#HT,2 Q.3DY"BLK*R!L:6YU>"]N970O
M8V]R92]N96EG:&)O=7(N8PE-;VX@3V-T(#,P(# Q.C(X.C(W(#(P,# *0$ @
M+38V,"PQ,B K-C8P+#$R($! "B *("\J($=E;F5R:6,@=7!D871E(')O=71I
M;F4N"B @(" M+2!L;&%D9'(@:7,@;F5W(&QL861D<B!O<B!.54Q,+"!I9B!I
M="!I<R!N;W0@<W5P<&QI960N"BT@(" M+2!N97<@(" @:7,@;F5W('-T871E
M+@HK(" @+2T@;F5W7W-T871E(&ES(&YE=R!S=&%T92X*(" @("TM(&]V97)R
M:61E/3TQ(&%L;&]W<R!T;R!O=F5R<FED92!E>&ES=&EN9R!L;&%D9'(L(&EF
M(&ET(&ES(&1I9F9E<F5N="X*(" @("TM(&%R<#T],"!M96%N<R!T:&%T('1H
M92!C:&%N9V4@:7,@861M:6YI<W1R871I=F4N"B @*B\*( HM:6YT(&YE:6=H
M7W5P9&%T92AS=')U8W0@;F5I9VAB;W5R("IN96EG:"P@=3@@*FQL861D<BP@
M=3@@;F5W+"!I;G0@;W9E<G)I9&4L(&EN="!A<G I"BMI;G0@;F5I9VA?=7!D
M871E*'-T<G5C="!N96EG:&)O=7(@*FYE:6=H+"!U." J;&QA9&1R+"!U."!N
M97=?<W1A=&4L(&EN="!O=F5R<FED92P@:6YT(&%R<"D*('L*( EU."!O;&0@
M/2!N96EG:"T^;G5D7W-T871E.PH@"7-T<G5C="!D979I8V4@*F1E=B ](&YE
M:6=H+3YD978["D! ("TV-S,L,3(@*S8W,RPQ,B! 0 H@"6EF("AA<G @)B8@
M*&]L9"8H3E5$7TY/05)0?$Y51%]015)-04Y%3E0I*2D*( D)<F5T=7)N("U%
M4$5233L*( HM"6EF("@A*&YE=R9.541?5D%,240I*2!["BL):68@*"$H;F5W
M7W-T871E)DY51%]604Q)1"DI('L*( D):68@*&]L9"9.541?24Y?5$E-15(I
M"B )"0ED96Q?=&EM97(H)FYE:6=H+3YT:6UE<BD["B )"6EF("AO;&0F3E5$
M7T-/3DY%0U1%1"D*( D)"6YE:6=H7W-U<W!E8W0H;F5I9V@I.PHM"0EN96EG
M:"T^;G5D7W-T871E(#T@;F5W.PHK"0EN96EG:"T^;G5D7W-T871E(#T@;F5W
M7W-T871E.PH@"0ER971U<FX@,#L*( E]"B *0$ @+3<P.2PW("LW,#DL-R! 
M0 H@"B );F5I9VA?<WEN8RAN96EG:"D["B );VQD(#T@;F5I9V@M/FYU9%]S
M=&%T93L*+0EI9B H;F5W)DY51%]#3TY.14-4140I"BL):68@*&YE=U]S=&%T
M929.541?0T].3D5#5$5$*0H@"0EN96EG:"T^8V]N9FER;65D(#T@:FEF9FEE
M<SL*( EN96EG:"T^=7!D871E9" ](&II9F9I97,["B *0$ @+3<Q."PQ,B K
M-S$X+#$R($! "B )("HO"B ):68@*&]L9"9.541?5D%,240I('L*( D):68@
M*&QL861D<B ]/2!N96EG:"T^:&$I"BT)"0EI9B H;F5W(#T](&]L9"!\?" H
M;F5W(#T]($Y51%]35$%,12 F)B H;VQD)DY51%]#3TY.14-4140I*2D**PD)
M"6EF("AN97=?<W1A=&4@/3T@;VQD('Q\("AN97=?<W1A=&4@/3T@3E5$7U-4
M04Q%("8F("AO;&0F3E5$7T-/3DY%0U1%1"DI*0H@"0D)"7)E='5R;B P.PH@
M"7T*( EI9B H;VQD)DY51%])3E]424U%4BD*( D)9&5L7W1I;65R*"9N96EG
M:"T^=&EM97(I.PHM"6YE:6=H+3YN=61?<W1A=&4@/2!N97<["BL);F5I9V@M
M/FYU9%]S=&%T92 ](&YE=U]S=&%T93L*( EI9B H;&QA9&1R("$](&YE:6=H
M+3YH82D@>PH@"0EM96UC<'DH)FYE:6=H+3YH82P@;&QA9&1R+"!D978M/F%D
M9')?;&5N*3L*( D);F5I9VA?=7!D871E7VAH<RAN96EG:"D["D! ("TW,S,L
M.2 K-S,S+#D@0$ *( D)"6YE:6=H7V%P<%]N;W1I9GDH;F5I9V@I.PH@(V5N
M9&EF"B )?0HM"6EF("AN97<@/3T@;VQD*0HK"6EF("AN97=?<W1A=&4@/3T@
M;VQD*0H@"0ER971U<FX@,#L*+0EI9B H;F5W)DY51%]#3TY.14-4140I"BL)
M:68@*&YE=U]S=&%T929.541?0T].3D5#5$5$*0H@"0EN96EG:%]C;VYN96-T
I*&YE:6=H*3L*( EE;'-E"B )"6YE:6=H7W-U<W!E8W0H;F5I9V@I.PH`
`
end
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
