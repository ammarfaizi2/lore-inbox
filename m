Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUIIL5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUIIL5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 07:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUIIL45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 07:56:57 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:64909 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S266490AbUIIL4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 07:56:36 -0400
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Roger Luethi <rl@hellgate.ch>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
In-Reply-To: <20040908184130.GA12691@k3.hellgate.ch>
References: <20040908184130.GA12691@k3.hellgate.ch>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 07:53:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 14:41, Roger Luethi wrote:
> A few notes:
> - Access control can be implemented easily. Right now it would be bloat,
>   though -- the vast majority of fields in /proc are world-readable
>   (/proc/pid/environ being the notable exception).

They aren't world readable when using a security module like SELinux;
they are then typically only accessible by processes in the same
security domain, aside from processes in privileged domains. 
security_task_to_inode() hook sets the security attributes on the
/proc/pid inodes based on their security context, and then
security_inode_permission() hook controls access to them.  So you need
at least comparable controls.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

