Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284604AbRLETd0>; Wed, 5 Dec 2001 14:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280980AbRLETdQ>; Wed, 5 Dec 2001 14:33:16 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:45053
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S284607AbRLETc7>; Wed, 5 Dec 2001 14:32:59 -0500
Date: Wed, 5 Dec 2001 11:32:52 -0800
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Cyrille Beraud <cyrille.beraud@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Removing an executable while it runs
Message-ID: <20011205193252.GB9050@mikef-linux.matchmail.com>
Mail-Followup-To: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	Cyrille Beraud <cyrille.beraud@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <B22D093570E@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B22D093570E@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.3.24i
From: Mike Fedyk <mfedyk@matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 05:15:52PM +0000, Petr Vandrovec wrote:
> On  5 Dec 01 at 11:00, Cyrille Beraud wrote:
> 
> > I would like to remove an executable from the file-system while it is 
> > running and
> > get all the blocks back immediately, not after the end of the program.
> > Is this possible ?
> 
> No. Binary runs from these blocks. Maybe you can force it to run from
> swap by modifying these pages through ptrace interface, but it is
> not supported. Just kill the app if you need these blocks.
> 
> >  From what I understand, the inode is not released until the program 
> > ends. Do all the file-systems behave the same way ?
> 
> No. Some will refuse to unlink running app (or another opened file).
> Some will unlink it immediately, and app then dies when it needs
> page-in something. Some works as POSIX mandates.
> 

POSIX behaviour would be in ext[23], reiserfs, xfs, (and probably ffs,
ntfs).  Can someone verify which FSes have what behaviour?

I'd guess that vfat (fat16/28--err, 32), nfs, and hfs would delete
immediately.

mf
