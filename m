Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315379AbSEQM3K>; Fri, 17 May 2002 08:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315835AbSEQM1u>; Fri, 17 May 2002 08:27:50 -0400
Received: from pc-62-31-66-178-ed.blueyonder.co.uk ([62.31.66.178]:32641 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S315374AbSEQM0c>; Fri, 17 May 2002 08:26:32 -0400
Date: Fri, 17 May 2002 13:26:25 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, ext3-users@redhat.com,
        ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>,
        Andreas Dilger <adilger@home.com>
Subject: Re: [Ext2-devel] Re: Ext3-0.9.18 available
Message-ID: <20020517132625.I2693@redhat.com>
In-Reply-To: <20020516175637.A21624@redhat.com> <20020517121746.GA6613@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 17, 2002 at 02:17:47PM +0200, Tomas Szepe wrote:
> > ext3-0.9.18 is now available for 2.4.19-pre8.  Some of the fixes in
> > this release are already in the 2.4.19-pre8, but there are some
> > important new fixes in the patch and users are encouraged to upgrade.
> > This release fixes all known outstanding bug reports.
> 
> Is there at least a remote possibility of the fixes getting ported
> to be included in the linux-2.2 ext3 patch (the latest being 0.0.7a?)?

No, there's no need.  The changes come in several groups:

Performance tweaks:
* Speed up MS_SYNC writes
* speed up fsyncs in non-journaled data modes a little

Config/cosmetic tweaks:
* Set up kjournald to be parented under init properly
* config: ext3 is no longer experimental

Fix bugs introduced at various stages during the 2.4 port:
* don't consider ENOSPC a fatal error when allocating an inode
* fix over-zealous ext3 complaint about locked buffers
* fix O_SYNC
* fix tiny race where a buffer could be written to disk too soon

Fix bugs arising from changes made elsewhere during 2.4:
* fix i_blocks getting inconsistent after disk full
* fix "dump corrupts filesystems" core VFS bug
* fix very rare buffer leak

Fix a bug in the LVM interaction (code isn't present in 2.2):
* fix LVM snapshot deadlock

None of the bug-fixes apply to the 2.2 version of the code.

Cheers,
 Stephen
