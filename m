Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUITMKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUITMKH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 08:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266345AbUITMKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 08:10:07 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:10191 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S266349AbUITMJu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 08:09:50 -0400
Date: Mon, 20 Sep 2004 14:11:54 +0200
From: DervishD <lkml@dervishd.net>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Andreas Schwab <schwab@suse.de>, Olaf Hering <olh@suse.de>,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920121154.GJ5684@DervishD>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Andreas Schwab <schwab@suse.de>, Olaf Hering <olh@suse.de>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de> <jeoek1xn9p.fsf@sykes.suse.de> <20040920105409.GH5482@DervishD> <jek6upxj1a.fsf@sykes.suse.de> <414EC43B.8040507@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <414EC43B.8040507@grupopie.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-PopBeforeSMTPSenders: raul@dervishd.net
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Paulo :)

 * Paulo Marques <pmarques@grupopie.com> dixit:
> >>>>- fix all broken apps that still rely on mtab. like GNU df(1)
> >>>df does not rely on /etc/mtab.  It relies on getmntent.
> >>   Then my GNU df has any problem :???
> >No, if any then getmntent.
> I don't get this. From "man getmntent" it seems that getmntent is just a 
> parser for /etc/mtab, and that you must call "setmntent" with the 
> filename you want to parse.

    From the code of coreutils 5.2.1, lib/mountlist.c, df uses the
default name for the mounted filesystems table. Under glibc, it uses
_PATH_MOUNTED that is, effectively, "/etc/mtab". BTW, 'MOUNTED' is
shown in glibc headers as a deprecated alias.

> So if you do "setmntent("/etc/mtab",...)" you're explicitly saying
> that you want getmntent to use /etc/mtab. This is just a open/read
> in disguise.
> Am I missing something?

    Maybe: df (well, lib/mountlist.c) shouldn't try to 'detect' which
kernel are you running, if one with /etc/mtab or a newer one that
only supports /proc/mounts (which needs procfs support, BTW, and that
can be a problem too). Is glibc who should do all that, and try to
open /etc/mtab and /proc/mounts, in that order. Being a userspace
app, df should not mess with kernel interface changes. In the worst
case, it *could* try to open /etc/mtab (with setmntent, I mean) and
if that fails, open /proc/mounts if the operating system is Linux
(which can be easily decided at './configure' time).

    I'm really not sure about what should be fixed. IMHO, getmntent
should only try to open _PATH_MOUNTED. Any other desired behaviour
should be set using setmntent. Just my 0,02 EUR.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
