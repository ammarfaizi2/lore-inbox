Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266166AbRF2Tx6>; Fri, 29 Jun 2001 15:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266167AbRF2Txs>; Fri, 29 Jun 2001 15:53:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62462 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266166AbRF2Txb>;
	Fri, 29 Jun 2001 15:53:31 -0400
Date: Fri, 29 Jun 2001 15:53:29 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking & HFS problems (2.4.6pre6)
In-Reply-To: <20010629150942.1359@smtp.adsl.oleane.com>
Message-ID: <Pine.GSO.4.21.0106291547080.27530-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Jun 2001, Benjamin Herrenschmidt wrote:

> The deadlock happen in the HFS filesystem in hfs_cat_put(), apparently
> (quickly looking at addresses) in spin_lock().

<looks>
Uh-oh. Looks like hfs_cat_put() grabs some internal spinlock and calls
write_entry(). If it really is what its name implies, you are calling
a blocking function under the spinlock.

> So my question: Is there any document explaining the various locking
> requirements & re-entrency possibilities in a filesystem.

There is, but this bug has nothing fs-specific in it. You should never
block while holding a spinlock.

BTW, looks like 2.2 has the same bug.

