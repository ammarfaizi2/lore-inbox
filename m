Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290756AbSA3Xmo>; Wed, 30 Jan 2002 18:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290746AbSA3Xi1>; Wed, 30 Jan 2002 18:38:27 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:60654 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S290750AbSA3Xho>;
	Wed, 30 Jan 2002 18:37:44 -0500
Date: Wed, 30 Jan 2002 16:37:30 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Kris Urquhart <kurquhart@littlefeet-inc.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: ext2/mount - multiple mounts corrupts inodes
Message-ID: <20020130163730.N763@lynx.adilger.int>
Mail-Followup-To: Kris Urquhart <kurquhart@littlefeet-inc.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <B9F49C7F90DF6C4B82991BFA8E9D547B1256F4@BUFORD.littlefeet-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B9F49C7F90DF6C4B82991BFA8E9D547B1256F4@BUFORD.littlefeet-inc.com>; from kurquhart@littlefeet-inc.com on Wed, Jan 30, 2002 at 03:07:19PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 30, 2002  15:07 -0800, Kris Urquhart wrote:
> [1.] One line summary of the problem: 
> A mount of an already mounted ext2 partition corrupts inodes if there have
> been recent writes without an intervening sync.

This _should_ be handled OK by the kernel simply by not mounting the
filesystem the second time.  If you try and mount it a second time it
_should_ just do a "bind" mount instead of a real mount, I think.

<stating the obvious>
Rather than mounting the device to try and see if it is already
mounted, use /proc/mounts or /etc/mtab or "df" or "mount" output
instead.  Doctor, it hurts when I do this... ;-).
</stating the obvious>

Granted, this does appear to be a bug so the above will only work
around it and not fix it.  Al Viro is the one to pester about it.
Hopefully he will see this email and reply (== fix the problem).

> [4.] Kernel version (from /proc/version): 
> Linux version 2.4.10 (kurquhart@bay.sw.littlefeet-inc.com) (gcc version
> egcs-2.91.66 
> 19990314/Linux (egcs-1.1.2 release)) #1 Wed Jan 30 09:46:52 PST 2002

The 2.4.10 kernel is a bad one to use for several reasons, don't use it.

Cheers, Andreas

PS - nice bug report, if only all of them were this useful.
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

