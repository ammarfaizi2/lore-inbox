Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271188AbTHHBBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 21:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271189AbTHHBBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 21:01:15 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:3792 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S271188AbTHHBBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 21:01:14 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Aug 2003 11:00:54 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16178.63046.43567.551323@gargle.gargle.HOWL>
Cc: dan@debian.org, linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: ext3 badness in 2.6.0-test2
In-Reply-To: message from Andrew Morton on Tuesday August 5
References: <20030804142245.GA1627@nevyn.them.org>
	<20030804132219.2e0c53b4.akpm@osdl.org>
	<16176.41431.279477.273718@gargle.gargle.HOWL>
	<20030805235735.4c180fa4.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 5, akpm@osdl.org wrote:
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> > ...
> > Aug  6 15:22:05 adams kernel: EXT3-fs error (device md1): ext3_add_entry: bad entry in directory #41
> > 009295: rec_len is smaller than minimal - offset=0, inode=3265411686, rec_len=0, name_len=0
> 
> It looks like we had a block full of zeroes come back from the device
> driver.  I find it distinctly fishy how this happens so much with
> ext3-on-md, and so little with ext3-on-just-a-disk.

Well, they're not *all* zero.....

I can reproduce this easily with various configurations of ext3 over
raid5, and get a similar problem with ext2 over raid5 (corrupt inodes
rather than directory entries) but ext3 over raid0 is rock-solid.

So I guess the finger points generally in the direction of raid5.
Now I've just got to figure if it is a bug in r5, or some assumption
that it makes that is no longer valid (I was briefly suspicious of
PF_READAHEAD which could have made a real mess of raid5, but that
wouldn't have this symptom)

NeilBrown
