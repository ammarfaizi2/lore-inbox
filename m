Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266431AbTATRx3>; Mon, 20 Jan 2003 12:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266434AbTATRx2>; Mon, 20 Jan 2003 12:53:28 -0500
Received: from ausadmmsps306.aus.amer.dell.com ([143.166.224.101]:15371 "HELO
	AUSADMMSPS306.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S266431AbTATRx0>; Mon, 20 Jan 2003 12:53:26 -0500
X-Server-Uuid: c21c953d-96eb-4242-880f-19bdb46bc876
Message-ID: <20BF5713E14D5B48AA289F72BD372D68011A4269@AUSXMPC122.aus.amer.dell.com>
From: Gary_Lerhaupt@Dell.com
To: jerj@coplanar.net
cc: linux-kernel@vger.kernel.org
Subject: RE: Devlabel: static device naming via symlinks (improved)
Date: Mon, 20 Jan 2003 12:02:28 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 1232E63D10859765-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An interesting point.  Though, if two devices have the exact same UUID,
devlabel refuses to add a symlink to either one of them.  I will set up LVM
on a box around here and confirm this.

Gary

-----Original Message-----
From: Jeremy Jackson [mailto:jerj@coplanar.net]
Sent: Saturday, January 18, 2003 10:48 AM
To: Gary_Lerhaupt@exchange.dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Devlabel: static device naming via symlinks (improved)


I've been using EVMS (http://evms.sourceforge.net and it's snapshot
capability (as well as LVM's I assume) can create "partitions" or
volumes with duplicate fs UUIDs.  Perhaps someone using EVMS may not use
devlabel since it includes that functionality, but in the LVM case you
may want to investigate the effect of duplicate UUIDs.

Regards,

Jeremy

On Fri, 2003-01-17 at 17:15, Gary_Lerhaupt@Dell.com wrote:
> I've added a couple useful features to devlabel (available at
> http://domsch.com/linux/devlabel).  Of the foremost of these is that it
now
> includes the usage of Partition UUIDs (as provided by ext2, ext3, xfs, jfs
> or ocfs).  Since these UUIDs are partition specific, if a partition-level
> failure event occurs (eg. you delete /dev/sde6 and /dev/sde7 then becomes
> /dev/sde6), devlabel is now smart enough to handle it for the
aforementioned
> filesystem types.  If you aren't using one of these filesystem types or if
> there is no filesystem at all, devlabel will then fall back on using SCSI
> UUIDs or IDE identifiers as it used before (these support disk-wide
> failures, when /dev/sdb6 becomes /dev/sda6).
> 
> As well, devlabel now also supports automounting.  For example, with a USB
> flash reader, you should now add it to devlabel with the --automount
option.
> If --automount is specified, every time you hotplug your device, it will
> check /etc/fstab for an entry containing the symlink that you've added for
> this device, and if it finds one, it will automatically mount it.  Nice
and
> simple.
> 
> Lastly, you can also now do adds by UUID.  This is especially helpful in
> shared storage environments.  For example, you can add a symlink on the
> master node and then add by UUID on all the secondary nodes to ensure that
> the same symlink on all nodes points to the same shared storage device
> regardless of the device naming scheme of those nodes.
> 
> Gary Lerhaupt
> Linux Development
> Dell Computer Corporation
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Jeremy Jackson <jerj@coplanar.net>


