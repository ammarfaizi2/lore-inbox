Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264391AbUFCPhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUFCPhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbUFCPeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:34:02 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21744 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264382AbUFCP2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:28:40 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       "Frediano Ziglio" <freddyz77@tin.it>
Subject: Re: 2.6.x partition breakage and dual booting
Date: Thu, 3 Jun 2004 17:32:10 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <40BA2213.1090209@pobox.com> <20040603103907.GV23408@apps.cwi.nl> <s5gaczkwvg8.fsf@patl=users.sf.net>
In-Reply-To: <s5gaczkwvg8.fsf@patl=users.sf.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406031732.10919.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 of June 2004 16:46, Patrick J. LoPresti wrote:
> Frediano Ziglio <freddyz77@tin.it> writes:
> > Yes and not... HDIO_GETGEO still exists and report inconsistent
> > informations. IMHO should be removed. I know this breaks some
> > existing programs however these programs do not actually works
> > correctly.
>
> Existing programs work fine if you do something like this first:
>
>     echo bios_head:255 > /proc/ide/hda/settings
>
> I know this works because it is how I convince Parted to prep a blank
> drive for installing Windows.  In fact, it is the only way for me to
> communicate the geometry to Parted, as far as I know.  (Other tools
> usually have command-line switches or "expert" settings to control the
> geometry; Parted does not.)
>
> SCSI and RAID devices already return a suitable geometry in
> HDIO_GETGEO on all of the systems that I or my users have tried.
>
> So one approach is to leave HDIO_GETGEO alone, and to have a userspace
> gadget run early to "fix" the kernel's notion of the geometry.  This
> would avoid the need to rewrite every partitioning tool.

This is a bandaid not a solution and it is just silly (you push
some values into kernel just to read them back by user-space).

Also what if kernel is compiled with CONFIG_PROC_FS=n
or if I decide to pull out /proc/ide/hdx/settings one day?

[ I'm counting days. 8) ]

Cheers,
Bartlomiej

