Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269254AbUHZRUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269254AbUHZRUR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269218AbUHZRT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:19:56 -0400
Received: from mail.shareable.org ([81.29.64.88]:39110 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269265AbUHZRIb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:08:31 -0400
Date: Thu, 26 Aug 2004 18:08:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Christoph Hellwig <hch@lst.de>, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826170822.GO5733@mail.shareable.org>
References: <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org> <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <20040826144422.GD5733@mail.shareable.org> <20040826160306.GA4326@lst.de> <20040826161911.GK5733@mail.shareable.org> <20040826162354.GA4891@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826162354.GA4891@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> If the smaller objects interact with normal files (link/rename,
> contained in normal directories), they will have to obey the same
> locking protocols.  If not a filesystem could experiment with it of
> course.

I think the smaller objects will consist of special files, which are
magic attributes like the ones you currently see in reiser4, and
ordinary files (which might themselves be containers).

Link/rename/locking etc. should work as usual on the ordinary smaller
files, but probably aren't allowed at all on the special attribute
files, except where there's an appropriate meaning.  (For example
locking certain attributes might have an appropriate meaning).

It would make sense for the special attributes file to not identify as
"regular files" (S_IFREG), but there aren't many mode bits to play
with.  They should also be harder to find than ordinary smaller files.

-- Jamie
