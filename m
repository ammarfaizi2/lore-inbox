Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270577AbRHSQAw>; Sun, 19 Aug 2001 12:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270576AbRHSQAm>; Sun, 19 Aug 2001 12:00:42 -0400
Received: from SNAP.THUNK.ORG ([216.175.175.173]:34571 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S270577AbRHSQAe>;
	Sun, 19 Aug 2001 12:00:34 -0400
Date: Sun, 19 Aug 2001 12:00:13 -0400
From: Theodore Tso <tytso@mit.edu>
To: Dewet Diener <linux-kernel@dewet.org>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3 partition unmountable
Message-ID: <20010819120013.B3504@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Dewet Diener <linux-kernel@dewet.org>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	"ext3-users@redhat.com" <ext3-users@redhat.com>
In-Reply-To: <20010818030321.A11649@darkwing.flatlit.net> <3B7EEC4C.D0127AB4@zip.com.au> <20010819160605.A9890@darkwing.flatlit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010819160605.A9890@darkwing.flatlit.net>; from linux-kernel@dewet.org on Sun, Aug 19, 2001 at 04:06:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, for future reference, a much simpler way of debugging this
sort of problem (which doesn't require interpreting od -x dumps) is to
ask the user to use the command:

dumpe2fs -f -h /dev/hdd1

To clear the feature flag, you can use the debugfs program:

% debugfs
debugfs:  open -w -f /tmp/testfs
debugfs:  features   
Filesystem features: filetype FEATURE_I16 sparse_super
debugfs:  feature ^feature_i16
debugfs:  features
Filesystem features: filetype sparse_super
debugfs:  quit

> I managed to fix it by running e2fsck off one of the backup 
> superblocks - that seems to have repaired the broken bits:

> Then I just reran "tune2fs -j", and mounted it as ext3.  I hope that
> was the correct approach, but its working in any case :)  Don't quite
> know why/how the superblock got corrupted like that in the first
> place :-/

Well, sounds like the in-core copy of the superblock got corrupted
somehow, or perhaps a passing bit of cosmic radiation flipped the bit
as it was getting written back to disk.  If you can get it to do it
repeatably it, or if it even happens once or twice more, we'd
definitely want to know more about it.

							- Ted

