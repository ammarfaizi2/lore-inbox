Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbWIEPAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWIEPAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWIEPAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:00:07 -0400
Received: from mail.parknet.jp ([210.171.160.80]:34310 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S965075AbWIEPAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:00:03 -0400
X-AuthUser: hirofumi@parknet.jp
To: Mattias =?iso-8859-1?Q?R=F6nnblom?= <hofors@lysator.liu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFAT truncate performance
References: <m3mz9e5sk1.fsf@isengard.friendlyfire.se>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 05 Sep 2006 23:59:52 +0900
In-Reply-To: <m3mz9e5sk1.fsf@isengard.friendlyfire.se> (Mattias
 =?iso-8859-1?Q?R=F6nnblom's?= message of "05 Sep 2006 15\:52\:46 +0200")
Message-ID: <8764g28il3.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattias Rönnblom <hofors@lysator.liu.se> writes:

> extending files by ftruncate(2) runs very slow on VFAT file
> systems. On my USB harddisk w/ VFAT, it takes 14 seconds to extend an
> empty file to 1 GB. On a memory stick, it takes well over 4 minutes.
>
> My question is: is this problem on the conceptual level (ie there is
> no way of extending files on FAT that doesn't involve many disk
> operations) or is the current Linux fs driver suboptimal in this
> respect?

Unfortunately FAT doesn't support sparse file, so ftruncate(2) which
extend size needs to fill all clusters with zero, and write data.

This is limitation of FAT filesystem.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
