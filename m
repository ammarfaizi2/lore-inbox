Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264428AbUE3WyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbUE3WyI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 18:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbUE3WyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 18:54:08 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:48650 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S264428AbUE3WyE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 18:54:04 -0400
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gfz9hila6.fsf@patl=users.sf.net>
To: "Andries Brouwer" <Andries.Brouwer@cwi.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x partition breakage and dual booting
References: <40BA2213.1090209@pobox.com> <20040530183609.GB5927@pclin040.win.tue.nl> <40BA2E5E.6090603@pobox.com> <20040530200300.GA4681@apps.cwi.nl> <s5g8yf9ljb3.fsf@patl=users.sf.net> <20040530222001.GD4681@apps.cwi.nl>
Date: 30 May 2004 18:54:03 -0400
In-Reply-To: <mit.lcs.mail.linux-kernel/20040530222001.GD4681@apps.cwi.nl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <Andries.Brouwer@cwi.nl> writes:

> CMOS. INT 13, AH = 8, 15, 48. Tables pointed at by INT 41, INT 46.
> Sometimes one finds data past the pointer given by INT 41.
> IBM and Phoenix extensions.
> 
> The details depend on the brand of BIOS, which version of Phoenix
> extensions is supported, whether the support is bugfree, etc.
> 
> The result in 1999 was that it is impossible to get at geometries
> in a reliable way. I could not even come up with reasonable heuristics
> that worked on the majority of the machines I had at home.

Fair enough.

The old DOS fdisk uses INT13/AH=08h exclusively.  And I have used DOS
fdisk many times on many machines to partition a drive and then
install Windows.  So I am fairly confident that the geometry provided
by INT13/AH=08h (the "legacy INT13 interface") is the one the Windows
boot loader likes to see in the partition table.  This is the geometry
I use in my project, and my users have reported zero failures so far.

> Yes, I am happy with that.

Cool.  Sorry if my earlier tone was overly harsh.

> (Much better than the old situation where HDIO_GETGEO gave
> answers for one disk that belonged to some other disk.
> Of course, EDD is not always available.)

It is true that EDD 3.0, which allows you to map reliably between BIOS
disk numbers and physical hardware devices, is not always available
(see http://linux.dell.com/edd/results.html).  But the legacy geometry
is always around, and the EDD module will make it available even if
full EDD support is not present.

The only tricky part is doing the BIOS->Linux disk device mapping.  It
sure would be nice to have that written well once so that each of the
installation systems could re-use it...

 - Pat
