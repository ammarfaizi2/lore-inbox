Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSFRFSu>; Tue, 18 Jun 2002 01:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317330AbSFRFSt>; Tue, 18 Jun 2002 01:18:49 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:56896 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S317329AbSFRFSl>; Tue, 18 Jun 2002 01:18:41 -0400
Date: Tue, 18 Jun 2002 01:18:37 -0400
From: Doug Ledford <dledford@redhat.com>
To: Austin Gonyou <austin@digitalroadkill.net>
Cc: Kurt Garloff <kurt@garloff.de>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Possibly OT] Re: /proc/scsi/map
Message-ID: <20020618011837.B7800@redhat.com>
Mail-Followup-To: Austin Gonyou <austin@digitalroadkill.net>,
	Kurt Garloff <kurt@garloff.de>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl> <20020617180818.C30391@redhat.com> <20020617230648.GA3448@gum01m.etpnet.phys.tue.nl> <20020617224046.A6590@redhat.com> <1024370680.5490.8.camel@UberGeek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1024370680.5490.8.camel@UberGeek>; from austin@digitalroadkill.net on Mon, Jun 17, 2002 at 10:24:40PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 10:24:40PM -0500, Austin Gonyou wrote:
> Taking a bit of an example from Veritas, would it be, at all, feasible
> if n+ blocks were used at the end of the disk or partition(beginning
> maybe?), to write a specific identifier that is unique to a specific
> controller, or to make note of the drive serial number and store that on
> the disk somewhere in some agreed upon understood way. 

Both LVM and the md code already do this.  Ext2 and ext3 also have volume 
labels that can be used for this purpose.  As much as I hate to admit it, 
this is the one area where I think MicroSoft did the right thing and 
snagged an unused byte in the partition table to mark the disks ordering 
(although we would need more than one byte).  By putting it in the 
partition table, it would only need to be dealt with by one area of code 
(the partition reading code), would work for all filesystems, would work 
for all LVM and md types of code, and would be universal on linux systems 
and provide consistent, persistent device naming.  Of course, if a disk 
dies and you put a new one in, then you have to rename the new disk to the 
old disks names when you partition it, but you would have to do that or 
something similar to that with all such possible solutions.

The simple fact of the matter is that to provide truly consistent, 
persistent device naming requires that the naming be "end-to-end".  You 
can not rely on *any* ordering issues (such as controllers, PCI busses, 
devices, etc), you have to read the name from the device itself and the 
name has to be totally irrespective of the devices current location on 
whatever bus it uses.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
