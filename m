Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTDUSrV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbTDUSqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:46:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20682 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261722AbTDUSqD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:46:03 -0400
Date: Mon, 21 Apr 2003 19:58:06 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       "David S. Miller" <davem@redhat.com>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new system call mknod64
Message-ID: <20030421185806.GP10374@parcelfarce.linux.theplanet.co.uk>
References: <20030421193546.A10287@infradead.org> <Pine.LNX.4.44.0304211141590.9109-100000@home.transmeta.com> <20030421194749.A10963@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030421194749.A10963@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 07:47:49PM +0100, Christoph Hellwig wrote:
> On Mon, Apr 21, 2003 at 11:44:59AM -0700, Linus Torvalds wrote:
> > We HAVE to do the mapping somewhere. Old applications only use the lower 
> > 16 bits, and that's just something that MUST NOT be broken. 
> > 
> > The question is only _where_ (not whether) we do the mapping. Right now we 
> > keep "dev_t" in teh same format as we give back to user space, and thus we 
> > always map into that format internally. But we don't have to: we can have 
> > an internal format that is different from the one we show users.
> 
> Why do we need to do a mapping?  Old applications just won't see the
> high bits (they're mapped to whatever overflow value) - values that
> fit into the old 16bit range should never be remapped.

Why?  Whenever we deal with fs code, we _do_ map anyway (bytesex, if nothing
else).  Ditto for any network filesystems.

Let's go for 32:32 internal and simply map upon mknod(2) and friends.
On the syscall boundary.  End of problem.
