Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273094AbRIIXfM>; Sun, 9 Sep 2001 19:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273095AbRIIXfD>; Sun, 9 Sep 2001 19:35:03 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:36102 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S273094AbRIIXew>; Sun, 9 Sep 2001 19:34:52 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Dustin Marquess <jailbird@alcatraz.fdf.net>
Date: Mon, 10 Sep 2001 09:09:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15259.63173.46720.583041@notabene.cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>, linux-raid@vger.kernel.org
Subject: Re: PATCH - Software RAID Autodetection for OSF partitions
In-Reply-To: message from Dustin Marquess on Sunday September 9
In-Reply-To: <Pine.LNX.4.33.0109090443440.369-100000@alcatraz.fdf.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday September 9, jailbird@alcatraz.fdf.net wrote:
> 
> Here's a quick patch that I wrote-up for 2.4.10-pre5 (should work with
> other 2.4.x kernels too), so that the OSF partition code should
> auto-detect partitions with a fstype of 0xFD (software RAID).
> 
> It seems to work for me, except that the software RAID code in 2.4.10-pre5
> (both with and without my patch) keep dying with superblock errors on line
> 1574 of md.c.  If anybody knows how to fix this error, please let me know
> :).

line 1574 of md.c is an MD_BUG which gets called if "analyse_sbs"
returns non-zero.
analyse_sbs returns non-zero only if the label "abort:" is jumped.
Every "goto abort" is preceeded by an "MD_BUG" or a printk except one
after check_disk_sb and one after alloc_array_sb.
These both print messages in cases were they fail, except for
alloc_array_sb which won't print a message if __get_free_pages
fails.

So, if the message about "1574 of md.c" is the first message you get,
then __get_free_page must be failing.  It it isn't, please tell us the
first error message that you get.

NeilBrown
