Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWHQMbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWHQMbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWHQMbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:31:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:55015 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932290AbWHQMbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:31:19 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
To: Arjan van de Ven <arjan@infradead.org>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Dirk <noisyb@gmx.net>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Thu, 17 Aug 2006 14:27:34 +0200
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it> <6KyCQ-1w7-25@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GDgyZ-0000jV-MV@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
> On Wed, 2006-08-16 at 14:37 -0400, Lennart Sorensen wrote:

>> Perhaps the real problem is that some @#$@#$ user space task is
>> constantly trying to mount the disc while something else is trying to
>> write to it.
>> 
>> gnome and kde both seem very eager to implement such things.  perhaps
>> there should be a way to prevent any access by such processes while
>> writing to the disc.
> 
> there is. O_EXCL works for this.
> Any sane desktop app and cd burning app use O_EXCL already for this
> purpose...

This was discussed to death:

HAL using O_EXCL will randomly prevent burning/mounting/etc by causing a
race condition, so it can't do that. HAL not using O_EXCL will OTOH succeed
in opening despite of O_EXCL used by the burning process and thereby
prevent burning by opening a busy device. The proposed solution was
introducing O_NONE or O_HARMLESS to prevent side-effects from opening
the device.

This will, however, not prevent other users from maliciously destroying the
CD by not using O_EXCL. Chowning the device is not a real solution, since
users should be able to fusermount the CD.

Maybe it's possible to cache the result and thereby prevent repeated
opening from disturbing the burning process.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
