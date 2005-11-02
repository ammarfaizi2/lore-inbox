Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965251AbVKBV1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965251AbVKBV1Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbVKBV1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:27:24 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:58324 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S965251AbVKBV1Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:27:24 -0500
Date: Wed, 2 Nov 2005 22:27:22 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: XFS information leak during crash
Message-ID: <20051102212722.GC6759@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, world!\n

I have found that after the system crash (e.h. a hard reset or a power
failure) XFS corrupts files which have been written to just before the crash:
The result is that those files contain data from random blocks on the
disk (e.g. from previously deleted files). This can have security/privacy
implications - users can see the contents of other users' old files.

	I have even written a test program, which creates/rewrites
files with known contents in a given directory. After the hard
reset while running this program some of the files contain blocks
with "random" data (i.e. not the original data and not the new data
either). Does XFS support a something like ext3's "data=ordered" mount
option? Otherwise it is pretty unusable on multi-user systems.

	This is on 2.6.11.10 and 2.6.14 running on x86_64 and i386 SMP
configurations. I may test it on UP if there is an interest.

	The quick-hack-style test program can be found at
http://www.fi.muni.cz/~kas/progs/xfsrewrite.c

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> Specs are a basis for _talking_about_ things. But they are _not_ a basis <
> for implementing software.                              --Linus Torvalds <
