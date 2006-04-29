Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWD2Vlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWD2Vlz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 17:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWD2Vlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 17:41:55 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:26895 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750800AbWD2Vly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 17:41:54 -0400
Date: Sat, 29 Apr 2006 21:45:52 +0100
From: Darren Salt <linux@youmustbejoking.demon.co.uk>
Message-ID: <4E1F56DC10%linux@youmustbejoking.demon.co.uk>
User-Agent: Messenger-Pro/4.09b8 (MsgServe/3.24b1) (RISC-OS/4.02) POPstar/2.06+cvs
To: linux-kernel@vger.kernel.org
Subject: Log flood: "scheduling while atomic" (2.6.15.x, 2.6.16.x)
X-Editor: Zap 1.47 (27 Apr 2006) [TEST], ZapEmail 0.28.3 (25 Mar 2005) (32)
X-SDate: Sat, 4624 Sep 1993 21:45:52 +0100
X-Message-Flag: Outlook Express is broken. Upgrade to mail(1).
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: linux@youmustbejoking.demon.co.uk
X-SA-Exim-Scanned: No (on pentagram.youmustbejoking.demon.co.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing bouts of log flooding caused by something presumably not releasing
a lock. I've looked at some of the messages, but at around 100/s, I'm not too
keen to look through the whole lot :-)

  scheduling while atomic: swapper/0xafbfffff/0
   [show_trace+19/32]
   [dump_stack+30/32]
   [schedule+1278/1472]
   [cpu_idle+88/96]
   [stext+44/64]
   [start_kernel+574/704]
   [L6+0/2] 0xc0100199

(Trailing parts of some lines have been omitted; it's all repeated data. And
some sort of rate-limiting of these messages would be nice, but some other
way to draw attention to the problem, e.g. an occasional beep, would be
good.)

The most recent instance occurred a few minutes into recording a TV programme
(via vdr) from a cx88-based Nova-T. (I'm currently using stock drivers rather
than ones built from the v4l-dvb repository.)

Config, lspci, dmesg, modules list are attached.

Once the problem has manifest itself, attempts to shutdown tend to hang with
reports of soft lockups; keypresses trigger more scheduling-while-atomic
reports. Normal reboot fails, but rebooting via sysrq works.

I find it curious that it started happening after a power failure (actually,
a significant reduction in the supply - lights were dim, and I could power up
my printer). It's happened identically with several different kernels; I
first noticed with, IIRC, 2.6.15.4. In case it's of any significance, there's
signal booster between the aerial and the DVB cards (I'm not ruling out the
possibility that this is triggered by some weird hardware problem).

Any clues, anybody?

-- 
| Darren Salt    | linux or ds at              | nr. Ashington, | Toon
| RISC OS, Linux | youmustbejoking,demon,co,uk | Northumberland | Army
|   <URL:http://www.youmustbejoking.demon.co.uk/progs.packages.html>

To neutralise unholy water, boil the hell out of it.

