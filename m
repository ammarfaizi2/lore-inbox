Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290276AbSBLTXL>; Tue, 12 Feb 2002 14:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290503AbSBLTXC>; Tue, 12 Feb 2002 14:23:02 -0500
Received: from mailc.telia.com ([194.22.190.4]:15560 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S290276AbSBLTWw>;
	Tue, 12 Feb 2002 14:22:52 -0500
Message-Id: <200202121922.g1CJMPi23466@mailc.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Pavel Machek <pavel@suse.cz>
Subject: Re: another IDE cleanup: kill duplicated code
Date: Tue, 12 Feb 2002 20:19:14 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Jens Axboe <axboe@suse.de>, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com>
In-Reply-To: <3C68F3F3.8030709@evision-ventures.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday den 12 February 2002 11.52, Martin Dalecki wrote:
>
> If you are already at it, I would like to ask to you consider seriously
> the removal of the
> following entries in the ide drivers /proc control files:
>
> [snip]
>     ide_add_setting(drive,    "file_readahead",   ...
> &max_readahead[major][minor],    NULL);
>
> Those calls can be found in ide-cd.c, ide-disk,c and ide-floppy.c
>
> [snip]
>
> The second of them is trying to control a file-system level constant
> inside the actual block device driver.
> This is a blatant violation of the layering principle in software
> design, and should go as soon as
> possible.

It really should go (the only one working is for ide-disk) but
you need to add another way to tune readahead per disk too...

Tuning this parameter gives quite a bit improved performance
when reading from several big files at a time! A diff of two big files
is enough to show it: from 10MB/s to 25MB/s (2.4.17-rc1)
(due to less time lost seeking)

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
