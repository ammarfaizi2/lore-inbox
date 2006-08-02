Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWHBCOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWHBCOa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 22:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWHBCOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 22:14:30 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:25587 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751035AbWHBCO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 22:14:29 -0400
Date: Tue, 1 Aug 2006 19:14:11 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, herbert@13thfloor.at,
       hch@infradead.org
Subject: Re: [PATCH 04/28] OCFS2 is screwy
Message-ID: <20060802021411.GG29686@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060801235240.82ADCA42@localhost.localdomain> <20060801235243.EA4890B4@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801235243.EA4890B4@localhost.localdomain>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 04:52:43PM -0700, Dave Hansen wrote:
> OCFS2 plays some games with i_nlink.  It modifies it a bunch in
> its unlink function, but rolls back the changes if an error
> occurs.  So, we can't just assume that iput_final() will happen
> whenever i_nlink hits 0 in ocfs's unlink().
Huh? Did you read the code? Or is it just easier to call things "screwy" and
start hacking away?

i_nlink only gets rolled back in the case that the file system wasn't able to
actually complete the unlink / orphan operation. The idea is to keep it in
sync with what's actually on disk. So when we call iput() in the unlink
path, disk and struct inode should be accurate.

> Create a helper function to do the hard work of i_nlink hitting
> zero, and use it in ocfs2.
Anyway, it's only done that way because at the time it seemed the cleanest
approach - there's no technical reason why we must roll it back. So a helper
function doesn't seem necessary - you'd just have to look through the small
amount of code and re-order things a bit.

Unfortunately you didn't actually put the contents of
__inode_set_awaiting_final_iput() in this patch, so I'll have to dig through
the others to see what exactly you're up to. In the meantime I'd say this
patch is either unecessary or just plain wrong.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
