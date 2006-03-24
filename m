Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWCXWof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWCXWof (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 17:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWCXWof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 17:44:35 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:50365 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S932172AbWCXWoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 17:44:34 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
To: Stas Sergeev <stsp@aknet.ru>, dtor_core@ameritech.net,
       Linux kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Reply-To: 7eggert@gmx.de
Date: Fri, 24 Mar 2006 23:43:48 +0100
References: <5TCqf-E6-49@gated-at.bofh.it> <5TCqf-E6-51@gated-at.bofh.it> <5TCqf-E6-53@gated-at.bofh.it> <5TCqg-E6-55@gated-at.bofh.it> <5TCqf-E6-47@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FMv1A-0000fN-Lp@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:

> [ adding LKML to CC and removing akpm as this went into a
> discussion phase apparently ]
> 
> Dmitry Torokhov wrote:

>>> Well, the main reason behind that change, is that there is a PC-Speaker
>>> PCM driver/emulator, snd-pcsp, pending in an ALSA CVS. I can't get it
>>> included in kernel before there is a way to disable the pcspkr driver.
>> Why can't you? We have ALSA and OSS together in the kernel just fine.
> But the pcspkr driver is not an OSS, it is an "input" driver.
> 
>> If you are concerned about both modules baing active at the same time
>> do not let user compile pcspkr if snd_pcsp is selected for now.
> The problem is that the snd-pcsp doesn't replace pcspkr.

If that's the problem, create a minimal input driver that will signal the
snd-pcsp to beep, and change the original pcspkr to include "(Non-ALSA)".
Obviously both drivers will exclude each other, but that should be fine,
and users who prefer "music" over beeps will be fine, too.

And as a bonus, you might upload a custom PC beep ... but if you do, a
userspace notifyer combined with a beep-daemon might be preferable
(uinput? I know it exists ...).

Off cause I might be suggesting exactly what you did, since I didn't see
the patch.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
