Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWGEWlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWGEWlm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 18:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWGEWlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 18:41:42 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:40094 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S964974AbWGEWlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 18:41:42 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: ext4 features
To: Lew Palm <lew@tzi.de>, "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Thu, 06 Jul 2006 00:40:58 +0200
References: <6tVcC-1e1-79@gated-at.bofh.it> <6tVcC-1e1-81@gated-at.bofh.it> <6tVcC-1e1-83@gated-at.bofh.it> <6tWib-2Ly-7@gated-at.bofh.it> <6uDdv-7bs-3@gated-at.bofh.it> <6uDGF-7Nj-47@gated-at.bofh.it> <6uDQb-8e8-9@gated-at.bofh.it> <6uDQb-8e8-13@gated-at.bofh.it> <6uE9y-d1-1@gated-at.bofh.it> <6uEMp-1gr-41@gated-at.bofh.it> <6uUo2-6SN-5@gated-at.bofh.it> <6uW6v-15i-19@gated-at.bofh.it> <6vfLY-4K5-33@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1FyG3b-00015e-Js@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lew Palm <lew@tzi.de> wrote:
> Jeffrey V. Merkey wrote:

>> The old novell model is simple. When someone unlinks a file, don't
>> delete it, just mv it to another special directory called DELETED.SAV.
>> Then setup the
>> fs space allocation to reuse these files when the drive fills up by
>> oldest files first. It's very simple. Then you have a salvagable file
>> system.
> 
> A complete foolproof car is a car with a maximum speed of 0 mph.
> As a user I give commands to my computer, for example an order to delete a
> file. And this is what I expect it to do.

You don't delete a file but a filename, and that's what your system will
still do. 

> If I want it to move a file to another position in the filesystem, I would
> use another command. I don't want my operating system to josh me, that's why
> I use Linux.
> Stealthy keeping of deleted files somewhere is a security black hole.

Depending on unlinked file to be inaccessible and never have been copied
just because you called unlink is the real security hole.

> But accidents happen. Hardware perishes, users are making mistakes, sometimes
> coffee is pouring...
> That's why we backup important data regulary.

And the salvaging fs will do exactly this whenever you unlink() the final
reference. You could also use a userspace library catching each unlink call,
but it would also have to intercept each write() call for each user and
try to reclaim the backup copies on disk-full and would-have-to-fragment
events. Off cause there are no userspace-visible would-have-to-fragment
events, so besides being ugly a userspace solution would not be able to
completely provide the same service.

> A not-really-deleting-filesystem wouldn't relieve us of that duty, but would
> make a system more insecure and ambiguous.

It's just a marginal shift. If you can't trust yourself, you've lost. If
you can't trust the current root, you're screwed, too. If you can't trust
a future root, the time window in which the file can be recovered will
slightly increase and the needed knowledge will be reduced. Otherwise, there
is no change.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
