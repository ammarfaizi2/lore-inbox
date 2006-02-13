Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWBMAIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWBMAIH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 19:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWBMAIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 19:08:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53440 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751003AbWBMAIE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 19:08:04 -0500
Date: Mon, 13 Feb 2006 00:08:03 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linda Walsh <lkml@tlinx.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
Message-ID: <20060213000803.GY27946@ftp.linux.org.uk>
References: <43ED5A7B.7040908@tlinx.org> <20060212180601.GU27946@ftp.linux.org.uk> <43EFA63B.30907@tlinx.org> <20060212212504.GX27946@ftp.linux.org.uk> <43EFBCA9.1090501@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EFBCA9.1090501@tlinx.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 02:54:33PM -0800, Linda Walsh wrote:
> Al Viro wrote:
> >Care to RTFS? I mean, really - at least to the point of seeing what's
> >involved in that recursion.
> >  
> Hmmm...that's where I got the original parameter numbers, but
> I see it's not so straightforward.  I tried a limit of
> 40, but I quickly get an OS hang when trying to reference a
> 13th link.  Twelve works at the limit, but would take more testing
> to find out the bottleneck.

Sigh...  12 works at the limit on your particular config, filesystems
being used and syscall being issued (hint: amount of stuff on stack
before we enter mutual recursion varies; so does the amount of stuff
on stack we get from function that are not part of mutual recursion,
but are called from the damn thing).