begin 644 dmesg,fff
M3&EN=7@@=F5R<VEO;B`R+C8N,38N,3$@*')O;W1`9FQI8F)L92D@*&=C8R!V
M97)S:6]N(#0N,"XS("A$96)I86X@-"XP+C,M,2DI(",Q(%1U92!!<'(@,C4@
M,#,Z,S$Z-3@@0E-4(#(P,#8*0DE/4RUP<F]V:61E9"!P:'ES:6-A;"!204T@
M;6%P.@H@0DE/4RUE.#(P.B`P,#`P,#`P,#`P,#`P,#`P("T@,#`P,#`P,#`P
M,#`Y9F,P,"`H=7-A8FQE*0H@0DE/4RUE.#(P.B`P,#`P,#`P,#`P,#EF8S`P
M("T@,#`P,#`P,#`P,#!A,#`P,"`H<F5S97)V960I"B!"24]3+64X,C`Z(#`P
M,#`P,#`P,#`P9C`P,#`@+2`P,#`P,#`P,#`P,3`P,#`P("AR97-E<G9E9"D*
M($))3U,M93@R,#H@,#`P,#`P,#`P,#$P,#`P,"`M(#`P,#`P,#`P,&9F9C`P
M,#`@*'5S86)L92D*($))3U,M93@R,#H@,#`P,#`P,#`P9F9F,#`P,"`M(#`P
M,#`P,#`P,&9F9C,P,#`@*$%#4$D@3E93*0H@0DE/4RUE.#(P.B`P,#`P,#`P
M,#!F9F8S,#`P("T@,#`P,#`P,#`Q,#`P,#`P,"`H04-022!D871A*0H@0DE/
M4RUE.#(P.B`P,#`P,#`P,&9F9F8P,#`P("T@,#`P,#`P,#$P,#`P,#`P,"`H
M<F5S97)V960I"C(U-4U"($Q/5TU%32!A=F%I;&%B;&4N"D]N(&YO9&4@,"!T
M;W1A;'!A9V5S.B`V-34R,`H@($1-02!Z;VYE.B`T,#DV('!A9V5S+"!,249/
M(&)A=&-H.C`*("!$34$S,B!Z;VYE.B`P('!A9V5S+"!,249/(&)A=&-H.C`*
M("!.;W)M86P@>F]N93H@-C$T,C0@<&%G97,L($Q)1D\@8F%T8V@Z,34*("!(
M:6=H365M('IO;F4Z(#`@<&%G97,L($Q)1D\@8F%T8V@Z,`I$34D@,BXS('!R
M97-E;G0N"D%#4$DZ(%)31%`@*'8P,#`@2U0R-C8@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`I($`@,'@P,#!F-S4W,`I!0U!).B!24T14("AV
M,#`Q($M4,C8V("!!5U)$04-022`P>#0R,S`R93,Q($%74D0@,'@P,#`P,#`P
M,"D@0"`P>#!F9F8S,#`P"D%#4$DZ($9!1%0@*'8P,#$@2U0R-C8@($%74D1!
M0U!)(#!X-#(S,#)E,S$@05=21"`P>#`P,#`P,#`P*2!`(#!X,&9F9C,P-#`*
M04-023H@1%-$5"`H=C`P,2!+5#(V-B`@05=21$%#4$D@,'@P,#`P,3`P,"!-
M4T94(#!X,#$P,#`P,&,I($`@,'@P,#`P,#`P,`I!0U!).B!032U4:6UE<B!)
M3R!0;W)T.B`P>#0P,#@*06QL;V-A=&EN9R!00TD@<F5S;W5R8V5S('-T87)T
M:6YG(&%T(#(P,#`P,#`P("AG87`Z(#$P,#`P,#`P.F5F9F8P,#`P*0I"=6EL
M="`Q('IO;F5L:7-T<PI+97)N96P@8V]M;6%N9"!L:6YE.B!A=71O($)/3U1?
M24U!1T4]3&EN=7@@<F\@<F]O=#TS,#(@86-P:5]I<G%?:7-A/3$R(&%P:6,]
M=F5R8F]S92!L87!I8PI,;V-A;"!!4$E#(&1I<V%B;&5D(&)Y($))3U,@+2T@
M<F5E;F%B;&EN9RX*1F]U;F0@86YD(&5N86)L960@;&]C86P@05!)0R$*;6%P
M<&5D($%024,@=&\@9F9F9F0P,#`@*&9E93`P,#`P*0I%;F%B;&EN9R!F87-T
M($9052!S879E(&%N9"!R97-T;W)E+BXN(&1O;F4N"D5N86)L:6YG('5N;6%S
M:V5D(%-)340@1E!5(&5X8V5P=&EO;B!S=7!P;W)T+BXN(&1O;F4N"DEN:71I
M86QI>FEN9R!#4%4C,`I0240@:&%S:"!T86)L92!E;G1R:65S.B`Q,#(T("AO
M<F1E<CH@,3`L(#$V,S@T(&)Y=&5S*0I$971E8W1E9"`R,#`X+CDT-"!-2'H@
M<')O8V5S<V]R+@I5<VEN9R!P;71M<B!F;W(@:&EG:"UR97,@=&EM97-O=7)C
M90I#;VYS;VQE.B!C;VQO=7(@5D=!*R`X,'@R-0I$96YT<GD@8V%C:&4@:&%S
M:"!T86)L92!E;G1R:65S.B`V-34S-B`H;W)D97(Z(#8L(#(V,C$T-"!B>71E
M<RD*26YO9&4M8V%C:&4@:&%S:"!T86)L92!E;G1R:65S.B`S,C<V."`H;W)D
M97(Z(#4L(#$S,3`W,B!B>71E<RD*365M;W)Y.B`R-34U,3)K+S(V,C`X,&L@
M879A:6QA8FQE("@R,SDX:R!K97)N96P@8V]D92P@-C`R,&L@<F5S97)V960L
M(#<R,VL@9&%T82P@,3@P:R!I;FET+"`P:R!H:6=H;65M*0I#:&5C:VEN9R!I
M9B!T:&ES('!R;V-E<W-O<B!H;VYO=7)S('1H92!74"!B:70@979E;B!I;B!S
M=7!E<G9I<V]R(&UO9&4N+BX@3VLN"D-A;&EB<F%T:6YG(&1E;&%Y('5S:6YG
M('1I;65R('-P96-I9FEC(')O=71I;F4N+B`T,#(S+C$R($)O9V]-25!3("AL
M<&H].#`T-C(T."D*4V5C=7)I='D@1G)A;65W;W)K('8Q+C`N,"!I;FET:6%L
M:7IE9`I#87!A8FEL:71Y($Q332!I;FET:6%L:7IE9`I-;W5N="UC86-H92!H
M87-H('1A8FQE(&5N=')I97,Z(#4Q,@I#4%4Z($%F=&5R(&=E;F5R:6,@:61E
M;G1I9GDL(&-A<',Z(#`S.#-F8F9F(&,Q8S-F8F9F(#`P,#`P,#`P(#`P,#`P
M,#`P(#`P,#`P,#`P(#`P,#`P,#`P(#`P,#`P,#`P"D-053H@069T97(@=F5N
M9&]R(&ED96YT:69Y+"!C87!S.B`P,S@S9F)F9B!C,6,S9F)F9B`P,#`P,#`P
M,"`P,#`P,#`P,"`P,#`P,#`P,"`P,#`P,#`P,"`P,#`P,#`P,`I#4%4Z($PQ
M($D@0V%C:&4Z(#8T2R`H-C0@8GET97,O;&EN92DL($0@8V%C:&4@-C1+("@V
M-"!B>71E<R]L:6YE*0I#4%4Z($PR($-A8VAE.B`R-39+("@V-"!B>71E<R]L
M:6YE*0I#4%4Z($%F=&5R(&%L;"!I;FET<RP@8V%P<SH@,#,X,V9B9F8@8S%C
M,V9B9F8@,#`P,#`P,#`@,#`P,#`T,C`@,#`P,#`P,#`@,#`P,#`P,#`@,#`P
M,#`P,#`*26YT96P@;6%C:&EN92!C:&5C:R!A<F-H:71E8W1U<F4@<W5P<&]R
M=&5D+@I);G1E;"!M86-H:6YE(&-H96-K(')E<&]R=&EN9R!E;F%B;&5D(&]N
M($-052,P+@I#4%4Z($%-1"!!=&AL;VXH=&TI(%A0(#(T,#`K('-T97!P:6YG
M(#`Q"D-H96-K:6YG("=H;'0G(&EN<W1R=6-T:6]N+BXN($]++@I!0U!).B!S
M971T:6YG($5,0U(@=&\@,#(P,"`H9G)O;2`P93`P*0IE;F%B;&5D($5X=$E.
M5"!O;B!#4%4C,`I5<VEN9R!L;V-A;"!!4$E#('1I;65R(&EN=&5R<G5P=',N
M"F-A;&EB<F%T:6YG($%024,@=&EM97(@+BXN"BXN+BXN($-052!C;&]C:R!S
M<&5E9"!I<R`R,#`X+C(X-#8@34AZ+@HN+BXN+B!H;W-T(&)U<R!C;&]C:R!S
M<&5E9"!I<R`R-C<N,S,Q,B!-2'HN"DY%5#H@4F5G:7-T97)E9"!P<F]T;V-O
M;"!F86UI;'D@,38*04-023H@8G5S('1Y<&4@<&-I(')E9VES=&5R960*<W!U
M<FEO=7,@.#(U.4$@:6YT97)R=7!T.B!)4E$W+@I00TDZ(%!#22!"24]3(')E
M=FES:6]N(#(N,3`@96YT<GD@870@,'AF8C0W,"P@;&%S="!B=7,],0I00TDZ
M(%5S:6YG(&-O;F9I9W5R871I;VX@='EP92`Q"D%#4$DZ(%-U8G-Y<W1E;2!R
M979I<VEO;B`R,#`V,#$R-PI!0U!).B!);G1E<G!R971E<B!E;F%B;&5D"D%#
M4$DZ(%5S:6YG(%!)0R!F;W(@:6YT97)R=7!T(')O=71I;F<*04-023H@4$-)
M(%)O;W0@0G)I9&=E(%M00TDP72`H,#`P,#HP,"D*4$-).B!0<F]B:6YG(%!#
M22!H87)D=V%R92`H8G5S(#`P*0I!0U!).B!!<W-U;64@<F]O="!B<FED9V4@
M6UQ?4T)?+E!#23!=(&)U<R!I<R`P"D)O;W0@=FED96\@9&5V:6-E(&ES(#`P
M,#`Z,#$Z,#`N,`I!0U!).B!00TD@26YT97)R=7!T(%)O=71I;F<@5&%B;&4@
M6UQ?4T)?+E!#23`N7U!25%T*04-023H@4$-)($EN=&5R<G5P="!,:6YK(%M,
M3DM!72`H25)1<R`Q(#,@-"`U(#8@-R`Q,"`J,3$@,3(@,30@,34I"D%#4$DZ
M(%!#22!);G1E<G)U<'0@3&EN:R!;3$Y+0ET@*$E247,@,2`S(#0@-2`V(#<@
M*C$P(#$Q(#$R(#$T(#$U*0I!0U!).B!00TD@26YT97)R=7!T($QI;FL@6TQ.
M2T-=("A)4E%S(#$@,R`T(#4@-B`W(#$P("HQ,2`Q,B`Q-"`Q-2D*04-023H@
M4$-)($EN=&5R<G5P="!,:6YK(%M,3DM$72`H25)1<R`Q(#,@-"`U(#8@-R`J
M,3`@,3$@,3(@,30@,34I"DQI;G5X(%!L=6<@86YD(%!L87D@4W5P<&]R="!V
M,"XY-R`H8RD@061A;2!"96QA>0IP;G`Z(%!N4"!!0U!)(&EN:70*<&YP.B!0
M;E`@04-023H@9F]U;F0@,30@9&5V:6-E<PIU<V)C;W)E.B!R96=I<W1E<F5D
M(&YE=R!D<FEV97(@=7-B9G,*=7-B8V]R93H@<F5G:7-T97)E9"!N97<@9')I
M=F5R(&AU8@I00TDZ(%5S:6YG($%#4$D@9F]R($E242!R;W5T:6YG"E!#23H@
M268@82!D979I8V4@9&]E<VXG="!W;W)K+"!T<GD@(G!C:3UR;W5T96ER<2(N
M("!)9B!I="!H96QP<RP@<&]S="!A(')E<&]R=`I00TDZ($)R:61G93H@,#`P
M,#HP,#HP,2XP"B`@24\@=VEN9&]W.B!C,#`P+6-F9F8*("!-14T@=VEN9&]W
M.B!E-#`P,#`P,"UE-69F9F9F9@H@(%!2149%5$-(('=I;F1O=SH@9#`P,#`P
M,#`M9&9F9F9F9F8*4$-).B!3971T:6YG(&QA=&5N8WD@=&EM97(@;V8@9&5V
M:6-E(#`P,#`Z,#`Z,#$N,"!T;R`V-`I-86-H:6YE(&-H96-K(&5X8V5P=&EO
M;B!P;VQL:6YG('1I;65R('-T87)T960N"DEN<W1A;&QI;F<@:VYF<V0@*&-O
M<'ER:6=H="`H0RD@,3DY-B!O:VER0&UO;F%D+G-W8BYD92DN"DEN:71I86QI
M>FEN9R!#<GEP=&]G<F%P:&EC($%020II;R!S8VAE9'5L97(@;F]O<"!R96=I
M<W1E<F5D"FEO('-C:&5D=6QE<B!A;G1I8VEP871O<GD@<F5G:7-T97)E9"`H
M9&5F875L="D*:6\@<V-H961U;&5R(&1E861L:6YE(')E9VES=&5R960*:6\@
M<V-H961U;&5R(&-F<2!R96=I<W1E<F5D"D%#4$DZ(%!#22!);G1E<G)U<'0@
M3&EN:R!;3$Y+05T@96YA8FQE9"!A="!)4E$@,3$*4$-).B!S971T:6YG($E2
M42`Q,2!A<R!L979E;"UT<FEG9V5R960*04-023H@4$-)($EN=&5R<G5P="`P
M,#`P.C`Q.C`P+C!;05T@+3X@3&EN:R!;3$Y+05T@+3X@1U-)(#$Q("AL979E
M;"P@;&]W*2`M/B!)4E$@,3$*<F%D96]N9F(Z($9O=6YD($EN=&5L('@X-B!"
M24]3(%)/32!);6%G90IR861E;VYF8CH@4F5T<FEE=F5D(%!,3"!I;F9O<R!F
M<F]M($))3U,*<F%D96]N9F(Z(%)E9F5R96YC93TR-RXP,"!-2'H@*%)E9D1I
M=CTQ,BD@365M;W)Y/3(P,"XP,"!-:'HL(%-Y<W1E;3TQ-C8N,#`@34AZ"G)A
M9&5O;F9B.B!03$P@;6EN(#(P,#`P(&UA>"`T,#`P,`IR861E;VYF8CH@36]N
M:71O<B`Q('1Y<&4@0U)4(&9O=6YD"G)A9&5O;F9B.B!%1$E$('!R;V)E9`IR
M861E;VYF8CH@36]N:71O<B`R('1Y<&4@;F\@9F]U;F0*0V]N<V]L93H@<W=I
M=&-H:6YG('1O(&-O;&]U<B!F<F%M92!B=69F97(@9&5V:6-E(#$V,'@V-`IR
M861E;VYF8B`H,#`P,#HP,3HP,"XP*3H@051)(%)A9&5O;B!99"`*04-023H@
M4&]W97(@0G5T=&]N("A&1BD@6U!74D9="D%#4$DZ(%!O=V5R($)U='1O;B`H
M0TTI(%M05U)"70I!0U!).B!3;&5E<"!"=71T;VX@*$--*2!;4TQ00ET*04-0
M23H@1F%N(%M&04Y=("AO;BD*04-023H@0U!5,"`H<&]W97(@<W1A=&5S.B!#
M,5M#,5T@0S);0S)=*0I!0U!).B!4:&5R;6%L(%IO;F4@6U1(4DU=("@T,2!#
M*0I296%L(%1I;64@0VQO8VL@1')I=F5R('8Q+C$R86,*3&EN=7@@86=P9V%R
M="!I;G1E<F9A8V4@=C`N,3`Q("AC*2!$879E($IO;F5S"F%G<&=A<G0Z($1E
M=&5C=&5D(%9)02!+5#(V-B]+63(V-G@O2U0S,S,@8VAI<'-E=`IA9W!G87)T
M.B!!1U`@87!E<G1U<F4@:7,@-C1-($`@,'AE,#`P,#`P,`I;9')M72!);FET
M:6%L:7IE9"!D<FT@,2XP+C$@,C`P-3$Q,#(*04-023H@4$-)($EN=&5R<G5P
M="`P,#`P.C`Q.C`P+C!;05T@+3X@3&EN:R!;3$Y+05T@+3X@1U-)(#$Q("AL
M979E;"P@;&]W*2`M/B!)4E$@,3$*6V1R;5T@26YI=&EA;&EZ960@<F%D96]N
M(#$N,C(N,"`R,#`U,3(R.2!O;B!M:6YO<B`P"E!.4#H@4%,O,B!#;VYT<F]L
M;&5R(%M03E`P,S`S.E!3,DLL4$Y0,&8Q,SI04S)-72!A="`P>#8P+#!X-C0@
M:7)Q(#$L,3(*<V5R:6\Z(&DX,#0R($%56"!P;W)T(&%T(#!X-C`L,'@V-"!I
M<G$@,3(*<V5R:6\Z(&DX,#0R($M"1"!P;W)T(&%T(#!X-C`L,'@V-"!I<G$@
M,0IP87)P;W)T.B!0;E!"24]3('!A<G!O<G0@9&5T96-T960N"G!A<G!O<G0P
M.B!00RUS='EL92!A="`P>#,W."P@:7)Q(#<@6U!#4U!0+%1225-4051%70I&
M;&]P<'D@9')I=F4H<RDZ(&9D,"!I<R`Q+C0T30I&1$,@,"!I<R!A('!O<W0M
M,3DY,2`X,C`W-PHX,3,Y=&]O($9A<W0@171H97)N970@9')I=F5R(#`N.2XR
M-PI!0U!).B!00TD@26YT97)R=7!T($QI;FL@6TQ.2T-=(&5N86)L960@870@
M25)1(#$Q"D%#4$DZ(%!#22!);G1E<G)U<'0@,#`P,#HP,#HP82XP6T%=("T^
M($QI;FL@6TQ.2T-=("T^($=322`Q,2`H;&5V96PL(&QO=RD@+3X@25)1(#$Q
M"F5T:#`Z(%)E86Q496L@4E1,.#$S.2!A="`P>&0P.#!E,#`P+"`P,#HS,#IB
M9#HR-SHQ8SHW-2P@25)1(#$Q"F5T:#`Z("!)9&5N=&EF:65D(#@Q,SD@8VAI
M<"!T>7!E("=25$PM.#$P,$(O.#$S.40G"E5N:69O<FT@375L=&DM4&QA=&9O
M<FT@12U)1$4@9')I=F5R(%)E=FES:6]N.B`W+C`P86QP:&$R"FED93H@07-S
M=6UI;F<@,S--2'H@<WES=&5M(&)U<R!S<&5E9"!F;W(@4$E/(&UO9&5S.R!O
M=F5R<FED92!W:71H(&ED96)U<SUX>`I64%])1$4Z($E$12!C;VYT<F]L;&5R
M(&%T(%!#22!S;&]T(#`P,#`Z,#`Z,3$N,0I!0U!).B!00TD@26YT97)R=7!T
M(#`P,#`Z,#`Z,3$N,5M!72`M/B!,:6YK(%M,3DM!72`M/B!'4TD@,3$@*&QE
M=F5L+"!L;W<I("T^($E242`Q,0I00TDZ(%9I82!)4E$@9FEX=7`@9F]R(#`P
M,#`Z,#`Z,3$N,2P@9G)O;2`R-34@=&\@,3$*5E!?241%.B!C:&EP<V5T(')E
M=FES:6]N(#8*5E!?241%.B!N;W0@,3`P)2!N871I=F4@;6]D93H@=VEL;"!P
M<F]B92!I<G%S(&QA=&5R"E907TE$13H@5DE!('9T.#(S,V$@*')E=B`P,"D@
M241%(%5$34$Q,S,@8V]N=')O;&QE<B!O;B!P8VDP,#`P.C`P.C$Q+C$*("`@
M(&ED93`Z($)-+41-02!A="`P>&4P,#`M,'AE,#`W+"!"24]3('-E='1I;F=S
M.B!H9&$Z1$U!+"!H9&(Z<&EO"B`@("!I9&4Q.B!"32U$34$@870@,'AE,#`X
M+3!X93`P9BP@0DE/4R!S971T:6YG<SH@:&1C.D1-02P@:&1D.D1-00I0<F]B
M:6YG($E$12!I;G1E<F9A8V4@:61E,"XN+@IH9&$Z($5X8V5L4W1O<B!496-H
M;F]L;V=Y($HS-C`L($%402!$25-+(&1R:79E"FED93`@870@,'@Q9C`M,'@Q
M9C<L,'@S9C8@;VX@:7)Q(#$T"E!R;V)I;F<@241%(&EN=&5R9F%C92!I9&4Q
M+BXN"FAD8SH@4$E/3D5%4B!$5D0M4E<@1%92+3$Q,$0L($%405!)($-$+T16
M1"U23TT@9')I=F4*:&1D.B!304U354Y'($161"U23TT@4T0M-C$V42P@051!
M4$D@0T0O1%9$+5)/32!D<FEV90II9&4Q(&%T(#!X,3<P+3!X,3<W+#!X,S<V
M(&]N(&ER<2`Q-0IH9&$Z(&UA>"!R97%U97-T('-I>F4Z(#4Q,DMI0@IH9&$Z
M(#$R,#$P,S(P,"!S96-T;W)S("@V,30Y,B!-0BD@=R\Q.#(Q2VE"($-A8VAE
M+"!#2%,],38S.#,O,C4U+S8S+"!51$U!*#$P,"D*:&1A.B!C86-H92!F;'5S
M:&5S('-U<'!O<G1E9`H@:&1A.B!H9&$Q(&AD83(@:&1A,R!H9&$T(#P@:&1A
M-2!H9&$V(&AD83<@:&1A."!H9&$Y(&AD83$P(#X*:&1C.B!!5$%022`T,%@@
M1%9$+5)/32!$5D0M4B!#1"U2+U)7(&1R:79E+"`R,#`P:T(@0V%C:&4L(%5$
M34$H-C8I"E5N:69O<FT@0T0M4D]-(&1R:79E<B!2979I<VEO;CH@,RXR,`IH
M9&0Z($%405!)(#0X6"!$5D0M4D]-(&1R:79E+"`U,3)K0B!#86-H92P@541-
M02@S,RD*=7-B;6]N.B!D96)U9V9S(&ES(&YO="!A=F%I;&%B;&4*;6EC93H@
M4%,O,B!M;W5S92!D979I8V4@8V]M;6]N(&9O<B!A;&P@;6EC90II;G!U=#H@
M050@5')A;G-L871E9"!3970@,B!K97EB;V%R9"!A<R`O8VQA<W,O:6YP=70O
M:6YP=70P"FEN<'5T.B!00R!3<&5A:V5R(&%S("]C;&%S<R]I;G!U="]I;G!U
M=#$*:3)C("]D978@96YT<FEE<R!D<FEV97(*=S@S-C(W:&8@.3$Y,2TP,CDP
M.B!%;F%B;&EN9R!T96UP,BP@<F5A9&EN9W,@;6EG:'0@;F]T(&UA:V4@<V5N
M<V4*061V86YC960@3&EN=7@@4V]U;F0@07)C:&ET96-T=7)E($1R:79E<B!6
M97)S:6]N(#$N,"XQ,7)C,B`H5V5D($IA;B`P-"`P.#HU-SHR,"`R,#`V(%54
M0RDN"D%,4T$@9&5V:6-E(&QI<W0Z"B`@3F\@<V]U;F1C87)D<R!F;W5N9"X*
M3D54.B!296=I<W1E<F5D('!R;W1O8V]L(&9A;6EL>2`R"DE0(')O=71E(&-A
M8VAE(&AA<V@@=&%B;&4@96YT<FEE<SH@-#`Y-B`H;W)D97(Z(#(L(#$V,S@T
M(&)Y=&5S*0I40U`@97-T86)L:7-H960@:&%S:"!T86)L92!E;G1R:65S.B`Q
M-C,X-"`H;W)D97(Z(#0L(#8U-3,V(&)Y=&5S*0I40U`@8FEN9"!H87-H('1A
M8FQE(&5N=')I97,Z(#$V,S@T("AO<F1E<CH@-"P@-C4U,S8@8GET97,I"E1#
M4#H@2&%S:"!T86)L97,@8V]N9FEG=7)E9"`H97-T86)L:7-H960@,38S.#0@
M8FEN9"`Q-C,X-"D*5$-0(')E;F\@<F5G:7-T97)E9`I40U`@8FEC(')E9VES
M=&5R960*3D54.B!296=I<W1E<F5D('!R;W1O8V]L(&9A;6EL>2`Q"DY%5#H@
M4F5G:7-T97)E9"!P<F]T;V-O;"!F86UI;'D@,3<*57-I;F<@25!)(%-H;W)T
M8W5T(&UO9&4*5D93.B!-;W5N=&5D(')O;W0@*&5X=#(@9FEL97-Y<W1E;2D@
M<F5A9&]N;'DN"D9R965I;F<@=6YU<V5D(&ME<FYE;"!M96UO<GDZ(#$X,&L@
M9G)E960*:6YP=70Z($EM17A04R\R($=E;F5R:6,@17AP;&]R97(@36]U<V4@
M87,@+V-L87-S+VEN<'5T+VEN<'5T,@I,:6YU>"!V:61E;R!C87!T=7)E(&EN
M=&5R9F%C93H@=C$N,#`*55-"(%5N:79E<G-A;"!(;W-T($-O;G1R;VQL97(@
M26YT97)F86-E(&1R:79E<B!V,BXS"D%#4$DZ(%!#22!);G1E<G)U<'0@3&EN
M:R!;3$Y+1%T@96YA8FQE9"!A="!)4E$@,3`*4$-).B!S971T:6YG($E242`Q
M,"!A<R!L979E;"UT<FEG9V5R960*04-023H@4$-)($EN=&5R<G5P="`P,#`P
M.C`P.C$Q+C);1%T@+3X@3&EN:R!;3$Y+1%T@+3X@1U-)(#$P("AL979E;"P@
M;&]W*2`M/B!)4E$@,3`*=6AC:5]H8V0@,#`P,#HP,#HQ,2XR.B!52$-)($AO
M<W0@0V]N=')O;&QE<@IU:&-I7VAC9"`P,#`P.C`P.C$Q+C(Z(&YE=R!54T(@
M8G5S(')E9VES=&5R960L(&%S<VEG;F5D(&)U<R!N=6UB97(@,0IU:&-I7VAC
M9"`P,#`P.C`P.C$Q+C(Z(&ER<2`Q,"P@:6\@8F%S92`P>#`P,#!E-#`P"G5S
M8B!U<V(Q.B!C;VYF:6=U<F%T:6]N(",Q(&-H;W-E;B!F<F]M(#$@8VAO:6-E
M"FAU8B`Q+3`Z,2XP.B!54T(@:'5B(&9O=6YD"FAU8B`Q+3`Z,2XP.B`R('!O
M<G1S(&1E=&5C=&5D"D%#4$DZ(%!#22!);G1E<G)U<'0@,#`P,#HP,#HQ,2XS
M6T1=("T^($QI;FL@6TQ.2T1=("T^($=322`Q,"`H;&5V96PL(&QO=RD@+3X@
M25)1(#$P"G5H8VE?:&-D(#`P,#`Z,#`Z,3$N,SH@54A#22!(;W-T($-O;G1R
M;VQL97(*=6AC:5]H8V0@,#`P,#HP,#HQ,2XS.B!N97<@55-"(&)U<R!R96=I
M<W1E<F5D+"!A<W-I9VYE9"!B=7,@;G5M8F5R(#(*=6AC:5]H8V0@,#`P,#HP
M,#HQ,2XS.B!I<G$@,3`L(&EO(&)A<V4@,'@P,#`P93@P,`IU<V(@=7-B,CH@
M8V]N9FEG=7)A=&EO;B`C,2!C:&]S96X@9G)O;2`Q(&-H;VEC90IH=6(@,BTP
M.C$N,#H@55-"(&AU8B!F;W5N9`IH=6(@,BTP.C$N,#H@,B!P;W)T<R!D971E
M8W1E9`I397)I86PZ(#@R-3`O,38U-3`@9')I=F5R("12979I<VEO;CH@,2XY
M,"`D(#(@<&]R=',L($E242!S:&%R:6YG(&1I<V%B;&5D"G-E<FEA;#@R-3`Z
M('1T>5,P(&%T($DO3R`P>#-F."`H:7)Q(#T@-"D@:7,@82`Q-C4U,$$*<V5R
M:6%L.#(U,#H@='1Y4S$@870@22]/(#!X,F8X("AI<G$@/2`S*2!I<R!A(#$V
M-34P00HP,#HP.#H@='1Y4S`@870@22]/(#!X,V8X("AI<G$@/2`T*2!I<R!A
M(#$V-34P00HP,#HP.3H@='1Y4S$@870@22]/(#!X,F8X("AI<G$@/2`S*2!I
M<R!A(#$V-34P00IS86$W,30V.B!R96=I<W1E<B!E>'1E;G-I;VX@)V)U9&=E
M=%]C:2!D=F(G+@I!0U!).B!00TD@26YT97)R=7!T(#`P,#`Z,#`Z,&,N,%M!
M72`M/B!,:6YK(%M,3DM!72`M/B!'4TD@,3$@*&QE=F5L+"!L;W<I("T^($E2
M42`Q,0IS86$W,30V.B!F;W5N9"!S86$W,30V($`@;65M(&0Q.&%A,#`P("AR
M979I<VEO;B`Q+"!I<G$@,3$I("@P>#$S8S(L,'@Q,#$Q*2X*1%9".B!R96=I
M<W1E<FEN9R!N97<@861A<'1E<B`H5%0M0G5D9V5T+U=I;E16+4Y/5D$M5`D@
M4$-)*2X*8W@R,S@X>"!D=F(@9')I=F5R('9E<G-I;VX@,"XP+C4@;&]A9&5D
M"F-X,C,X.'@@=C1L,B!D<FEV97(@=F5R<VEO;B`P+C`N-2!L;V%D960*861A
M<'1E<B!H87,@34%#(&%D9'(@/2`P,#ID,#HU8SHR,CHQ93IF,@II;G!U=#H@
M0G5D9V5T+4-)(&1V8B!I<B!R96-E:79E<B!S86$W,30V("@P*2!A<R`O8VQA
M<W,O:6YP=70O:6YP=70S"D160CH@<F5G:7-T97)I;F<@9G)O;G1E;F0@,"`H
M4&AI;&EP<R!41$$Q,#`T-4@@1%9"+50I+BXN"D-/4D4@8W@X.%LP73H@<W5B
M<WES=&5M.B`P,#<P.CDP,#(L(&)O87)D.B!(875P<&%U9V4@3F]V82U4($16
M0BU4(%MC87)D/3$X+&%U=&]D971E8W1E9%T*5%8@='5N97(@-"!A="`P>#%F
M92P@4F%D:6\@='5N97(@+3$@870@,'@Q9F4*=7-B(#$M,3H@;F5W(&QO=R!S
M<&5E9"!54T(@9&5V:6-E('5S:6YG('5H8VE?:&-D(&%N9"!A9&1R97-S(#(*
M='9E97!R;VT@-BTP,#4P.B!(875P<&%U9V4@;6]D96P@.3`P,#(L(')E=B!#
M,3<V+"!S97)I86PC(#0P-C8X,@IT=F5E<')O;2`V+3`P-3`Z($U!0R!A9&1R
M97-S(&ES(#`P+3!$+49%+3`V+3,T+3E!"G1V965P<F]M(#8M,#`U,#H@='5N
M97(@;6]D96P@:7,@5&AO;7!S;VX@1%14-S4Y,B`H:61X(#<V+"!T>7!E(#0I
M"G1V965P<F]M(#8M,#`U,#H@5%8@<W1A;F1A<F1S($%44T,O1%9"($1I9VET
M86P@*&5E<')O;2`P>#@P*0IT=F5E<')O;2`V+3`P-3`Z(&%U9&EO('!R;V-E
M<W-O<B!I<R!.;VYE("AI9'@@,"D*='9E97!R;VT@-BTP,#4P.B!D96-O9&5R
M('!R;V-E<W-O<B!I<R!#6#@X,B`H:61X(#(U*0IT=F5E<')O;2`V+3`P-3`Z
M(&AA<R!N;R!R861I;RP@:&%S($E2(')E;6]T90IC>#@X6S!=.B!H875P<&%U
M9V4@965P<F]M.B!M;V1E;#TY,#`P,@II;G!U=#H@8W@X."!)4B`H2&%U<'!A
M=6=E($YO=F$M5"!$5D(M5"!A<R`O8VQA<W,O:6YP=70O:6YP=70T"D%#4$DZ
M(%!#22!);G1E<G)U<'0@3&EN:R!;3$Y+0ET@96YA8FQE9"!A="!)4E$@,3`*
M04-023H@4$-)($EN=&5R<G5P="`P,#`P.C`P.C`Y+C);05T@+3X@3&EN:R!;
M3$Y+0ET@+3X@1U-)(#$P("AL979E;"P@;&]W*2`M/B!)4E$@,3`*8W@X.%LP
M72\R.B!F;W5N9"!A="`P,#`P.C`P.C`Y+C(L(')E=CH@-2P@:7)Q.B`Q,"P@
M;&%T96YC>3H@,S(L(&UM:6\Z(#!X93<P,#`P,#`*8W@X.%LP72\R.B!C>#(S
M.#AX(&)A<V5D(&1V8B!C87)D"D160CH@<F5G:7-T97)I;F<@;F5W(&%D87!T
M97(@*&-X.#A;,%TI+@I$5D(Z(')E9VES=&5R:6YG(&9R;VYT96YD(#$@*$-O
M;F5X86YT($-8,C(W,#(@1%9"+50I+BXN"D%#4$DZ(%!#22!);G1E<G)U<'0@
M,#`P,#HP,#HP.2XP6T%=("T^($QI;FL@6TQ.2T)=("T^($=322`Q,"`H;&5V
M96PL(&QO=RD@+3X@25)1(#$P"F-X.#A;,%TO,#H@9F]U;F0@870@,#`P,#HP
M,#HP.2XP+"!R978Z(#4L(&ER<3H@,3`L(&QA=&5N8WDZ(#,R+"!M;6EO.B`P
M>&4V,#`P,#`P"F-X.#A;,%TO,#H@<F5G:7-T97)E9"!D979I8V4@=FED96\P
M(%MV-&PR70IC>#@X6S!=+S`Z(')E9VES=&5R960@9&5V:6-E('9B:3`*<V5T
M7V-O;G1R;VP@:60],'@Y.#`Y,#`@<F5G/3!X,S$P,3$P('9A;#TP>#`P("AM
M87-K(#!X9F8I"G-E=%]C;VYT<F]L(&ED/3!X.3@P.3`Q(')E9STP>#,Q,#$Q
M,"!V86P],'@S9C`P("AM87-K(#!X9F8P,"D*<V5T7V-O;G1R;VP@:60],'@Y
M.#`Y,#,@<F5G/3!X,S$P,3$X('9A;#TP>#`P("AM87-K(#!X9F8I"G-E=%]C
M;VYT<F]L(&ED/3!X.3@P.3`R(')E9STP>#,Q,#$Q-"!V86P],'@U83=F("AM
M87-K(#!X9F9F9BD*<V5T7V-O;G1R;VP@:60],'@Y.#`Y,#D@<F5G/3!X,S(P
M-3DT('9A;#TP>#0P("AM87-K(#!X-#`I(%MS:&%D;W=E9%T*<V5T7V-O;G1R
M;VP@:60],'@Y.#`Y,#4@<F5G/3!X,S(P-3DT('9A;#TP>#(P("AM87-K(#!X
M,V8I(%MS:&%D;W=E9%T*<V5T7V-O;G1R;VP@:60],'@Y.#`Y,#8@<F5G/3!X
M,S(P-3DX('9A;#TP>#0P("AM87-K(#!X-V8I(%MS:&%D;W=E9%T*04-023H@
M4$-)($EN=&5R<G5P="`P,#`P.C`P.C$Q+C5;0UT@+3X@3&EN:R!;3$Y+0UT@
M+3X@1U-)(#$Q("AL979E;"P@;&]W*2`M/B!)4E$@,3$*4$-).B!3971T:6YG
M(&QA=&5N8WD@=&EM97(@;V8@9&5V:6-E(#`P,#`Z,#`Z,3$N-2!T;R`V-`IU
M<V(@,2TQ.B!C;VYF:6=U<F%T:6]N(",Q(&-H;W-E;B!F<F]M(#$@8VAO:6-E
M"F-X,C,X.'@@8FQA8VMB:7)D(&1R:79E<B!V97)S:6]N(#`N,"XU(&QO861E
M9`I!0U!).B!00TD@26YT97)R=7!T(#`P,#`Z,#`Z,#@N,%M!72`M/B!,:6YK
M(%M,3DM!72`M/B!'4TD@,3$@*&QE=F5L+"!L;W<I("T^($E242`Q,0II;G!U
M=#H@5VER96QE<W,@36]U<V4@5VER96QE<W,@36]U<V4@87,@+V-L87-S+VEN
M<'5T+VEN<'5T-0II;G!U=#H@55-"($A)1"!V,2XQ,"!-;W5S92!;5VER96QE
M<W,@36]U<V4@5VER96QE<W,@36]U<V5=(&]N('5S8BTP,#`P.C`P.C$Q+C(M
M,0IU<V)C;W)E.B!R96=I<W1E<F5D(&YE=R!D<FEV97(@=7-B:&ED"F1R:79E
M<G,O=7-B+VEN<'5T+VAI9"UC;W)E+F,Z('8R+C8Z55-"($A)1"!C;W)E(&1R
M:79E<@I!9&1I;F<@,3`P-#`U,FL@<W=A<"!O;B`O9&5V+VAD83,N("!0<FEO
M<FET>3HM,2!E>'1E;G1S.C$@86-R;W-S.C$P,#0P-3)K"E-#4TD@<W5B<WES
M=&5M(&EN:71I86QI>F5D"D%#4$DZ(%!#22!);G1E<G)U<'0@,#`P,#HP,#HP
M8BXP6T%=("T^($QI;FL@6TQ.2T1=("T^($=322`Q,"`H;&5V96PL(&QO=RD@
M+3X@25)1(#$P"G-C<VDP(#H@061V86Y3>7,@4T-322`S+C-+.B!00TD@56QT
M<F$M5VED93H@4$-)345-(#!X1#`X,4,P,#`M,'A$,#@Q0S`S1BP@25)1(#!X
M00IE=&@P.B!L:6YK('5P+"`Q,#!-8G!S+"!F=6QL+61U<&QE>"P@;'!A(#!X
M-#5%,0I.1E-$.B!5<VEN9R`O=F%R+VQI8B]N9G,O=C1R96-O=F5R>2!A<R!T
M:&4@3D93=C0@<W1A=&4@<F5C;W9E<GD@9&ER96-T;W)Y"DY&4T0Z('-T87)T
M:6YG(#DP+7-E8V]N9"!G<F%C92!P97)I;V0*=&1A,3`P-'@Z(&9O=6YD(&9I
M<FUW87)E(')E=FES:6]N(#`@+2T@:6YV86QI9`IT9&$Q,#`T>#H@=V%I=&EN
M9R!F;W(@9FER;7=A<F4@=7!L;V%D("AD=F(M9F4M=&1A,3`P-#4N9G<I+BXN
M"G1D83$P,#1X.B!F:7)M=V%R92!U<&QO860@8V]M<&QE=&4*=&1A,3`P-'@Z
M(&9O=6YD(&9I<FUW87)E(')E=FES:6]N(#)C("TM(&]K"F%G<&=A<G0Z($9O
M=6YD(&%N($%'4"`R+C`@8V]M<&QI86YT(&1E=FEC92!A="`P,#`P.C`P.C`P
M+C`N"F%G<&=A<G0Z(%!U='1I;F<@04=0(%8R(&1E=FEC92!A="`P,#`P.C`P
M.C`P+C`@:6YT;R`T>"!M;V1E"F%G<&=A<G0Z(%!U='1I;F<@04=0(%8R(&1E
M=FEC92!A="`P,#`P.C`Q.C`P+C`@:6YT;R`T>"!M;V1E"EMD<FU=($QO861I
2;F<@4C(P,"!-:6-R;V-O9&4*
`
end

begin 644 lspci,fff
M,#`P,#HP,#HP,"XP($AO<W0@8G)I9&=E.B!624$@5&5C:&YO;&]G:65S+"!)
M;F,N(%94.#,V-B]!+S<@6T%P;VQL;R!+5#(V-B]!+S,S,UT*,#`P,#HP,#HP
M,2XP(%!#22!B<FED9V4Z(%9)02!496-H;F]L;V=I97,L($EN8RX@5E0X,S8V
M+T$O-R!;07!O;&QO($M4,C8V+T$O,S,S($%'4%T*,#`P,#HP,#HP."XP($UU
M;'1I;65D:6$@875D:6\@8V]N=')O;&QE<CH@0W)E871I=F4@3&%B<R!30B!,
M:79E(2!%354Q,&LQ("AR978@,&$I"C`P,#`Z,#`Z,#@N,2!);G!U="!D979I
M8V4@8V]N=')O;&QE<CH@0W)E871I=F4@3&%B<R!30B!,:79E(2!-241)+T=A
M;64@4&]R="`H<F5V(#!A*0HP,#`P.C`P.C`Y+C`@375L=&EM961I82!V:61E
M;R!C;VYT<F]L;&5R.B!#;VYE>&%N="!#6#(S.#@P+S$O,B\S(%!#22!6:61E
M;R!A;F0@075D:6\@1&5C;V1E<B`H<F5V(#`U*0HP,#`P.C`P.C`Y+C(@375L
M=&EM961I82!C;VYT<F]L;&5R.B!#;VYE>&%N="!#6#(S.#@P+S$O,B\S(%!#
M22!6:61E;R!A;F0@075D:6\@1&5C;V1E<B!;35!%1R!0;W)T72`H<F5V(#`U
M*0HP,#`P.C`P.C`Y+C0@375L=&EM961I82!C;VYT<F]L;&5R.B!#;VYE>&%N
M="!#6#(S.#@P+S$O,B\S(%!#22!6:61E;R!A;F0@075D:6\@1&5C;V1E<B!;
M25(@4&]R=%T@*')E=B`P-2D*,#`P,#HP,#HP82XP($5T:&5R;F5T(&-O;G1R
M;VQL97(Z(%)E86QT96L@4V5M:6-O;F1U8W1O<B!#;RXL($QT9"X@4E1,+3@Q
M,SDO.#$S.4,O.#$S.4,K("AR978@,3`I"C`P,#`Z,#`Z,&(N,"!30U-)('-T
M;W)A9V4@8V]N=')O;&QE<CH@061V86YC960@4WES=&5M(%!R;V1U8W1S+"!)
M;F,@04)0.30P+557"C`P,#`Z,#`Z,&,N,"!-=6QT:6UE9&EA(&-O;G1R;VQL
M97(Z(%!H:6QI<',@4V5M:6-O;F1U8W1O<G,@4T%!-S$T-B`H<F5V(#`Q*0HP
M,#`P.C`P.C$Q+C`@25-!(&)R:61G93H@5DE!(%1E8VAN;VQO9VEE<RP@26YC
M+B!65#@R,S-!($E302!"<FED9V4*,#`P,#HP,#HQ,2XQ($E$12!I;G1E<F9A
M8V4Z(%9)02!496-H;F]L;V=I97,L($EN8RX@5E0X,D,U.#9!+T(O5E0X,D,V
M.#8O02]"+U94.#(S>"]!+T,@4$E00R!"=7,@36%S=&5R($E$12`H<F5V(#`V
M*0HP,#`P.C`P.C$Q+C(@55-"($-O;G1R;VQL97(Z(%9)02!496-H;F]L;V=I
M97,L($EN8RX@5E0X,GAX>'AX(%5(0TD@55-"(#$N,2!#;VYT<F]L;&5R("AR
M978@,C,I"C`P,#`Z,#`Z,3$N,R!54T(@0V]N=')O;&QE<CH@5DE!(%1E8VAN
M;VQO9VEE<RP@26YC+B!65#@R>'AX>'@@54A#22!54T(@,2XQ($-O;G1R;VQL
M97(@*')E=B`R,RD*,#`P,#HP,#HQ,2XU($UU;'1I;65D:6$@875D:6\@8V]N
M=')O;&QE<CH@5DE!(%1E8VAN;VQO9VEE<RP@26YC+B!65#@R,S,O02\X,C,U
M+S@R,S<@04,Y-R!!=61I;R!#;VYT<F]L;&5R("AR978@-#`I"C`P,#`Z,#$Z
M,#`N,"!61T$@8V]M<&%T:6)L92!C;VYT<F]L;&5R.B!!5$D@5&5C:&YO;&]G
M:65S($EN8R!25C(X,"!;4F%D96]N(#DR,#`@4T5=("AR978@,#$I"C`P,#`Z
M,#$Z,#`N,2!$:7-P;&%Y(&-O;G1R;VQL97(Z($%422!496-H;F]L;V=I97,@
M26YC(%)6,C@P(%M2861E;VX@.3(P,"!315T@*%-E8V]N9&%R>2D@*')E=B`P
#,2D*
`
end

begin 644 lsmod,fff
M36]D=6QE("`@("`@("`@("`@("`@("`@4VEZ92`@57-E9"!B>0IE97!R;VT@
M("`@("`@("`@("`@("`@("`U-3@T("`P(`IS<E]M;V0@("`@("`@("`@("`@
M("`@(#$T,C0T("`P(`IA9'9A;G-Y<R`@("`@("`@("`@("`@(#<U.30P("`P
M(`IS8W-I7VUO9"`@("`@("`@("`@("`@,3$Q,C0T("`R('-R7VUO9"QA9'9A
M;G-Y<PIU<V)H:60@("`@("`@("`@("`@("`@(#,P.3$V("`P(`IS;F1?96UU
M,3!K,5]S>6YT:"`@("`@("`V-3(X("`P(`IS;F1?96UU>%]S>6YT:"`@("`@
M("`@(#,R,C4V("`Q('-N9%]E;74Q,&LQ7W-Y;G1H"G-N9%]S97%?=FER;6ED
M:2`@("`@("`@(#4P-38@(#$@<VYD7V5M=7A?<WEN=&@*<VYD7W-E<5]M:61I
M7V5M=6P@("`@("`@-3DU,B`@,2!S;F1?96UU>%]S>6YT:`IS;F1?<V5Q7V]S
M<R`@("`@("`@("`@(#(Y.3(T("`P(`IS;F1?<V5Q7VUI9&D@("`@("`@("`@
M("`V-38P("`P(`IS;F1?<V5Q7VUI9&E?979E;G0@("`@("`V,#$V("`S('-N
M9%]S97%?=FER;6ED:2QS;F1?<V5Q7V]S<RQS;F1?<V5Q7VUI9&D*<VYD7W-E
M<2`@("`@("`@("`@("`@("`T-3,X."`@."!S;F1?96UU>%]S>6YT:"QS;F1?
M<V5Q7W9I<FUI9&DL<VYD7W-E<5]M:61I7V5M=6PL<VYD7W-E<5]O<W,L<VYD
M7W-E<5]M:61I+'-N9%]S97%?;6ED:5]E=F5N=`IC>#@X7V)L86-K8FER9"`@
M("`@("`@(#$W,#4R("`P(`IS;F1?96UU,3!K,2`@("`@("`@("`@,3$T-S(T
M("`Q('-N9%]E;74Q,&LQ7W-Y;G1H"G-N9%]V:6$X,GAX("`@("`@("`@("`@
M,C(T,C`@(#`@"G-N9%]A8SDW7V-O9&5C("`@("`@("`@.3(S,C`@(#(@<VYD
M7V5M=3$P:S$L<VYD7W9I83@R>'@*<VYD7V%C.3=?8G5S("`@("`@("`@("`@
M,3<Y,B`@,2!S;F1?86,Y-U]C;V1E8PIC>#@X,#`@("`@("`@("`@("`@("`@
M(#(W,S0P("`Q(&-X.#A?8FQA8VMB:7)D"F-X.#A?9'9B("`@("`@("`@("`@
M("`@(#DX-C`@(#(U(`IC>#@X,#(@("`@("`@("`@("`@("`@("`Y,#(X("`R
M(&-X.#A?8FQA8VMB:7)D+&-X.#A?9'9B"F-X.#AX>"`@("`@("`@("`@("`@
M("`@-3<Y-38@(#0@8W@X.%]B;&%C:V)I<F0L8W@X.#`P+&-X.#A?9'9B+&-X
M.#@P,@IC>#@X7W9P,S`U-%]I,F,@("`@("`@("`S-#4V("`Q(&-X.#A?9'9B
M"G-N9%]P8VU?;W-S("`@("`@("`@("`@-#8W-3(@(#`@"G-N9%]M:7AE<E]O
M<W,@("`@("`@("`@,34T.#@@(#$@<VYD7W!C;5]O<W,*:7)?8V]M;6]N("`@
M("`@("`@("`@("`@.#`V."`@,2!C>#@X>'@*;70S-3(@("`@("`@("`@("`@
M("`@("`@-3@R."`@,2!C>#@X7V1V8@IB=61G971?8VD@("`@("`@("`@("`@
M(#$R,S4R("`P(`IT9&$Q,#`T>"`@("`@("`@("`@("`@(#$T-S@X("`Q(&)U
M9&=E=%]C:0IB=61G971?8V]R92`@("`@("`@("`@("`V.3$V("`Q(&)U9&=E
M=%]C:0IS86$W,30V("`@("`@("`@("`@("`@(#$T,C@P("`R(&)U9&=E=%]C
M:2QB=61G971?8V]R90IT='!C:5]E97!R;VT@("`@("`@("`@("`Q.3(P("`Q
M(&)U9&=E=%]C;W)E"C@R-3!?<&YP("`@("`@("`@("`@("`@(#@R-38@(#`@
M"C@R-3`@("`@("`@("`@("`@("`@("`@,3@V-38@(#$@.#(U,%]P;G`*<V5R
M:6%L7V-O<F4@("`@("`@("`@("`Q-C4Q,B`@,2`X,C4P"G1V965P<F]M("`@
M("`@("`@("`@("`@,3,P-S(@(#$@8W@X.'AX"F-O;7!A=%]I;V-T;#,R("`@
M("`@("`@(#$P,C0@(#$@8W@X.#`P"G8T;#%?8V]M<&%T("`@("`@("`@("`@
M,3,S,38@(#$@8W@X.#`P"G8T;#)?8V]M;6]N("`@("`@("`@("`@(#8V-38@
M(#(@8W@X.%]B;&%C:V)I<F0L8W@X.#`P"G-N9%]U=&EL7VUE;2`@("`@("`@
M("`@(#,S.3(@(#(@<VYD7V5M=7A?<WEN=&@L<VYD7V5M=3$P:S$*<W1V,#(Y
M.2`@("`@("`@("`@("`@("`@.34T-"`@,2!B=61G971?8VD*;W(U,3$S,B`@
M("`@("`@("`@("`@("`@.3`R."`@,2!C>#@X7V1V8@IV:61E;U]B=69?9'9B
M("`@("`@("`@("`T-#@T("`Q(&-X.#A?9'9B"F1V8E]C;W)E("`@("`@("`@
M("`@("`@-S0X.#`@(#0@8G5D9V5T7V-I+&)U9&=E=%]C;W)E+'-T=C`R.3DL
M=FED96]?8G5F7V1V8@IV:61E;U]B=68@("`@("`@("`@("`@(#$W,C(P("`V
M(&-X.#A?8FQA8VMB:7)D+&-X.#@P,"QC>#@X7V1V8BQC>#@X,#(L8W@X.'AX
M+'9I9&5O7V)U9E]D=F(*;GAT,C`P>"`@("`@("`@("`@("`@("`Q,C8W-B`@
M,2!C>#@X7V1V8@IF:7)M=V%R95]C;&%S<R`@("`@("`@("`W-S0T("`U(&-X
M.#A?8FQA8VMB:7)D+&)U9&=E=%]C:2QT9&$Q,#`T>"QO<C4Q,3,R+&YX=#(P
M,'@*<VYD7W!C;2`@("`@("`@("`@("`@("`W-3,S-B`@-"!S;F1?96UU,3!K
M,2QS;F1?=FEA.#)X>"QS;F1?86,Y-U]C;V1E8RQS;F1?<&-M7V]S<PIS;F1?
M=&EM97(@("`@("`@("`@("`@(#$X.#(P("`S('-N9%]S97$L<VYD7V5M=3$P
M:S$L<VYD7W!C;0IS;F1?<&%G95]A;&QO8R`@("`@("`@("`X,S(X("`S('-N
M9%]E;74Q,&LQ+'-N9%]V:6$X,GAX+'-N9%]P8VT*<VYD7VUP=30P,5]U87)T
M("`@("`@("`@-38Y-B`@,2!S;F1?=FEA.#)X>`IB=&-X7W)I<V,@("`@("`@
M("`@("`@("`S.#0X("`S(&-X.#@P,"QC>#@X,#(L8W@X.'AX"G-N9%]R87=M
M:61I("`@("`@("`@("`@,3DV,38@(#0@<VYD7W-E<5]V:7)M:61I+'-N9%]S
M97%?;6ED:2QS;F1?96UU,3!K,2QS;F1?;7!U-#`Q7W5A<G0*<VYD7W-E<5]D
M979I8V4@("`@("`@("`@-C@V,"`@-R!S;F1?96UU,3!K,5]S>6YT:"QS;F1?
M96UU>%]S>6YT:"QS;F1?<V5Q7V]S<RQS;F1?<V5Q7VUI9&DL<VYD7W-E<2QS
M;F1?96UU,3!K,2QS;F1?<F%W;6ED:0IS;F1?:'=D97`@("`@("`@("`@("`@
M("`W,#0T("`R('-N9%]E;75X7W-Y;G1H+'-N9%]E;74Q,&LQ"G-T=C`R.3<@
M("`@("`@("`@("`@("`@(#8U.3(@(#$@8G5D9V5T7V-I"F-X,C0Q,C,@("`@
M("`@("`@("`@("`@(#<X-S8@(#$@8W@X.%]D=F(*;&=D=#,S,'@@("`@("`@
M("`@("`@("`@-S(V,"`@,2!C>#@X7V1V8@IC>#(R-S`R("`@("`@("`@("`@
M("`@("`U-S`P("`Q(&-X.#A?9'9B"F1V8E]P;&P@("`@("`@("`@("`@("`@
M(#DT,3(@(#0@8W@X.%]D=F(L;W(U,3$S,BQN>'0R,#!X+&-X,C(W,#(*=6AC
M:5]H8V0@("`@("`@("`@("`@("`R-SDR,"`@,"`*=FED96]D978@("`@("`@
M("`@("`@("`@-S`T,"`@,R!C>#@X7V)L86-K8FER9"QC>#@X,#`L8W@X.'AX
!"B`@
`
end

begin 644 config.gz,f89
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
.)3&!Y?G_F--!!<Z0``#P
`
end
