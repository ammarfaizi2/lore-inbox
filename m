Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267797AbUHERcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267797AbUHERcg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267802AbUHERcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:32:36 -0400
Received: from main.gmane.org ([80.91.224.249]:1951 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267797AbUHERcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:32:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Thu, 05 Aug 2004 19:32:19 +0200
Message-ID: <yw1xfz71h4nw.fsf@kth.se>
References: <200408051225.i75CPT4U004434@burner.fokus.fraunhofer.de> <20040805164510.GA5569@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:ketrLY228GwzaQ8OaX80aLAZOGE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner <wakko@animx.eu.org> writes:

> Please do keep me CCd
>
>> >ATA method is misnamed, it's really SG_IO that is used. And you want to
>> >use that regardless of the device type, SCSI or ATAPI. There's no such
>> >thing as an ATA burner, and there's no need to differentiate between
>> >SCSI or ATAPI CD-ROM's when burning - SG_IO is the method to use. So
>> >forget browsing /proc/ide and other hacks.
>> 
>> I am sorry but as Linux already has 6 different interfaces for sending 
>> Generic SCSI commands and thus, we are running out of names.
>> 
>> Let me give you an advise: consolidate Linux so that is does only need
>> /dev/sg and fix the bugs in ide-scsi instead of constantly inventing new
>> unneeded interfaces.
>
> I'd like to take this and stretch it some.
>
> First, I don't know what would be involved in doing this or if it's even
> doable (but I'd think it is).  I would like to see this happen, however, I
> understand that it may or may not.
>
> Why do we have a seperate subsystem for scsi and ide, but not usb storage
> devices?  What I mean is that usb-storage is a scsi adapter that attaches
> usb disks to the scsi layer.  I know about ide-scsi, but that's like a
> bridge that probably could be removed entirely.
>
> Now here's what I'm thinking:
>
> 1) remove the IDE subsystem entirely (keeping the IDE drivers).  This will
> eliminate the need for /dev/hd* devices and ide-scsi.
>
> 2) rename the scsi subsystem to something more generic, like disk subsystem
> (I realize that scsi can handle more than disks, like tapes, scanners, I
> even once saw a scsi ethernet adapter)
>
> 3) port all of the IDE drivers to be like a scsi adapter driver (ie fix piix
> to function similar to say aic7xxx).  To handle the fact of multiple
> interfaces on the controller (primary/secondary connectors on the board, 4
> devices total) to be seperate scsi buses.  On each bus, you'll only have 2
> IDs, 0 and 1 (corresponding to master and slave).
>
> 4) All access to the device will be like a scsi device.  For IDE devices, if
> needed, the driver (ie piix) can translate the request.

Isn't this what libata does with SATA disks?  SATA is already standard
in new machines, and within a couple of years parallel ATA is like to
be mostly obsolete.

-- 
Måns Rullgård
mru@kth.se

