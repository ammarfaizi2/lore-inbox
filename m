Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUECL6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUECL6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 07:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263641AbUECL6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 07:58:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52364 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262329AbUECL6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 07:58:38 -0400
Date: Mon, 3 May 2004 13:58:37 +0200
From: Jan Kara <jack@ucw.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Eugene Crosser <crosser@average.org>
Subject: Deadlock problems
Message-ID: <20040503115837.GC360@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Andrew!

  I've found hard to fix problem causing deadlock - call path is
generally following:
  some operation -> quota code -> read/write quota -> vfs -> needs a page ->
shrink caches -> free inodes -> free quota -> Ouch... (we need to acquire
some lock which is already held by the quota code)

   I hope I can fix the problems with quota locks but there's also a
problem that transaction can be already started when we want to free
some inodes etc. So I'd like to ask: Is there somewhere documented what
can/cannot hold a caller using GFP_FS?
  One a bit hacky solution would also be to clear GFP_FS from i_mapping
of quotafile inode. Do you think that is a reasonable solution?

								Honza
