Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbUDUVwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUDUVwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 17:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUDUVwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 17:52:34 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:8106 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261735AbUDUVwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 17:52:32 -0400
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: The missing RAID level
References: <045P8FJ12@server5.heliogroup.fr>
From: Junio C Hamano <junkio@cox.net>
Date: Wed, 21 Apr 2004 14:52:30 -0700
In-Reply-To: <fa.eu3v38b.10meq3@ifi.uio.no> (Hubert Tonneau's message of
 "Tue, 20 Apr 2004 22:18:29 GMT")
Message-ID: <7v4qrddmn5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "HT" == Hubert Tonneau <hubert.tonneau@fullpliant.org> writes:

HT> So, one very interesting possibility would be to have an
HT> extra RAID level that would do the following:

HT> assuming that you connect 5+1 partitions, then you get 5 md
HT> partitions, not a single one, with the following properties:

HT> . any read to mdX goes straight forward to reading the
HT> underlying partition.

HT> . any write goes staight forward to writting the underlying
HT> partition, but also updates the parity on the extra
HT> partition.

It seems to me that you can create a single RAID-4 device out of
5 data and 1 parity disks, and run device mapper on top of that
RAID-4 device, picking every 6 chunk worth of data and
collecting into a device (totalling 6 devices).  The first 5
such device mapper devices would end up with blocks from the
underlying 5 data disks.  I do not know offhand if such a dm
target already exists, though.


