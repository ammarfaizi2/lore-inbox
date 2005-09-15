Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbVIOCMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbVIOCMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 22:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbVIOCMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 22:12:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44716 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030339AbVIOCMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 22:12:49 -0400
Date: Thu, 15 Sep 2005 03:12:36 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Sripathi Kodi <sripathik@in.ibm.com>
Cc: Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       patrics@interia.pl, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
Message-ID: <20050915021236.GA25261@ZenIV.linux.org.uk>
References: <20050915005552.38626180A1A@magilla.sf.frob.com> <4328D0A8.90504@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4328D0A8.90504@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 08:38:48PM -0500, Sripathi Kodi wrote:
> Roland McGrath wrote:
> >>If you don't like this idea at all, please let me know if there any other 
> >>way of solving the invisible threads problem, short of taking out 
> >>->permission() altogether from proc_task_inode_operations.
> >
> >
> >Have you investigated my suggestion to move __exit_fs from do_exit to
> >release_task?
> 
> Roland,
> 
> No, I had missed this completely. Sorry.
> 
> I just gave it a quick try and it seems to be working fine. I have only 
> moved __exit_fs to the top of release_task, not moved exit_namespace after 
> it. I will try to run some tests to see if this is working fine. Thanks a 
> lot.

Among other things, it means that zombies keep pinning their root and cwd
down, AFAICS.  Not Good(tm).
