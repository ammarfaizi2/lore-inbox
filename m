Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932778AbVHTBId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbVHTBId (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 21:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932773AbVHTBId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 21:08:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9392 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932597AbVHTBIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 21:08:32 -0400
Date: Fri, 19 Aug 2005 18:08:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and
 mmap
In-Reply-To: <20050819231542.GJ29811@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0508191805410.3412@g5.osdl.org>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk>
 <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk>
 <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org>
 <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org>
 <Pine.LNX.4.60.0508192144590.7312@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0508191352540.3412@g5.osdl.org>
 <Pine.LNX.4.60.0508192220440.7312@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0508191502050.3412@g5.osdl.org>
 <20050819231542.GJ29811@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Aug 2005, Al Viro wrote:
> 
> That looks OK except for
> 	* ncpfs fix is actually missing here

Well, the thing is, with the change to page_follow_link() and 
page_put_link(), ncpfs should now work fine - it doesn't need any fixing 
any more.

It was makign an assumption that used to be incorrect, but that assumption
became ok with the calling convention change - now the page_follow_link()
and page_put_link() functions work fine even if the page cache might get 
invalidated in between the calls.

So with your patch, things should be fine (and external filesystems will 
generate warnings on compiles, but should work fine, since the change 
maintains the ABI even if the API changed - which is pretty unusual).

		Linus
