Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275750AbRI0DCt>; Wed, 26 Sep 2001 23:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275751AbRI0DCj>; Wed, 26 Sep 2001 23:02:39 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:18447 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S275750AbRI0DCZ>;
	Wed, 26 Sep 2001 23:02:25 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200109270302.f8R32pl12537@saturn.cs.uml.edu>
Subject: Re: swsusp: move resume before mounting root [diff against vanilla 2.4.9]
To: pavel@ucw.cz (Pavel Machek)
Date: Wed, 26 Sep 2001 23:02:51 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20010926101914.A28339@atrey.karlin.mff.cuni.cz> from "Pavel Machek" at Sep 26, 2001 10:19:14 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
> [Albert Cahalan]

>> Solution for the filesystem problems:
>>
>> 1. at suspend, basically unmount the filesystem (keep the mount tree)
>> 2. at resume, re-validate open files
>
> Wrong solution. ;-).
>
> Solution to filesystem problems: at suspend, sync but don't do
> anything more. At resume, don't try to mount anything (so that you
> don't replay transactions or damage disk in any other way).

That is totally broken, because I may mount the disk in between
the suspend and resume. I might even:

1. boot kernel X
2. suspend kernel X
3. boot kernel Y
4. suspend kernel Y
5. resume kernel X
6. suspend kernel X
7. resume kernel Y
8. suspend kernel Y
9. goto #5

You really have to close the logs and mark the disks clean
when you suspend. The problems here are similar the the ones
NFS faces. Between the suspend and resume, filesystems may be
modified in arbitrary ways.
