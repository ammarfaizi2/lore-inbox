Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWIEOzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWIEOzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 10:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWIEOzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 10:55:20 -0400
Received: from smtp19.orange.fr ([80.12.242.18]:59246 "EHLO
	smtp-msa-out19.orange.fr") by vger.kernel.org with ESMTP
	id S964791AbWIEOzT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 10:55:19 -0400
X-ME-UUID: 20060905145517799.C33411C00084@mwinf1916.orange.fr
Subject: Re: VFAT truncate performance
From: Xavier Bestel <xavier.bestel@free.fr>
To: Mattias =?ISO-8859-1?Q?R=F6nnblom?= <hofors@lysator.liu.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3mz9e5sk1.fsf@isengard.friendlyfire.se>
References: <m3mz9e5sk1.fsf@isengard.friendlyfire.se>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1157468114.1435.216.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Tue, 05 Sep 2006 16:55:14 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 15:52, Mattias Rönnblom wrote:
> Hi,
> 
> extending files by ftruncate(2) runs very slow on VFAT file
> systems. On my USB harddisk w/ VFAT, it takes 14 seconds to extend an
> empty file to 1 GB. On a memory stick, it takes well over 4 minutes.
> 
> My question is: is this problem on the conceptual level (ie there is
> no way of extending files on FAT that doesn't involve many disk
> operations) or is the current Linux fs driver suboptimal in this
> respect?
> 
> The reason for asking is that I run Samba which service files on USB
> devices (w/ VFAT for portability) to Windows XP clients. When copying
> files to the Samba server, Microsoft SMB clients seem to extend the
> file before actually starting to copy the data. This results in
> sluggishness and timeouts when copying large files to VFAT
> filesystems.

Is your USB stick mounted -o sync ? If that's the case, the truncate()
and write() won't be merged so they will take twice as long. -o sync
generally kills performance on USB sticks.

	Xav

