Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVLCAUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVLCAUE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 19:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVLCAUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 19:20:04 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:24967 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751089AbVLCAUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 19:20:02 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: security / kbd
To: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 03 Dec 2005 01:21:51 +0100
References: <5f6Fp-1ZB-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EiLA5-0001VE-64@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <Andries.Brouwer@cwi.nl> wrote:

> Recently I muttered a little bit about the fact that everybody who
> can mount filesystems using an "auto" fstab filesystem type entry
> (or using e.g. an "ext2" entry) can crash the system.
> But nobody on lk seems impressed.
> Of course, one can always say that it is the distribution's fault,
> or the sysadmin's fault to have such fstab entries.
> Still, I think the situation can be improved.

Yes, by fixing the file systems or by implementing safe user mounts. It will
be something like fuse, maybe it will be fuse using a userspace version
of a kernel thread. Maybe not.

> On the other hand, I am told that recent kernels restrict the use of
> loadkeys to root. If so, an unfortunate choice. People want to switch
> unicode support on/off, or go from/to a dvorak keymap.
> What was the security problem?

It's global, and it can be done remotely. Therefore you can either have
remote logins or a secure console.

The correct fix would be binding the keymap to the current tty only,
resetting the console if it gets closed and not allowing init to reuse
it unless it's closed. If you do this, you'll want a default setting, too.

YANI: Root should be able to set a coloured border indicating that it's
really the getty/login process asking for the user prompt/password.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
