Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131424AbRC1MEC>; Wed, 28 Mar 2001 07:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131587AbRC1MDx>; Wed, 28 Mar 2001 07:03:53 -0500
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:62712 "EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP id <S131424AbRC1MDi>; Wed, 28 Mar 2001 07:03:38 -0500
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: "Johan Kullstam" <kullstam@ne.mediaone.net>, linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t
Date: Wed, 28 Mar 2001 05:57:11 -0600
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
References: <E14i0u8-0004N1-00@the-village.bc.nu> <3AC1109A.8459E52@transmeta.com> <m2snjyk0il.fsf@euler.axel.nom>
In-Reply-To: <m2snjyk0il.fsf@euler.axel.nom>
MIME-Version: 1.0
Message-Id: <01032806025400.11349@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Johan Kullstam wrote:
>"H. Peter Anvin" <hpa@transmeta.com> writes:
>
>> Alan Cox wrote:
>> >
>> > > Another example: all the stupid pseudo-SCSI drivers that got their own
>> > > major numbers, and wanted their very own names in /dev. They are BAD for
>> > > the user. Install-scripts etc used to be able to just test /dev/hd[a-d]
>> > > and /dev/sd[0-x] and they'd get all the disks. Deficiencies in the SCSI
>> >
>> > Sorry here I have to disagree. This is _policy_ and does not belong in the
>> > kernel. I can call them all /dev/hdfoo or /dev/disc/blah regardless of
>> > major/minor encoding. If you dont mind kernel based policy then devfs
>> > with /dev/disc already sorts this out nicely.
>> >
>> > IMHO more procfs crud is also not the answer. procfs is already poorly
>> > managed with arbitary and semi-random namespace. Its a beautiful example of
>> > why adhoc naming is as broken as random dev_t allocations. Maybe Al Viro's
>> > per device file systems solve that.
>> >
>>
>> In some ways, they make matters worse -- now you have to effectively keep
>> a device list in /etc/fstab.  Not exactly user friendly.
>>
>> devfs -- in the abstract -- really isn't that bad of an idea; after all,
>> device names really do specify an interface.  Something I suggested also,
>> at some point, was to be able to pass strings onto character device
>> drivers (so that if /dev/foo is a char device, /dev/foo/bar would access
>> the same device with the string "bar" passed on to the device driver --
>> this would help deal with "same device, different options" such as
>> /dev/ttyS0 versus /dev/cua0 -- having flags to open() is really ugly
>> since there tends to be no easy way to pass them down through multiple
>> layers of user-space code.)
>>
>> The problems with devfs (other than kernel memory bloat, which is pretty
>> much guaranteed to be much worse than the bloat a larger dev_t would
>> entail) is that it needs complex auxilliary mechanisms to make
>> "chmod /dev/foo" work as expected (the change to /dev/foo is to be
>> permanent, without having to edit some silly config file)
>
>the permanent storage for a PC computer is naturally the hard disk.
>you could always make a device partition to store persistant state.  i
>think a few megabytes should be enough.  it could be substatially less
>if you had good defaults and disk storage was only used to override
>the default.
>
>of course, using disk brings us full circle back to device nodes on
>filesystem.  the impetus behind devfs was never (afaict) saving disk
>space or getting around slow disk access.  people want device nodes to
>appear automatically and go away again when drivers are removed.
>
>i think what all this means is that between kernel and collection of the
>user space programs the filesystem semantics just doesn't have enough
>going for it in order to do all that you want with devices.
>
>it might be a mostly userspace solvable problem.  a device daemon
>could create new devices on the fly, only they'd be ordinary
>filesystem devices.  for example it might be better to hack ls to not
>show dormant devices.  a cronjob could call a grim device reaper to
>cull nodes not used for a long time...
>
>what do other vaguely unix-like systems do?  does, say, plan9 have a
>better way of dealing with all this?

IRIX allows the partition (logical volume identification) to list
every volumn name as a device. Then you can mount via the name. Disks
can be relocated while the system is shutdown and the mounts still
work after boot.

My suggestion would be to add a filesystem label (optional) to the
homeblock of all filesystmes, then load that identifier into the
/proc/partitions file. This would allow a search to locate the
device parameters for any filesystem being mounted. If the label
is unavailable, then it must be mounted manually or via the current
structure. This would work for floppy/CD/DVD (although SCSI versions
would have a relocation problem for these devices).

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
