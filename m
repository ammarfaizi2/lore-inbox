Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVADBXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVADBXs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 20:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVADBXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 20:23:48 -0500
Received: from dp.samba.org ([66.70.73.150]:65516 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261924AbVADBXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 20:23:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16857.61339.370059.16758@samba.org>
Date: Tue, 4 Jan 2005 12:21:31 +1100
To: "Michael B Allen" <mba2000@ioplex.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, sfrench@samba.org,
       linux-ntfs-dev@lists.sourceforge.net, samba-technical@lists.samba.org,
       aia21@cantab.net, hirofumi@mail.parknet.co.jp,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
In-Reply-To: <54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com>
References: <41D9C635.1090703@zytor.com>
	<54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,

 > If we're just thinking about MS-oriented discretionary access control then
 > I think the owner of the file is basically king and should be the only
 > normal user to that can read and write it's xattrs. So whatever namespace
 > that is (not system).

for the DACL the owner is king (the owner gets the WRITE_DAC,
READ_CONTROL and STD_DELETE access bits forced on), but for the other
parts of the full security descriptor this is not true. The owner
doesn't get to arbitrarily write to the owner_sid or SACL. Thats why I
used security.NTACL not user.NTACL.

I suppose we could have a separate user.DACL attribute, but given that
there is just one API that sets all 4 elements of the SD (with a
bitmask to say which bits to set), it made more sense to me to group
them all together. The disadvantage is that Samba needs to gain/lose
root privileges for the "set SD" call even if the client is only
asking to set the DACL.

Cheers, Tridge
