Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268916AbUHUIwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268916AbUHUIwY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 04:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUHUIwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 04:52:24 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:523 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S268916AbUHUIwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 04:52:19 -0400
Date: Sat, 21 Aug 2004 10:51:55 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Theodore Ts'o" <tytso@mit.edu>, Andries Brouwer <aeb@cwi.nl>,
       Pankaj Agarwal <pankaj@pnpexports.com>, Andreas Schwab <schwab@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: how to identify filesystem type
Message-ID: <20040821085155.GB5771@pclin040.win.tue.nl>
References: <001901c485cc$208c3a60$9159023d@dreammachine> <je657fzchp.fsf@sykes.suse.de> <000901c486c9$40d92e60$6d59023d@dreammachine> <20040820204656.GW8967@schnapps.adilger.int> <20040820215858.GA5771@pclin040.win.tue.nl> <20040821032520.GA15772@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821032520.GA15772@thunk.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 11:25:21PM -0400, Theodore Ts'o wrote:

> > Consequently, "blkid" is a really bad name. It gives no indication
> > of the guessed nature of its results.
> > 
> > (I see that my current version is also broken:
> > # blkid -v
> > blkid 1.0.0 (12-Feb-2003)
> > # blkid
> > ...
> > /dev/sda4: LABEL="ZIP-100" UUID="34D8-1C07" TYPE="msdos" 
> > /dev/sda1: UUID="1ac5969c-8fdf-4f69-934a-c6103d93c05d" TYPE="ext2" 
> > /dev/sdb4: LABEL="ZIP-100" UUID="34D8-1C07" TYPE="msdos" 
> > /dev/sdb1: LABEL="CF_CARD032M" UUID="2001-1207" TYPE="msdos" 
> > ...
> > Here no /dev/sda1 and no /dev/sdb4 exist.)
> 
> Blkid deliberately doesn't revalidate devices without any command-line
> arguments, because certain devices might timeout or block for a
> long-time.  If you use "blkid /dev/sdb4", or use the library
> interfaces, it will revalidate any entries found in the cache file
> before returning them.

Yes:

# blkid
...
/dev/sda4: LABEL="ZIP-100" UUID="34D8-1C07" TYPE="msdos"
/dev/sda1: UUID="1ac5969c-8fdf-4f69-934a-c6103d93c05d" TYPE="ext2" 
/dev/sdb4: LABEL="ZIP-100" UUID="34D8-1C07" TYPE="msdos" 
...
# blkid /dev/sda1
# blkid /dev/sdb4
# blkid
...
/dev/sda4: LABEL="ZIP-100" UUID="34D8-1C07" TYPE="msdos"
/dev/sda1: UUID="1ac5969c-8fdf-4f69-934a-c6103d93c05d" TYPE="ext2"
/dev/sdb4: LABEL="ZIP-100" UUID="34D8-1C07" TYPE="msdos"
...
#

So, the cache file is not updated.
Moreover, the cache file has never been correct - there is only
one ZIP drive here and it is /dev/sda. The disk inside has only
one nonempty partition, and it is /dev/sda4.
The command # blkid -c /dev/null does not list these two bogus
entries, and a new /etc/blkid.tab is written, but a subsequent
command # blkid again lists the bogus entries.
Doing # rm /etc/blkid.tab* by hand helps.

Andries
