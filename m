Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUBXISi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 03:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUBXISi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 03:18:38 -0500
Received: from hendrix.ece.utexas.edu ([128.83.59.42]:39081 "EHLO
	hendrix.ece.utexas.edu") by vger.kernel.org with ESMTP
	id S261605AbUBXISe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 03:18:34 -0500
Date: Tue, 24 Feb 2004 02:18:31 -0600 (CST)
From: "Hmamouche, Youssef" <youssef@ece.utexas.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.3 - Debug: sleeping function called from invalid context
Message-ID: <Pine.LNX.4.21.0402240204510.5314-100000@linux08.ece.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm having some issues with ibm t22 laptop. I've been having these traces quite
frequently in my logs:

Feb 23 23:22:46 darkstar kernel: Debug: sleeping function called from invalid
context at include/asm/uaccess.h:473
Feb 23 23:22:46 darkstar kernel: in_atomic():1, irqs_disabled():0
Feb 23 23:22:46 darkstar kernel: Call Trace:
Feb 23 23:22:46 darkstar kernel:  [<c012235b>] __might_sleep+0xab/0xd0
Feb 23 23:22:46 darkstar kernel:  [<c011b157>] do_read+0xd7/0x200
Feb 23 23:22:46 darkstar kernel:  [<c0175f3f>] vfs_read+0xaf/0x120
Feb 23 23:22:46 darkstar kernel:  [<c01761cf>] sys_read+0x3f/0x60
Feb 23 23:22:46 darkstar kernel:  [<c010a48b>] syscall_call+0x7/0xb
Feb 23 23:22:46 darkstar kernel:
Feb 23 23:22:46 darkstar kernel: bad: scheduling while atomic!
Feb 23 23:22:46 darkstar kernel: Call Trace:
Feb 23 23:22:46 darkstar kernel:  [<c011fb55>] schedule+0x8e5/0x8f0
Feb 23 23:22:46 darkstar kernel:  [<c011dfd8>] kernel_map_pages+0x28/0x70
Feb 23 23:22:46 darkstar kernel:  [<c015005f>] __alloc_pages+0x35f/0x3d0
Feb 23 23:22:46 darkstar kernel:  [<c011cb0d>] do_page_fault+0x11d/0x588
Feb 23 23:22:46 darkstar kernel:  [<c013231d>] schedule_timeout+0xdd/0xe0
Feb 23 23:22:46 darkstar kernel:  [<c01500f2>] __get_free_pages+0x22/0x50
Feb 23 23:22:46 darkstar kernel:  [<c0191768>] __pollwait+0x38/0xb0
Feb 23 23:22:46 darkstar kernel:  [<c011b2d0>] do_poll+0x50/0x70
Feb 23 23:22:46 darkstar kernel:  [<c0191b17>] do_select+0x247/0x400
Feb 23 23:22:46 darkstar kernel:  [<c0191730>] __pollwait+0x0/0xb0
Feb 23 23:22:46 darkstar kernel:  [<c0191ff6>] sys_select+0x2e6/0x530
Feb 23 23:22:46 darkstar kernel:  [<c0163f8f>] unmap_vma_list+0x1f/0x30
Feb 23 23:22:46 darkstar kernel:  [<c010a48b>] syscall_call+0x7/0xb
Feb 23 23:22:46 darkstar kernel:
Feb 23 23:22:47 darkstar kernel: bad: scheduling while atomic!
Feb 23 23:22:47 darkstar kernel: Call Trace:
Feb 23 23:22:47 darkstar kernel:  [<c011fb55>] schedule+0x8e5/0x8f0
Feb 23 23:22:47 darkstar kernel:  [<c010c805>] do_IRQ+0x255/0x3b0
Feb 23 23:22:47 darkstar kernel:  [<c010a4b2>] work_resched+0x5/0x16
Feb 23 23:22:47 darkstar kernel:


Should I just rebuild without CONFIG_DEBUG_SPINLOCK_SLEEP and hope all goes
well? Recently, the system crashed and had to alt-sysrq-b to get away. here's
what the logs picked up:

Feb 23 23:22:47 darkstar kernel: Debug: sleeping function called from invalid
context at include/asm/uaccess.h:473
Feb 23 23:22:47 darkstar kernel: in_atomic():1, irqs_disabled():0
Feb 23 23:22:47 darkstar kernel: Call Trace:
Feb 23 23:22:47 darkstar kernel:  [<c012235b>] __might_sleep+0xab/0xd0
Feb 23 23:22:47 darkstar kernel:  [<c011b157>] do_read+0xd7/0x200
Feb 23 23:22:47 darkstar kernel:  [<c010a5f8>] common_interrupt+0x18/0x20
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@ª¦^NÖC³H^\^^@.8 kÆ.Îì.#ÇÇG.ÍÕâöÆ^ZÞ^L.Õ..jqQ.ÀO5åÙ.L^C.4Úa.{îÁ^O+^[^[^FÛ^QÆ»\^Xv¾L.^NÃbnD0^Qo^Ti.yÔÊªX¤£¤T²^U¥...²Ix¾·.ç^F¨nºèÌðª­§.ä.p0¾^
KÇ
eÐàw[^M4wå¸hä7cüÚ¼´^Fûü²^Ç.C....;14­^\¹m¶B.XXã2^G{è^Y`^^IÇ©§.¤Ò,^L.]^D!..b)^LcFR.X
^G§=¥îÜà37Vt0<ã'9K¸^SÁ$..Å1»Ì^G¨&4Õu2^Er¼ëÄÅ½n¢.ï2")ÕÕ¡.Ý.À¤z.Ù^^ø^S®..®p8T!^Eîà¦ªí.^M¦äZÏ
dsÃ»³|h«¬^Eî.ØZ.lT{Q(.Ík^E.hä.æ.^O^E
.fÈ.±"Yd%u7.~¶þ.$È¾.é^H^\"x÷ÞL1;÷Ùô1æ.p$3Ó³.äBNÓ¯I..Dþ¨.&Zü^H.Ô1CÀìïN}^Në.{^C¯.^B^Q;u^@ÜO8.Ñ6.Xç.^T^K^W^M
[11:_æÖmNzxt^Y©;+..;^E_³£_«ÃµÛD.Ó^H^\B!ç;z9^Au.^Pa^Ae³6^H¥õöÕÛRJÒ..lmLSf.­ÞÖü:Öù|u|..9tç}^?^XRY(°¾­üúzÑÖ t¨.uô^U§sK.+^MT@CÚ.L.^ûHw°:^SÌË^L»9^C.p_mô.3pµòÈ¾IÑ©.^LÔa.Ýc¤
éå9£~iÌr×M°¹9S.^H^\v£×x^\Î´øg´..Ä!^_.-"^H^_â.^XIñ²z«þ¨^G¦^?¤. î~^O..ä2mÐÄ.$n^SØú8DR1.]^O=m*¡.wÿ^@^L<;j^O^[apCÔ-%ù...W}ßY
ãu^AÎ.B
{:´t0à/íA..ÃºAÉ?^^ |.0ó^H^L.ÆçOâ^\^Xl.8a?´|RáÄÃ.?^],ÃRÂ°àÏd©Ûê¬.(Ê­f.¬^^ªDÕ_­ 6^T^QÞ^Q@Dñ
æÐÈwÁ^^^\ý^]ÚºB^SÑ»Ä...`éY09ô|ø^Tùà.¨D\Às¥^W0$yó¤.ç}Z±ÓO.³§@órâvpôz^PÜ^^iüÑN
/@ôû.ù.âVè^Zg¾q..r^LQ^A.Â`A:.+.ñ»pZ.¦¹ÚA^N^An,{>^_.°ÉÂ^Z°;ç.ü^_^QòàÎ(^V.½ªc^B*ìxk.®`=ÃÄÜúýÉA.D^Z^G#¡ßÝõò_^L½Ð^U}.^X.ð>^N=..&.¶·!Ú"ä|øåu^Ooô·ÓÜRAë^A.µ^EyÇ­Î^Tç÷.\)ÏãTA
^O^ZüÝæ^F^G.ªÕü.L.¿Jªª^O×ë»®=ºí........¶?.s¿j»T¦S).Êk.Â.ý§·h^@^D.^A#^L^QUQ^X^H.ùà^Né.3^L\3^Lóyæõ^Szl|^W^A@
ç{º Á^Q^D^Xè'³W..eÎ^SÀ`^@^@^@^@^G^ÞyÙW*H^^.©`^B"."'®ö..ºÿQå
yåÜ.ÛKq®^MJ7.^Y-^Z.nZã.W
fdphÜ¦^NeÁÌ¸8Ën&^N%^[.0Ã0Ê´¥)oùíÂÝk0g^PËm½.Üµ]UUI.
*¸Å..®{^PÞ..ð^A_+ªu+ûÞnUSËç^Tºyñøy<¥Ü^@^@ªª«^A^Qæpù¾g×«ßÛ­H^G½."B"Á
¦0Xæzèyû.Põxè¡®öD^P G.¦Bsr.^@^OR.ûäm.,).Óª^T.`Ì('k¿WO^wTÜ#´tâ4F^DU.4qa^O.¢ú}.
>^].^CÇ.éµè     ±ß¬æHCóä:Óµò@Â.&.Ý%NÄÌ2^L
Ä.L.F!¶\.     ^A.^BL%àä^ENpS^@¸^Q9a^L(h^Q;pâh±5Æ .áz'Ã^A~¸-.^F
>Èý0^OóE1üÔOlG^X«´[^NiÖP^@ìòõ^SÀº^F.ñ÷þÿ.ø$.. .^C]B.·þ..ØL¡ûä
^BM.0..^Uü.^^Ï^]¸ß.ºéC^_,§Ë.ö^L^Uo^Xvâç.<ò¸ìg.^R.¢^H"©O.F^Z5`¦^C0o.<jêí^[[^ML¶QâË¬þû°.ÃKW^_=Õ¶Ý..oº¤ÇVÁ¥ê4^MeA^NTk ü^P<^B#Ý©^F^_.>Àå.u^S§É1ÅRÙ^AO%^Q..^Mò!.Ëbäl[^C.Ì6.
2^U.yü{°.Mj1^Ué1G4ùÑ^P^F^^.àl^V
<ZA^Gn½{Ú¼^B@LÈ^T«£ÖD.*^Q­xZ^Rá n¥§.rD$DCàà.^Y*^T§^C§
M.ãìôúý.|ús§»à¯.        ^P9:>Ý,>.²"ÍD..5ôã.ùß·^Q=kÅwËN¬M^Ec\ÒÆx.cTè^U^PP^@.Þ.^S[Î8.,^@i×ÕWã..³^Z.¶ºÂ^^.<|!Îvöô/^NÈHI^EåJ^Px^]¹¢=¯.TëbK©¥J4^Cµ&+`.       dÌÄ^Q'.Ðî.D.°.
Ó!÷Ö..'[duÉ:ô1rëS_.«»¢""%^^?^]_^M½³|[`l)í.«9ï.{w{¬4½«Â{Sºö,ï¿.^GÇ±¯>!RT^HA..tý/8£;**^].P^U:¢lu^\0";uùt..á²^[
°^O_ªw´[rÔÛACS^PÄCé¥´9Q2ÞKÔñµ.Rº\Ý2..wºáÔÝ}$}^HA|Û.¨¿.^^^
Vá^N.ÒÛQNó^T.9áà^LDÁÛC.$!^T^W^\èz34^Næ²^MYåO
n»zl.¬..^Ou9ÕU{kÝ©.»óGK^]Kí¤6-^Oé|ap@ÄÄP
Ég§¹õÆ>÷È~r¦W^S#.Z^VÁÉ_.".zªª©^B1í2-^Aê¾X6©.;<Ú:^G®^Hþ?ùê^_©^DÑ^_^RÒx^R.bzúùÜ).3{Sþ^\§ú¿Ý°jÿ·8ÿ¢^GýG^ªà..©,¼»*'¸LÉ&N¡Ëçíó
.ðÉß^B.|E.K^Y±^Yìôd='KQRÙ].`úk9¯úÿ½·ãuòGÎ.éß.^UQiå^]¹Ù*m^]..x^V%²[TV*.^ZÑk}~Ï^?.Ù÷ä^RRHaæ`â=ÄS*ÂK^R.ëãÏG¨5wÐ.ù.^X.^_.è.)Ì.. ».¯.¥#9Ú&JÖ.Z..±dYÒ.HåÛnÑ^A».N^Z^GhZ^Zä^R¸
9í.r$8Æj´É9^\°\=êÔÎSÙ.sµâ^QÏO^UÍÜÛ.¤..Z.^MJå'<^Üù^F.Mø.S.²l^@u(m^D
^Fj%·U.u40.}.9^EKUÚ2%3q^TÖ­d'-°|.»RÕ;p..Øj.ÑJ.óå..@R.^X's&ö^]ÑI³¾ÌN.7º$ñ..½^GÛD?ÙóÂ^?r.IþÇþ^V
â¢^_J¿.Û^RU.^R^@äÿ.^T A0P%.^Pø='~z[Ù.ú}*ùïå^fsr.ª^%^Fm¿V_åYqõë.*.±¬(^Pß¾
CMo#+>?{.^ÿ±¶°¶R  t.¸xq^_`èH.ì^K²ÂRô ö^Zyº¾ ñ ªk..ª¶
«~M.^LA."ª.\^F.<.>..gaîPFðOkÔò_¾b^^B°^HäåÑ^].#6^]ÆÙ~TI..Ká^UÈ.;.^^^DlPü%è^F?<ËæÃoFèJK^VxÝ¸yúD*°z|­ûú¹ë°.^P.ÔÝõ×µ4g<Ó¬.s.éP'Ñ6g÷.ÕÊ&Ë¥»^H2.^B.é?¾½îÐ^?t^_.^D\(^G^@^Pät9
^K7+mO±.Í^FYÃá¯Ù´.ÍV¼¹5Ó£óW¾Èï¦Þ«.$öÐúª*ËNÝ3.OIDüý3.^GÏã¡¿.ì·X^A^NÉµõS
^Y.©ã§tN^]õP^M..¶öBÁå.#^H^PÑè.Õ^B^QWå­^@.NþÞß.:^_Ý6.û^Rò^MµKÝ.^O.Ôó^Vê·ï.ûC²^Gq..^>ã».¡.H.pû¯.
¥7.^C:P^Pü©^D½­.U]È..       R).võ.êä.^Y
R¤[b¾co^^ï.ÑÒoÍ"^HÍáã.ñ7§^Xa^Neq.. ..[^Uî^P.µ^P><Ú1K!å^ø.       °^MÌ7<|.<òÌ{3ïîñß<û95.^?Ù^O4^Gî..HÀýûH,"¬4¢%X±^Y^O BX.F{©ïÃCË:×^S[Í4^ïL¹à¦­Sg»ôí8û^NvO°X.ì.M2{^Pi¦¤áãã
§mò7¥.'^E%.K,.ð£.\®>..Å½V^_.s}    Íô.wñiÄ,.é9X.±MÖ×mó
1:¸MÍù*µÆ.õù.°s.LØµÆ^P)^QÄ$Û~pês.|^Ca°M.e^C)^P^PBR^EÃ,3ÎÛ[r]¹.^\6.C}R.^P..ö<^^^G^QP^].sy.m3¡.fd.®.SÙ^C.ºg.NÌ
©.^EzÕ½S)²²(.pß>æ.^.^P3Ôßc^M{^°Yyã^MVbâc.Æ^S&µ^Pê.£^^Vé^Qäòp®Î.DÂ.qNG`©ü1T>ä>ÿÕø..Q¥,P¤79
ÿ&â.^\.À.â^õÅü]Ûâsi.H.%Ô*7-e^TÈ=w,fï.ÙÑÍ¶¸9^S®S^L.õ¢S
[`^Vò¬r:×èõüÿ.npN       8ÏA»7.'^E¼%K^]³^Z|<ÌÛbBïb3Úcæõã^M.ÛCËW1¡x¹^PEå9
X¾xfæh^P:Á^NY.°r.^X^^¾0(.¿^N
^^vM(8|v^P6Sµß.±.wì*Ë¸.JÂíP¨^G?Y»^Q^?..q4.P.Ðò.=q.1D=±h^E.ÃýÏ)"^G



this is 2.6.3 + apm. I've noticed the system takes slightly longer than usual to
get back from sleep and turn on the diplay (only after hard drive 
activity). Also, the traces don't show up until it gets back from sleep.

sorry about the above garbage.

thanks,

-you

