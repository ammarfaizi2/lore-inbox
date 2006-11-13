Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933128AbWKMW7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933128AbWKMW7M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 17:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933129AbWKMW7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 17:59:12 -0500
Received: from mail.suse.de ([195.135.220.2]:37511 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933128AbWKMW7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 17:59:11 -0500
Date: Mon, 13 Nov 2006 23:58:18 +0100
From: Stefan Seyfried <seife@suse.de>
To: Zan Lynx <zlynx@acm.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Message-ID: <20061113225818.GG2760@suse.de>
References: <200611121436.46436.arvidjaar@mail.ru> <200611130642.18990.arvidjaar@mail.ru> <20061113081528.GB18022@suse.de> <200611132154.38644.arvidjaar@mail.ru> <1163455396.9482.38.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1163455396.9482.38.camel@localhost>
X-Operating-System: openSUSE 10.2 (i586) Beta2, Kernel 2.6.18.2-4-default
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 03:03:16PM -0700, Zan Lynx wrote:

> I have not checked if this is true, but it is a possible explanation:
> 
> Perhaps the filesystem is not properly unmounted during a suspend?  That

Of course not.

> would mean GRUB is reading from a incoherent filesystem on resume.

Exactly.

> GRUB's filesystem drivers are not very fancy.  It could be it does
> something silly like check the journal before returning each block.

GRUB must not write to the fs, so it probably plays back the journal in
memory only and it does this for every file it reads (at least that's how
it feels :-)
 
> Maybe its a journal size thing, you could try "sync" before suspend and
> see if it helps.

We already sync inside the kernel, it does not help here, though.
Blockdev freezing might help.

> Another thing would be to create /boot as a separate partition.

Yes, that's what i always advise: /boot on separate ext2 partition. Then
GRUB resumes fast.
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
