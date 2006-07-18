Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWGRW1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWGRW1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 18:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWGRW1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 18:27:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:44194 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932071AbWGRW1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 18:27:35 -0400
Date: Wed, 19 Jul 2006 08:24:59 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Mandy Kirkconnell <alkirkco@sgi.com>,
       Chris Wright <chrisw@sous-sol.org>, xfs@oss.sgi.com
Subject: Re: [patch 01/45] XFS: corruption fix
Message-ID: <20060719082458.A1935136@wobbly.melbourne.sgi.com>
References: <20060717160652.408007000@blue.kroah.org> <20060717162518.GB4829@kroah.com> <Pine.LNX.4.61.0607181526320.9156@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0607181526320.9156@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Tue, Jul 18, 2006 at 03:27:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2006 at 03:27:37PM +0200, Jan Engelhardt wrote:
> >
> >Fix nused counter.  It's currently getting set to -1 rather than getting
> >decremented by 1.  Since nused never reaches 0, the "if (!free->hdr.nused)"
> >check in xfs_dir2_leafn_remove() fails every time and xfs_dir2_shrink_inode()
> >doesn't get called when it should.  This causes extra blocks to be left on
> >an empty directory and the directory in unable to be converted back to
> >inline extent mode.
> >
> Is there a utility to fix such directories or will they autoshrink once the fs
> is run with a 2.6.17.7?

An xfs_repair is required.  There is a remaining issue with repair
where it cannot resolve some particular types of directory trashing,
but for the most part I believe xfs_repair will resolve this (please
report if not).  We're working on improving the way xfs_repair deals
with dir2 corruption atm, so this remaining problem (that funky dir2
offset problem, iow) I expect will shortly be resolved.

cheers.

-- 
Nathan
