Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276453AbRI2HzK>; Sat, 29 Sep 2001 03:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276457AbRI2HzA>; Sat, 29 Sep 2001 03:55:00 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:50706 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S276453AbRI2Hyu>;
	Sat, 29 Sep 2001 03:54:50 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200109290755.f8T7t7R443599@saturn.cs.uml.edu>
Subject: Re: swsusp: move resume before mounting root [diff against vanilla 2.4.9]
To: pavel@suse.cz (Pavel Machek)
Date: Sat, 29 Sep 2001 03:55:07 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20010928224001.B1100@bug.ucw.cz> from "Pavel Machek" at Sep 28, 2001 10:40:01 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
> [Albert Cahalan]
>> [Pavel Machek]

>>> I can't do that: open deleted files.
>>
>> Tough luck. Either use the same hack as NFS, or have such files
>> return -EIO for all operations and give SIGBUS for mappings.
>> Maybe just refuse to suspend when there are open deleted files.
>> Oh, just create a name in the filesystem root and use that.
>> Something like ".8fe4a979.swsusp" would be fine. Whatever!
>
> ...and break locking and similar stuff. NFS is not as good as local
> filesystem.

Oh well. Network connections die and real-time apps fail too.
It is important to have safe and useful behavior in the presence
of arbitrary filesystem modifications. It is very nice to be able
to use suspend/resume to alternate between two running kernels.

I wouldn't worry about locking. Write/discard all data on suspend,
then examine the inode on resume. As long as the inode doesn't
change by more than the atime, the lock can survive.
