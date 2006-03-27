Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWC0WGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWC0WGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 17:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWC0WGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 17:06:15 -0500
Received: from canuck.infradead.org ([205.233.218.70]:13806 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751501AbWC0WGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 17:06:13 -0500
Message-ID: <442861C4.7080304@torque.net>
Date: Mon, 27 Mar 2006 17:05:56 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: Bodo Eggert <7eggert@gmx.de>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Move SG_GET_SCSI_ID from sg to scsi
References: <Pine.LNX.4.58.0603061133070.2997@be1.lrz> <440C8E60.6020005@torque.net> <440D9F8E.7050402@s5r6.in-berlin.de>
In-Reply-To: <440D9F8E.7050402@s5r6.in-berlin.de>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> Douglas Gilbert wrote:
> 
>> In linux there is also a move away from the host_number,
>> channel_number, target_identifier and LUN tuple used
>> traditionally by many Unix SCSI subsystems (most do not
>> have the second component: channel_number). At least the
>> LUN is not controversial (as long as it is 8 byte!). The
>> target_identifier is actually transport dependent (but
>> could just be a simple enumeration). The host_number is
>> typically an enumeration over PCI addresses but some
>> other type of computer buses (e.g. microchannel) could be
>> involved.
> 
> 
> For some transports, not only the channel but also the Scsi_Host is
> meaningless. Such transports deal only with targets and logical units.
> This includes all multi-protocol + multi-bus or network infrastructures
> such as iSCSI, USB, IEEE 1394.

Stefan,
I have been reviewing this thread and had one point
to add here.

The identity of the initiator port is important, at
least to a SCSI target that can implement (PERSISTENT)
RESERVE on behalf of one of its logical units.
So you may need to keep the equivalent of Scsi_Host:this_id
somewhere.

That is another shortcoming of the <hctl> tuple: the
initiator port isn't there.

Doug Gilbert
