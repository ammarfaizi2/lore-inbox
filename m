Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281475AbRKPSp2>; Fri, 16 Nov 2001 13:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281480AbRKPSpR>; Fri, 16 Nov 2001 13:45:17 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:46585 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S281479AbRKPSo6>; Fri, 16 Nov 2001 13:44:58 -0500
Date: Fri, 16 Nov 2001 18:44:52 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ben Collins <bcollins@debian.org>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: Re: Bug in ext3
Message-ID: <20011116184452.E6626@redhat.com>
In-Reply-To: <20011115092452.Z329@visi.net> <3BF3F9ED.17D55B35@zip.com.au>, <3BF3F9ED.17D55B35@zip.com.au> <20011115153442.A329@visi.net> <3BF42A1A.5AE96A78@zip.com.au> <20011115160232.H329@visi.net> <20011115145803.R5739@lynx.no> <20011115170628.J329@visi.net> <20011115162149.U5739@lynx.no> <20011116183837.D6626@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011116183837.D6626@redhat.com>; from sct@redhat.com on Fri, Nov 16, 2001 at 06:38:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 16, 2001 at 06:38:37PM +0000, Stephen C. Tweedie wrote:
> Looks OK.  I've done a slightly better version which catches a couple
> of extra cases but it's basically the same solution.  I've also added
> a tiny patch to prevent a failed journal_wipe() from being followed by
> a journal_load() attempt, so we don't get the same error twice.

This definitely fixes that error path: I just get one, clean error
now, and no corruption of the file that was masquerading as the
journal.  It doesn't properly release the journal inode, though, so we
oops on a later ext2 mount as we think we already have the (ext3)
inode in cache.  Fix to follow.

Ben, thanks for this --- this level of corrupt journal is something
that hasn't been tested in this way before.

--Stephen
