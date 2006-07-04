Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWGDM3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWGDM3L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWGDM3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:29:11 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:19929 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S932240AbWGDM3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:29:10 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: ext4 features
To: Petr Tesarik <ptesarik@suse.cz>, Diego Calleja <diegocg@gmail.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 04 Jul 2006 14:28:05 +0200
References: <6tVcC-1e1-79@gated-at.bofh.it> <6tVcC-1e1-81@gated-at.bofh.it> <6tVcC-1e1-83@gated-at.bofh.it> <6tWib-2Ly-7@gated-at.bofh.it> <6uDdv-7bs-3@gated-at.bofh.it> <6uDGF-7Nj-47@gated-at.bofh.it> <6uDQb-8e8-9@gated-at.bofh.it> <6uDQb-8e8-13@gated-at.bofh.it> <6uE9y-d1-1@gated-at.bofh.it> <6uPom-87W-23@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1Fxk0v-0000gC-Qk@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Tesarik <ptesarik@suse.cz> wrote:

> Salvaging files would be done with a separate tool. Of course, if you
> delete more files with the same name in the same directory, you'd need
> to tell that tool which one of them you want to salvage. Yes, I really
> mean you'd have more than one deleted file with the same name in the
> directory.

> Anyway, I doubt we want such feature for ext4, because to make things
> efficient, you'd need to provide some kind of pointer from the deleted
> (but not yet purged) blocks to the corresponding file. Hard links are
> also problematic and there is a whole lot of other troubles I haven't
> even thought of.

You can add the original directory inode of the deleted file to an attribute.
The name can be stored in the same way, so you can have multiple files with
the same name in the trashcan directory. (Heuristics for the in-trashcan-name
can be e.g. the original inode number or "n-$ORIGINALNAME" if it's unique,
but just using the number will be good enough.)

Using the directory inode you can follow the '..'-chain to the root in order
to present a nice 'original' name, but you should also be able to undelete
files into any directory (even chroots) if both the trashcan and the target
directory are visible and you've got apropiate permissions.

BTW: If you're using the trashcan on linked files, you will need to store
multiple sources for an inode.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
