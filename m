Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264970AbSJVUSJ>; Tue, 22 Oct 2002 16:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264966AbSJVURL>; Tue, 22 Oct 2002 16:17:11 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:49659 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S264957AbSJVUQA>; Tue, 22 Oct 2002 16:16:00 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 22 Oct 2002 14:18:43 -0600
To: Dave Jones <davej@codemonkey.org.uk>, Rob Landley <landley@trommello.org>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, akpm@zip.com.au, davem@redhat.com,
       mingo@redhat.com
Subject: Re: [STATUS 2.5]  October 21, 2002
Message-ID: <20021022201843.GC28822@clusterfs.com>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Rob Landley <landley@trommello.org>,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Roman Zippel <zippel@linux-m68k.org>, riel@conectiva.com.br,
	linux-kernel@vger.kernel.org, akpm@zip.com.au, davem@redhat.com,
	mingo@redhat.com
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <3DB3AB3E.23020.5FFF7144@localhost> <200210211522.35843.landley@trommello.org> <20021022194739.GB28822@clusterfs.com> <20021022195730.GA30958@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021022195730.GA30958@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 22, 2002  20:57 +0100, Dave Jones wrote:
> On Tue, Oct 22, 2002 at 01:47:39PM -0600, Andreas Dilger wrote:
>  > On Monday 21 October 2002 06:22, Guillaume Boissiere wrote:
>  > > Also, are initramfs, ext2/3 resize for 2.7/3.1?
>  > 
>  > The online resize stuff has been suffering because I've been terribly
>  > busy at work.  Even so, it can be merged after the 2.5 code freeze,
>  > since it is internal to ext3 and does not affect any APIs.
> 
> Nevertheless, it means any ext3 stability testing done post-freeze
> would be invalidated by addition of a new _feature_.

No, because if you looked at the code for the online resize (even if it
is enabled, which is separately selectable), you would see it is
equivalent to the following in ext3_ioctl() and ext3_setup_super():

	if (doing online resize)
		do something;
	else
		don't even see any difference;

The resize code does not impact any code paths in the normal operation
of the filesystem, and 99% could even be put into a separate module,
that's how detached it is from the main ext3 code.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

