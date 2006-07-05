Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWGEOZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWGEOZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 10:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWGEOZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 10:25:44 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:32130 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S964874AbWGEOZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 10:25:43 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: ext4 features (salvage)
To: artusemrys@sbcglobal.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Wed, 05 Jul 2006 16:09:19 +0200
References: <6tVcC-1e1-79@gated-at.bofh.it> <6tVcC-1e1-81@gated-at.bofh.it> <6tVcC-1e1-83@gated-at.bofh.it> <6tWib-2Ly-7@gated-at.bofh.it> <6uDdv-7bs-3@gated-at.bofh.it> <6uDGF-7Nj-47@gated-at.bofh.it> <6uDQb-8e8-9@gated-at.bofh.it> <6uDQb-8e8-13@gated-at.bofh.it> <6uE9y-d1-1@gated-at.bofh.it> <6uPom-87W-23@gated-at.bofh.it> <6uRq6-2Dl-9@gated-at.bofh.it> <6uRJx-30t-5@gated-at.bofh.it> <6uVN4-AN-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1Fy84X-0000p0-JD@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Frost <artusemrys@sbcglobal.net> wrote:

> We silently keep files around in many filesystems, at least until
> whatever reclamation process runs.  The delete event doesn't itself
> generally purge the data from disk.  However, this is a matter of simple
> tools doing simple things.  Designing an intentional structure around
> not actually deleting deleted files, but keeping them around just in
> case may be lauded as "user-friendly", but it is counter-intuitive.  It
> is cleverness over clarity, good design smothered under feature demand.

[...]

> If you have to add a "really delete, I mean it" command, you're breaking
> fundamental assumptions.

Even without the patch, you can't guarantee that nobody will create a link
just before the supposed-to-be-final unlink(), or copies the file around.
Having undelete() will just make this risk very obvious.

BTW: If you really want to delete files, use shred.


[...]
> Why add non-free space to the free space count, when we're intentionally
> keeping those files?  If you have to be counter-intuitive, why go the
> second counter of hiding it from the user who "wants us to keep and
> index his deleted files"?

It is free space, but it can be unfreed in order to
a) restore the data (on demand)
b) store new data (automatically, no tool needed)

If b happens before a, it's called bad luck.

This concept is fundamentally different from keeping a recycle bin
of 10 % disksize for each of the 20 users (adding up to 200 % of the
disk size), which is well-known from a colorfull "operating" system.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
