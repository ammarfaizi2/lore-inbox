Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbTDNSO1 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263630AbTDNSO0 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:14:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58635 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263595AbTDNRs1 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:48:27 -0400
Date: Mon, 14 Apr 2003 11:00:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Joel Becker <Joel.Becker@oracle.com>
cc: Andries.Brouwer@cwi.nl, <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kdevt-diff
In-Reply-To: <20030414175141.GS4917@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0304141056450.19302-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Apr 2003, Joel Becker wrote:
>
> On Mon, Apr 14, 2003 at 12:45:36AM +0200, Andries.Brouwer@cwi.nl wrote:
> > The structure here is 8+8, except when more bits are
> > present, in which case it is 16+16, except when more bits
> > are present, in which case it is 32+32.
> 
> 	Why complicate things?  Is it that bad?  We'd all have to know
> about the mess when dealing with userspace.

Well, the thing is, we absolutely _do_ need to have the 8+8 split, in
order to make old devices look the same old way for old binaries.

And the 32+32 split is what the new maximum would be, so ..

The 16+16 split is not strictly necessary, but Andries pointed out to me
that there are filesystems etc external storage that only support a 32-bit
opaque dev_t, so we'd need to marshall the device number _some_ way for
them anyway, and having a standard way to do that is better than having
everybody come up with their own variations.

(My prefernce for the 32-bit version would be 12+20 bits, but it's not a
very strong one, and it doesn't really matter for the kernel proper, so I
think Andries who has been tirelessly working on this for five years or
more gets the final say on it).

		Linus

