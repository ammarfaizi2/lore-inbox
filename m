Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291014AbSBLM50>; Tue, 12 Feb 2002 07:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291019AbSBLM5R>; Tue, 12 Feb 2002 07:57:17 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:61706 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291014AbSBLM5D>; Tue, 12 Feb 2002 07:57:03 -0500
Date: Tue, 12 Feb 2002 13:57:01 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020212135701.A16420@suse.cz>
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <20020212132846.A7966@suse.cz> <3C690E56.3070606@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C690E56.3070606@evision-ventures.com>; from dalecki@evision-ventures.com on Tue, Feb 12, 2002 at 01:45:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 01:45:10PM +0100, Martin Dalecki wrote:

>>> The first does control an array of values, which doesn't make sense in 
>>> first place. I.e. changing it doesn't
>>> change ANY behaviour of the kernel.

>> Actually HFS uses it ...

> Please note that the use in HFS is inappriopriate. It's supposed to
> optimize the read throughput there, which is something that shouldn't
> be done at the fs setup layer at all. The usage of read_ahead there
> can be just removed and everything should be fine (modulo the fact
> that in current state the HFS filesystem code is just non-working
> obsolete code garbage anyway ;-).

Yes; I just commented on that it does change some behavior of the
kernel.

>>> The second of them is trying to control a file-system level constant
>>> inside the actual block device driver. This is a blatant violation of
>>> the layering principle in software design, and should go as soon as
>>> possible.

>> Yes. But still block device drivers allocate the array ...

> Well if we do:
> 
> find ./ -name "*.c" -exec grep max_readahead /dev/null {} \;
> 
> One can already easly see that apart from ide, md, and acorn drivers
> this has been already abstracted away one level up at the block device
> handling as well. My suspiction is that there is now already *double*
> initialization of the sub-slices of this array there. Anyway ide
> should be adapted here to the same way as it's done now for scsi.
> 
> Will you look after this or should me? (I can't until afternoon,
> becouse I'm at my "true live" job now and have other things to do...)

Am I understanding you correctly that we can just remove the
max_readahead references in IDE (and possibly also md and acorn)?

-- 
Vojtech Pavlik
SuSE Labs
