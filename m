Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266469AbUAIKLO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 05:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266471AbUAIKLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 05:11:14 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:33677 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266469AbUAIKLN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 05:11:13 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Date: 09 Jan 2004 10:49:03 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87wu81tptc.fsf@bytesex.org>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com> <20040109033655.GK11065@ca-server1.us.oracle.com>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1073641743 7342 127.0.0.1 (9 Jan 2004 09:49:03 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> writes:

> On Wed, Jan 07, 2004 at 10:57:00AM -0800, Greg KH wrote:
> > Hm, that would work, but what about a user program that just polls on
> > the device, as the rest of this thread discusses?  As removable devices
> > are not the "norm" it would seem a bit of overkill to create 16
> > partitions for every block device, if they need them or not.
> 
> 	Um, adding all 16 partitions for a block device that has 5
> defined is opposite of the intention of udev, no?

It shouldn't be _that_ bad.

removable media devices usually tell you that they are removable media
devices (scsi: inquiry data has a bit for that IIRC).  If you pass
this up to hotplug it can use that to figure whenever it has a hard
disk (=> just create the existing partitions) or a removable device
(=> create a few more nodes to catch the usual removable media
layouts).

I also think you don't need *all* minors for removable media.  I
havn't seen removable media with extended partitions so far.  IIRC zip
floppys are using /dev/sda4 and most other ones either /dev/sda1 or
/dev/sda directly, so we likely can catch 99% with just three device
nodes.

  Gerd

-- 
You have a new virus in /var/mail/kraxel
