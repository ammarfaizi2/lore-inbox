Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264330AbUEDMq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbUEDMq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 08:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbUEDMqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 08:46:25 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:51176 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264330AbUEDMqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 08:46:21 -0400
Date: Tue, 4 May 2004 08:39:40 -0400
From: Ben Collins <bcollins@debian.org>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sf.net
Subject: Re: [PATCH] fix ohci1394 rmmod
Message-ID: <20040504123940.GD3647@phunnypharm.org>
References: <16535.34664.662254.665975@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16535.34664.662254.665975@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ben, any comments on this patch?  I think it should go in.

Yeah, this is the wrong fix. I have a proper one in the repo that I'll
sync to Linus this week.

Point is, we need to ignore SIGTERM because init will send it during
shutdown, and that will kill these threads making it impossible to
unmount/sync sbp2 disks during the shutdown/reset process. My patch sets
a variable and then signals the semaphore in the thread, which checks
the variable and shuts down at that time.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
