Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTJMQX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTJMQX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:23:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:14308 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261965AbTJMQXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:23:53 -0400
Date: Mon, 13 Oct 2003 09:23:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Frank Cusack <fcusack@fcusack.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs fstat st_blocks overreporting
In-Reply-To: <20031013075316.A16032@google.com>
Message-ID: <Pine.LNX.4.44.0310130920210.21879-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Oct 2003, Frank Cusack wrote:
>
> While you know I disagree that s_blocksize should be wtmult (ie, it
> is wtmult?wtmult:512 and I think it should be MAX(rsize,wsize)), in
> any event the blocks used reporting is incorrect in that it assumes
> a 512 byte blocksize.

I agree with you that st_blocksize should very probably be different (in 
_no_ case has it got anything to do with just "wtmult", since the thing 
is used for reading too). However, the st_blocks calculations has 
_nothing_ to do with st_blocksize.

st_blocksize is "this is the preferred blocking for IO".

st_blocks is "this is how many 512-byte blocks the file has".

The names may be similar, but they have nothing in common. They are in
totally different namespaces - one is in bytes, the other one in units of
"traditional UNIX block size", aka sector, aka 512 bytes. Trying to mix 
the two is doomed.

		Linus

