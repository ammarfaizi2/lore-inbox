Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131692AbRCOMet>; Thu, 15 Mar 2001 07:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131693AbRCOMek>; Thu, 15 Mar 2001 07:34:40 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:18703 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S131690AbRCOMea>; Thu, 15 Mar 2001 07:34:30 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: Andreas Dilger <adilger@turbolinux.com>
cc: Dave Kleikamp <shaggy@austin.ibm.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
Message-ID: <CA256A10.0044EAF4.00@d73mta03.au.ibm.com>
Date: Thu, 15 Mar 2001 17:51:36 +0530
Subject: Re: (struct dentry *)->vfsmnt;
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>Actually, I'm pretty sure you _never_ need to exportvg in order to have
>it work on another system.  That's one of the great things about AIX LVM,
>because it means you can move a VG to another system after a hardware
>problem, and not have any problems importing it (journaled fs also helps).
>AFAIK, the only think exportvg does is remove VG information from the
>ODM and /etc/filesystems.
>

Yes that's correct as far as I know too. The VGDA and LVCB contain all the
information required for import even without an exportvg.

>I suppose it is possible that because AIX is so tied into the ODM and
>SMIT, that it updates the VGDA mountpoint info whenever a filesystem
>mountpoint is changed, but this will _never_ work on Linux because of
>different tools versions, distributions, etc.  Also, it would mean on
>AIX that anyone editing /etc/filesystems might have a broken system at
>vgimport time (wouldn't be the first time that not using ODM/SMIT caused
>such a problem).

Yes, you can think of crfs (or chfs) as a composite command that handles
this (writing to LVCB. These are more like
administrative/setup/configuration commands -- one time, or occasional
system configuration changes.

On the other hand a mount doesn't cause a persistent configuration
information change. You can issue a mount even if an entry doesn't exist in
/etc/filesystems.

>
>> ... I do think that the LVM is a reasonable place to store this kind of
>> information.
>
>Yes, even though it would tie the user into using a specific version of
>mount(), I suppose it is a better solution than storing it inside the
>filesystem.  It will work with non-ext2 filesystems, and it also allows
>you to store more information than simply the mountpoint (e.g. mount
>options, dump + fsck info, etc).  In the end, I will probably just
>save the whole /etc/fstab line into the LV header somewhere, and extract
>it at importvg time (possibly with modifications for vgname and
mountpoint).
>
>Cheers, Andreas

Is mount the right time to do this ? A mount happens on every boot of the
system.
And then, one can issue a mount by explicitly specifying all the parameters
without having an entry in fstab. [Doesn't that also mean that you have a
possibility of inconsistency even here ?]



