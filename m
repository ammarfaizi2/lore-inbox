Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUITK5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUITK5l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 06:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUITK5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 06:57:41 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:52420 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S266223AbUITK5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 06:57:36 -0400
Date: Mon, 20 Sep 2004 12:59:50 +0200
From: DervishD <lkml@dervishd.net>
To: Olaf Hering <olh@suse.de>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920105950.GI5482@DervishD>
Mail-Followup-To: Olaf Hering <olh@suse.de>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040920094602.GA24466@suse.de>
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

    Hi Olaf :)

 * Olaf Hering <olh@suse.de> dixit:
> > then /etc/mtab can die. Comments? Better solutions?
> Andries, /etc/mtab is obsolete since the day when /proc/self/mounts was
> introduced. So, kill it today from your mount binary! TODAY. ...

    Bad idea... ;))) I upgraded my 'mount' yesterday. I was using a
mount from Debian, from 1998 more or less, that worked flawlessly
except for the '--bind' feature and things like those. I used
/etc/mtab as a symlink to /proc/mounts, and all worked OK except for
the double root entry and the need to manually call losetup to delete
unused /dev/loop entries.

    But after the upgrade I no longer could umount a filesystem that
I mounted as 'user', because the device is a symlink and the 'user'
option is not stored in /proc/mounts. So my problems were:

> - the 'user' option for umount must be handled in some way
> - loop mounts do not map to the real filename, users cant open the
>   device node to run losetup on it. I think it will also get relative
>   path names.
> - fix all broken apps that still rely on mtab. like GNU df(1)

    Exactly!!! I will add the double root filesystem entry (one from
the device, the other one being 'rootfs / rootfs rw 0 0'). Until all
these problems are solved, is not a good idea to remove /etc/mtab :(

    I have another issue with a chroot environment I have, which has
its own copy of proc and devpts mounted. Those appear in /proc/mounts
twice, but not in /etc/mtab (they appear in the /etc/mtab copy of the
chroot env).

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
