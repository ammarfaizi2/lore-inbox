Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbSKFEz6>; Tue, 5 Nov 2002 23:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265584AbSKFEz6>; Tue, 5 Nov 2002 23:55:58 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:61710
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S265578AbSKFEz5>; Tue, 5 Nov 2002 23:55:57 -0500
Subject: Re: [Ext2-devel] bug in ext3 htree rename: doesn't delete old
	name, leaves ino with bad nlink
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: chrisl@vmware.com
Cc: Ext2 devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021105212415.GB1472@vmware.com>
References: <1036471670.21855.15.camel@ixodes.goop.org>
	 <20021105212415.GB1472@vmware.com>
Content-Type: text/plain
Organization: 
Message-Id: <1036558949.28257.9.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.90 (Preview Release)
Date: 05 Nov 2002 21:02:29 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 13:24, chrisl@vmware.com wrote:
> Thanks again for the nice bug report.

Thanks for looking at it so quickly.  I want ext3+htree to stabilise as
quickly as possible, and since I had a nice reproducible bug, I may as
well make the most of it.

> I think I understand the problem now. What happen was, in ext3_rename,
> it will first add the new entry to directory and then remove the
> old entry. In this case, when add a new entry to the directory
> cause a leaf node split. And the old entry is in the very same
> leaf node. After split, the old entry have been move to another
> leaf node. But ext3_rename still holding the old pointer and bh
> to the old leaf node.

Yes, I would have guessed that it was related to a tree split.  The
interesting thing to me is that it happened twice in this particular
run, and yet it must be a fairly uncommon occurrence overall (otherwise
it would have been reported before).  I wonder if it really is a rare
event, or it has just gone unnoticed?

> This also raise an interesting question, after split leave node,
> do we need to update the dentry cache for the change?

Update it in what way?  In principle a rename is an atomic operation, so
other things shouldn't be able to observe the directory in an
intermediate state.

	J


