Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271848AbTHDQLz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 12:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271849AbTHDQLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 12:11:55 -0400
Received: from pat.ukc.ac.uk ([129.12.21.15]:11253 "EHLO pat.kent.ac.uk")
	by vger.kernel.org with ESMTP id S271848AbTHDQLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 12:11:53 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<20030804134415.GA4454@win.tue.nl>
	<20030804155604.2cdb96e7.skraw@ithnet.com>
	<03080409334500.03650@tabby>
	<20030804170506.11426617.skraw@ithnet.com>
From: Adam Sampson <azz@us-lot.org>
Organization: Don't wake me, 'cos I'm dreaming, and I might just stay inside
 again today.
Date: Mon, 04 Aug 2003 17:11:17 +0100
In-Reply-To: <20030804170506.11426617.skraw@ithnet.com> (Stephan von
 Krawczynski's message of "Mon, 4 Aug 2003 17:05:06 +0200")
Message-ID: <y2aznips8re.fsf@cartman.at.fivegeeks.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-UKC-Mail-System: No virus detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski <skraw@ithnet.com> writes:

> All that can handle symlinks already have the same problem
> nowadays. Where is the difference?

lstat() will tell you if a file is a symlink; if you only walk into
directories, then you're guaranteed not to get into a loop. If you've
got two hardlinks to a directory, how do you make that available in
stat() output, and how does a tree-walking program know which to walk
into? You could do the rsync trick of keeping track of every
device-inode pair you've seen to detect hardlinks, but that's horribly
non-space-efficient on large directories -- particularly bad for
backups.

I could imagine this functionality maybe being useful for system
administrators, but with normal Unixish userspace, it doesn't strike
me as a good idea to give users the ability to create hardlinks to
directories.

-- 
Adam Sampson <azz@us-lot.org>                        <http://offog.org/>
