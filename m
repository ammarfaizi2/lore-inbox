Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132531AbRDNA2r>; Fri, 13 Apr 2001 20:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132545AbRDNA2i>; Fri, 13 Apr 2001 20:28:38 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:45576 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132531AbRDNA20>; Fri, 13 Apr 2001 20:28:26 -0400
Message-Id: <200104140028.f3E0SMO07528@servant.home.lan>
Content-Type: text/plain; charset=US-ASCII
From: Malte.Starostik@t-online.de (Malte Starostik)
To: linux-kernel@vger.kernel.org
Subject: errors(?) in configuration rule files (config.in/Config.in)
Date: Sat, 14 Apr 2001 02:28:21 +0200
X-Mailer: KMail [version 1.2.1]
X-Security-Warning: All your Base Are Belong to Us!
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

first of all, I don't have much of a clue about the kernel sources as such, I 
only digged into the syntax of the config.in / Config.in files.
I'm writing a KDE GUI for configuring the Linux kernel. It works quite well 
already and will be included in KDE 2.2.

While implementing it, I came accross a few statements in some of the 
configuration rule files that are invalid according to 
Documentation/kbuild/config-language.txt. For most of them I added 
workarounds in my parser (flex/bison based), for others I just don't know how 
to handle them. Also I don't feel qualified enough to just say, this rule is 
invalid and needs to be replaced by this :(
So I just collect the ones I stumbled over to let you know:

In 2.2.18 (maybe others), but not 2.4 series:
drivers/sound/lowlevel/Config.in, lines 28-30:
            hex 'I/O base for Audio Excel DSP 16 220, 240' 
CONFIG_AEDSP16_BASE $CONFIG_SB_BASE 220
            int 'Audio Excel DSP 16 IRQ 5, 7, 9, 10, 11' 
CONFIG_AEDSP16_SB_IRQ $CONFIG_SB_IRQ 5
            int 'Audio Excel DSP 16 DMA 0, 1 or 3' CONFIG_AEDSP16_SB_DMA 
$CONFIG_SB_DMA 0

those contain two default values? For now I made the parser ignore the 
$CONFIG_SB_* defaults and use the immediate numbers. How should those be 
treated / could they be fixed?

In 2.4.2 at least:
drivers/char/Config.in, line 179:
tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
According to Documentation/kbuild/config-language.txt, tristate accepts no 
default value.

arch/parisc/config.in, line 28:
bool 'U2/Uturn I/O MMU' CONFIG_IOMMU_CCIO y
According to Documentation/kbuild/config-language.txt, bool accepts no 
default value.

Are bool and tristate supposed to take an optional default value or are the 
above really syntax errors?

arch/cris/config.in, line 99:
hwaddr 'Ethernet address' ELTEST_ETHADR 00408ccd0000
"hwaddr" isn't documented in config-language.txt, also I couldn't find it 
anywhere in scripts/* how should it be treaded?

arch/s390/config.in, line 47 and arch/s390x/config.in, line 50:
define CONFIG_KCORE ELF
"define" isn't documented either :(

arch/sparc64/config.in, line 200:
source drivers/message/fusion/Config.in
there is no drivers/message dir

Also there were symbols that don't start with CONFIG_ in some 
arch/XXX/config.in, I can't remember them exactly though.

Please don't take this as a rant, I'm just not sure how to correctly treat 
those lines, for now I ignore default values for bool and tristate and don't 
support cris, s390[x] and sparc64 in the configuration tool.
Thanks,
-Malte, please CC as I'm not subscribed, if neccessary I can do so however

PS: for those interested, screenshots are at 
http://malte.homeip.net/kcmlinuz.jpg and 
http://malte.homeip.net/longerhelp.jpg and the current sources (should build 
against any KDE 2.x version, at least 2.1.1 and up) at 
http://malte.homeip.net/kcmlinuz.tar.bz2
