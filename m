Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTIASLx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263262AbTIASLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:11:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56491 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263224AbTIASLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:11:15 -0400
Date: Mon, 1 Sep 2003 20:11:13 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: viro@math.psu.edu
Subject: [BUG] mtime&ctime updated when it should not
Message-ID: <20030901181113.GA15672@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  one user pointed my attention to the fact that when the write fails
(for example when the user quota is exceeded) the modification time is
still updated (the problem appears both in 2.4 and 2.6). According to
SUSv3 that should not happen because the specification says that mtime
and ctime should be marked for update upon a successful completition
of a write (not that it would forbid updating the times in other cases
but I find it at least a bit nonintuitive).
  The easiest fix would be probably to "backup" the times at the
beginning of the write and restore the original values when the write
fails (simply not updating the times would require more surgery because
for example vmtruncate() is called when the write fails and it also
updates the times).
  So should I write the patch or is the current behaviour considered
correct?

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
