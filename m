Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136389AbREDNul>; Fri, 4 May 2001 09:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136388AbREDNuc>; Fri, 4 May 2001 09:50:32 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:59922
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S136387AbREDNuW>; Fri, 4 May 2001 09:50:22 -0400
Date: Fri, 04 May 2001 09:49:34 -0400
From: Chris Mason <mason@suse.com>
To: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Maximum files per Directory
Message-ID: <145290000.988984174@tiny>
In-Reply-To: <200105012257.QAA27361@lynx.turbolabs.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, May 01, 2001 04:57:02 PM -0600 Andreas Dilger
<adilger@turbolinux.com> wrote:

> H. Peter Anvin writes:
>> Not correct, there can't be more than 2^15 *directories* in a single
>> directory.  I belive this is an ext2 limitation.
> 
> 
> I see that reiserfs plays some tricks with the directory i_nlink count.
> If you exceed 64536 links in a directory, it reverts to "1" and no longer
> tracks the link count.

Correct.  The link count isn't used at all when deciding if the directory
is empty (we use the size instead), so we can just lie to VFS if someone
tries to make tons of subdirs.

-chris

