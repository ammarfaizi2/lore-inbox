Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWEBUDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWEBUDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWEBUDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:03:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11951 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750965AbWEBUDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:03:46 -0400
Date: Wed, 3 May 2006 06:03:36 +1000
From: Nathan Scott <nathans@sgi.com>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT, ext3fs, kernel 2.4.32... again
Message-ID: <20060503060336.A1918058@wobbly.melbourne.sgi.com>
References: <20060427063249.GH761@DervishD> <20060501062058.GA16589@dmt> <20060501112303.GA1951@DervishD> <20060502072808.A1873249@wobbly.melbourne.sgi.com> <20060502172411.GA6112@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060502172411.GA6112@DervishD>; from lkml@dervishd.net on Tue, May 02, 2006 at 07:24:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 07:24:11PM +0200, DervishD wrote:
>     Hi Nathan :)

Hi there,

>  * Nathan Scott <nathans@sgi.com> dixit:
> > On Mon, May 01, 2006 at 01:23:03PM +0200, DervishD wrote:
> > >  * Marcelo Tosatti <marcelo@kvack.org> dixit:
> > > > Your interpretation is correct. It would be nicer for open() to
> > > > fail on fs'es which don't support O_DIRECT, but v2.4 makes such
> > > > check later at read/write unfortunately ;(
> > > 
> > >     Oops :(
> > 
> > Nothing else really make sense due to fcntl...
> > 	fcntl(fd, F_SETFL, O_DIRECT);
> > ...can happen at any time, to enable/disable direct I/O.
> 
>     I know, but that fcntl call should fail just like the open() one.
> I mean, I don't find this very different, it's just another point
> where the flag can be activated and so it should fail if the
> underlying filesystem doesn't support it (and doesn't ignore it in
> read()/write()).

Problem is there is no way to know whether the underlying fs
supports direct IO or not here (fcntl is implemented outside
the filesystem, entirely).  Which is not unfixable in itself
(could use a superblock flag or something similar) but it's
way out of scope for the sort of change going into 2.4 these
days.

cheers.

-- 
Nathan
