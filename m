Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130753AbRCEXJI>; Mon, 5 Mar 2001 18:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130756AbRCEXI7>; Mon, 5 Mar 2001 18:08:59 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:33451 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130753AbRCEXIs>;
	Mon, 5 Mar 2001 18:08:48 -0500
Date: Mon, 5 Mar 2001 18:08:45 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Urban Widmark <urban@teststation.com>
cc: linux-kernel@vger.kernel.org, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: d_add on negative dentry?
In-Reply-To: <Pine.LNX.4.30.0103052322540.29931-200000@cola.teststation.com>
Message-ID: <Pine.GSO.4.21.0103051803390.27373-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Mar 2001, Urban Widmark wrote:

> 
> Is it valid to call d_add on a negative dentry?
> (or on a dentry that is already linked in d_hash, but all negative
>  dentries are, right?)

Not all of them. It _is_ legal to do d_add() on a negative dentry.
Doing that for hashed dentries is a bug. Use d_instantiate() instead.
							Cheers,
								Al

PS: as for the patch, better make it
	d_instantiate(...);
	if (!hashed)
		d_rehash(...);

