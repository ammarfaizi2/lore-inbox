Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVLPN50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVLPN50 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVLPN50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:57:26 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:24975 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S932271AbVLPN5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:57:25 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: slow sync of fat 32 hotplugged devices
To: Patrick Fritzsch <fritzsch@cip.physik.uni-muenchen.de>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 16 Dec 2005 06:48:04 +0100
References: <5k61N-oO-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1En8Rp-00050N-Gk@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Fritzsch <fritzsch@cip.physik.uni-muenchen.de> wrote:

> It seems that the hal daemon mounts a usbstick in fat32 mode, where
> default the sync option ist on. Actually this is a nice behaviour,
> because a cp to the stick should last so long until the file was
> completly written.

[...]
> I guess that the kernel checks after every block of the file, which is
> written, if the stick has really written it, which leads to such a big
> slowdown. There are already lots of comments of this in the web, where
> the solution is always to disable the sync mode in the hal daemon device
> files.

The situation is worse: It will update the FAT each time a block is written.
Therefore the FAT area will wear out very quickly.

> Wouldnt it be a nice behaviour, if you could mount a file in a new sync
> mode, where it isnt synchronized during writing a file, only when a
> close ioctl command was executed on a filehandle?
> sync writing to hotplugged devices would be a lot faster then.

IMO it should sync on committed dentry updates, too.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
