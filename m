Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267943AbUHaWF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267943AbUHaWF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUHaWCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:02:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:43200 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269006AbUHaUGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:06:21 -0400
Date: Tue, 31 Aug 2004 13:05:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Pavel Machek <pavel@ucw.cz>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Aug 2004, Horst von Brand wrote:
> 
> You do need extra tools anyway, placing them in the kernel is cheating (and
> absolutely pointless, IMHO).

I agree.

There's no point to having the kernel export information that is already 
inherent in the main stream.

I've seen all these examples of exposing MP3 ID information as a "side 
stream", and that's TOTALLY POINTLESS! The information is already there, 
it's in a standard format, and exporting it as a stream buys you 
absolutely nothing.

Where named attributes make sense is when they are _independent_ data.  
Data that is only tangentially related to the main stream itself, and
which the main stream _cannot_ encompass because of some real technical
issue.

In a graphical environment, the "icon" stream is a good example of this.  
It literally has _nothing_ to do with the data in the main stream. The
only linkage is a totally non-technical one, where the user wanted to
associate a secondary stream with the main stream _without_ altering the
main one. THAT is where named streams make sense.

But if you want to look at one particular file inside a tar-file, do so in 
user space. There are zero advantages to exposing it as a side-stream, and 
there are absolutely _tons_ of disadvantages.

In short, named streams only make sense if:
 - they are tied to the file some way that is _independent_ of the file 
   contents (since if it's dependent on the file contents, you're just a 
   ton better off regenerating it with a caching server)
 - there are serious reasons to keep the lookup synchronized (since if 
   there isn't such a reason, you're just better off with a separate 
   shadow tree in user space)

And realize that the "separate shadow tree" actually works very well.  
That's how version control systems like CVS have always worked. It's
certainly how you can make icon information work too. If you use a tool
for accessing the data, the tool can maintain coherency and you'll never
care about the side stream.

Which means that normally we really don't _want_ named streams. In 99% of
all cases we can use equally good - and _much_ simpler - tool-based
solutions.

Which means that the only _real_ technical issue for supporting named
streams really ends up being things like samba, which want named streams
just because the work they do fundamentally is about them, for externally
dictated reasons. Doing named streams for any other reason is likely just
being stupid.

Once you do decide that you have to do named streams, you might then 
decide to use them for convenient things like icons. But it should very 
much be a secondary issue at that point.

		Linus
