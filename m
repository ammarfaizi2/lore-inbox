Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130401AbRAKDJa>; Wed, 10 Jan 2001 22:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbRAKDJV>; Wed, 10 Jan 2001 22:09:21 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:43938 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S130642AbRAKDJF>; Wed, 10 Jan 2001 22:09:05 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 10 Jan 2001 19:08:53 -0800
Message-Id: <200101110308.TAA09252@adam.yggdrasil.com>
To: parsley@linuxjedi.org, torvalds@transmeta.com
Subject: Re: [PATCH] one-liner fix for bforget() honoring BH_Protected; was: Re: Patch (repost): cramfs memory corruption fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: "David L. Parsley" <parsley@linuxjedi.org>

>Linus Torvalds wrote:

>> On Sat, 6 Jan 2001, Adam J. Richter wrote:
>> >
>> >       This sounds like a bug that I posted a fix for a long time ago.
>> > cramfs calls bforget on the superblock area, destroying that block of
>> > the ramdisk, even when the ramdisk does not contain a cramfs file system.
>> > Normally, bforget is called on block that really can be trashed,
>> > such as blocks release by truncate or unlink.
>> 
>> I'd really prefer just not letting bforget() touch BH_Protected buffers.
>> bforget() is also used by other things than unlink/truncate: it's used by
>> various partition codes etc, and it's used by the raid logic.

>Yup, I backed out Adam's one-liner in favor of the attached one-liner. 
>Tested on 2.4.0, but should patch cleanly to just about anything. ;-)

	Applying Linus's patch is fine, but I think my patch should also
be applied (in addition), although for a less important reason.  The
bforget in cramfs is going to force unnecessary device IO if cramfs
is in the list of file systems that you are trying to detect when
mounting a file system from a physical device.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
