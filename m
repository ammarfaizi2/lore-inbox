Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbUJZRV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbUJZRV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbUJZRV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:21:57 -0400
Received: from zamok.crans.org ([138.231.136.6]:32992 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261354AbUJZRVw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:21:52 -0400
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1: LVM stopped working
References: <87oeitdogw.fsf@barad-dur.crans.org>
	<58cb370e041026070067daa404@mail.gmail.com>
	<58cb370e0410261007145fc22c@mail.gmail.com>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Tue, 26 Oct 2004 19:21:50 +0200
In-Reply-To: <58cb370e0410261007145fc22c@mail.gmail.com> (Bartlomiej
	Zolnierkiewicz's message of "Tue, 26 Oct 2004 19:07:45 +0200")
Message-ID: <87is8xl7ip.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> disait dernièrement que :

> To make this task easier I prepared 2.6.9-rc3-mm3 to 2.6.9-mm1 IDE patch:
>
> http://home.elka.pw.edu.pl/~bzolnier/ide-2.6.9-rc3-mm3-to-2.6.9-mm1.patch.bz2
>
> Just revert it from 2.6.9-mm1.

thx, I will test it soon.
I have just made straces of vgchange processes in success and failure cases
(there is little difference in the fact that in the failure case, I added
-v verbose option but that's all)

vgchange tries to read 2 chunks of data from the partition:
- the first 2048 bytes,
- and after closing device, and reopening it, the 512 next ones.

in the failure case, the first read succeeds with just 1536 bytes read,
which causes the process to issue another read syscall to read the "missing"
512 bytes, which fails...

for now, that's all I can see
I will enable lvm debugging, for the next try

the straces are:
http://www.crans.org/~segaud/vgchange.failure
http://www.crans.org/~segaud/vgchange.succeeded
(names are obvious)

Best regards,

Mathieu

-- 
"I am a living example of someone who took on an issue and benefited from it."

George W. Bush
April 25, 2001
Speaking to John King of CNN.

