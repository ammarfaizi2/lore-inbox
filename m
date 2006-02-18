Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWBROiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWBROiM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 09:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWBROiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 09:38:12 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:20221 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP id S1751265AbWBROiM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 09:38:12 -0500
Message-ID: <43F7310E.4070109@pg.gda.pl>
Date: Sat, 18 Feb 2006 15:37:02 +0100
From: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
Organization: =?UTF-8?B?R2RhxYRzayBVbml2ZXJzaXR5IG9mIFRlY2hub2xvZ3k=?=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pl-PL; rv:1.7.12) Gecko/20050915
X-Accept-Language: pl, en, en-us
MIME-Version: 1.0
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
CC: torvalds@osdl.org, bug-ncurses@gnu.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
References: <20060217233333.GA5208@sunrise.pg.gda.pl> <43F72A1E.1090707@ums.usu.ru>
In-Reply-To: <43F72A1E.1090707@ums.usu.ru>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Użytkownik Alexander E. Patrakov napisał:
> Adam Tla/lka wrote:
> 
>> This patch applies to 2.6.15.3 kernel sources to drivers/char/vt.c file.
>> It should work with other versions too.
>>
>> Changed console behaviour so in UTF-8 mode vt100 alternate character
>> sequences work as described in terminfo/termcap linux terminal 
>> definition.
>> Programs can use vt100 control seqences - smacs, rmacs and acsc  
>> characters
>> in UTF-8 mode in the same way as in normal mode so one definition is 
>> always
>> valid - current behaviour make these seqences not working in UTF-8 mode.
> 
> 
> Doesn't work here with linux-2.6.16-rc3-mm1, ncurses-5.5. BTW has this 
> been discussed with Thomas Dickey (ncurses maintainer)?
>

Hmm, I don't know how current ncurses treat terminfo definition in UTF-8 
mode and what linux terminal definition you are using in you test 
system. There are different definitions floating around in different 
distributions which are slightly different especially as we talk about 
acsc chars and enacs, smacs and rmacs sequences. Which is also wrong 
approach so there should be one proper definition of the linux console. 
Maybe kernel developers should prepare some most compatible and 
acceptable one.
I can post the one I am using today:

#       Reconstructed via infocmp from file: /etc/terminfo/l/linux
linux|linux console,
         am, bce, ccc, eo, mir, msgr, xenl, xon,
         colors#8, it#8, ncv#18, pairs#64,
 
acsc=++\,\,--..00__``aaffgbhhjjkkllmmnnooqqssttuuvvwwxxyyzz{{||}c~~,
         bel=^G, blink=\E[5m, bold=\E[1m, civis=\E[?25l\E[?1c,
         clear=\E[H\E[J, cnorm=\E[?25h\E[?0c, cr=^M,
         csr=\E[%i%p1%d;%p2%dr, cub1=^H, cud1=^J, cuf1=\E[C,
         cup=\E[%i%p1%d;%p2%dH, cuu1=\E[A, cvvis=\E[?25h\E[?8c,
         dch=\E[%p1%dP, dch1=\E[P, dim=\E[2m, dl=\E[%p1%dM,
         dl1=\E[M, ech=\E[%p1%dX, ed=\E[J, el=\E[K, el1=\E[1K,
         enacs=\E)0, flash=\E[?5h\E[?5l$<200/>, home=\E[H,
         hpa=\E[%i%p1%dG, ht=^I, hts=\EH, il=\E[%p1%dL, il1=\E[L,
         ind=^J,
 
initc=\E]P%p1%x%p2%{256}%*%{1000}%/%02x%p3%{256}%*%{1000}%/%02x%p4%{256}%*%{1000}%/%02x,
         invis=\E[8m, kb2=\E[G, kbs=\177, kcbt=\E[Z, kcub1=\E[D,
         kcud1=\E[B, kcuf1=\E[C, kcuu1=\E[A, kdch1=\E[3~,
         kend=\E[4~, kf1=\E[[A, kf10=\E[21~, kf11=\E[23~,
         kf12=\E[24~, kf13=\E[25~, kf14=\E[26~, kf15=\E[28~,
         kf16=\E[29~, kf17=\E[31~, kf18=\E[32~, kf19=\E[33~,
         kf2=\E[[B, kf20=\E[34~, kf3=\E[[C, kf4=\E[[D, kf5=\E[[E,
         kf6=\E[17~, kf7=\E[18~, kf8=\E[19~, kf9=\E[20~,
         khome=\E[1~, kich1=\E[2~, kmous=\E[M, knp=\E[6~, kpp=\E[5~,
         kspd=^Z, nel=^M^J, oc=\E]R, op=\E[39;49m, rc=\E8, rev=\E[7m,
         ri=\EM, rmacs=^O, rmam=\E[?7l, rmir=\E[4l, rmpch=\E[10m,
         rmso=\E[27m, rmul=\E[24m, rs1=\Ec\E]R, sc=\E7,
         setab=\E[4%p1%dm, setaf=\E[3%p1%dm,
 
sgr=\E[0;10%?%p1%t;7%;%?%p2%t;4%;%?%p3%t;7%;%?%p4%t;5%;%?%p5%t;2%;%?%p6%t;1%;%?%p7%t;8%;m%?%p9%t\016%e\017%;,
         sgr0=\E[0;10m, smacs=^N, smam=\E[?7h, smir=\E[4h,
         smpch=\E[11m, smso=\E[7m, smul=\E[4m, tbc=\E[3g,
         u6=\E[%i%d;%dR, u7=\E[6n, u8=\E[?6c, u9=\E[c,
         vpa=\E[%i%p1%dd,

If using this definition and my patch applied acsc mode is not working 
then there is something wrong in curses code IMHO.
I am using Ubuntu distro and with this patch and this definition
aptitude properly displays semigraphics in UTF-8 mode and Midnight
Commander also works almost correctly (almost because it is not properly
ported - it displays help using iso-8859-2 help file without conversion
to UTF-8 so I can see replacement glyphs as it should be but in options
and menu it uses UTF-8 but incorrectly counts bytes instedad of glyphs
so screen is not looking properly if there is a multibyte UTF-8 seqence
used in a line; anyway it's MC bad code not terminal fault).

Regards
-- 
Adam Tlałka       mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group       - - - ~~~~~~
Computer Center,  Gdańsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl
