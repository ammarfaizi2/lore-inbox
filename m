Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264034AbUFCOw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbUFCOw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265521AbUFCOsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:48:14 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:55816 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S265517AbUFCOqf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:46:35 -0400
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gaczkwvg8.fsf@patl=users.sf.net>
To: "Frediano Ziglio" <freddyz77@tin.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x partition breakage and dual booting
References: <40BA2213.1090209@pobox.com> <20040530183609.GB5927@pclin040.win.tue.nl> <40BA2E5E.6090603@pobox.com> <20040530200300.GA4681@apps.cwi.nl> <s5g8yf9ljb3.fsf@patl=users.sf.net> <20040531180821.GC5257@louise.pinerecords.com> <1086245495.3988.4.camel@freddy> <20040603103907.GV23408@apps.cwi.nl>
Date: 03 Jun 2004 10:46:33 -0400
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frediano Ziglio <freddyz77@tin.it> writes:

> Yes and not... HDIO_GETGEO still exists and report inconsistent
> informations. IMHO should be removed. I know this breaks some
> existing programs however these programs do not actually works
> correctly.

Existing programs work fine if you do something like this first:

    echo bios_head:255 > /proc/ide/hda/settings

I know this works because it is how I convince Parted to prep a blank
drive for installing Windows.  In fact, it is the only way for me to
communicate the geometry to Parted, as far as I know.  (Other tools
usually have command-line switches or "expert" settings to control the
geometry; Parted does not.)

SCSI and RAID devices already return a suitable geometry in
HDIO_GETGEO on all of the systems that I or my users have tried.

So one approach is to leave HDIO_GETGEO alone, and to have a userspace
gadget run early to "fix" the kernel's notion of the geometry.  This
would avoid the need to rewrite every partitioning tool.

 - Pat
