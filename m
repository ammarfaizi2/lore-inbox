Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266183AbSKFWlD>; Wed, 6 Nov 2002 17:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266184AbSKFWlD>; Wed, 6 Nov 2002 17:41:03 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:35724 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266183AbSKFWlC>;
	Wed, 6 Nov 2002 17:41:02 -0500
Date: Wed, 6 Nov 2002 17:47:40 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Christopher Li <chrisl@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix bug in ext3 htree rename: doesn't delete old name,
 leaves ino with bad nlink
In-Reply-To: <20021106224112.GA10130@think.thunk.org>
Message-ID: <Pine.GSO.4.21.0211061746410.10405-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Nov 2002, Theodore Ts'o wrote:

> We take the BKL, yes; but if we need to sleep waiting for a block to
> be read in, that's when another process can run.  Yes, that means
> another process could end up deleting the entry out from under us ---
> or make some other change to the directory.  I was actually quite
> nervous about this, so I spent some time auditing the code paths of
> when do_split() might sleep, to make sure it would never leave the
> directory in an unstable condition.

HUH?

->rename() holds ->i_sem on both directories.  So do all other directory
methods.  What the hell is going on there?

