Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbUAXPzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 10:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266968AbUAXPzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 10:55:25 -0500
Received: from users.ccur.com ([208.248.32.211]:1789 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S265390AbUAXPzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 10:55:11 -0500
Date: Sat, 24 Jan 2004 10:55:06 -0500
From: Joe Korty <joe.korty@ccur.com>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Representation of large hex values
Message-ID: <20040124155506.GA10809@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 03:30:12PM +0000, Dr. David Alan Gilbert wrote:
> (OK, this isn't strictly a kernel thing - but it seems to be a good
> place for peoples thoughts on this, and the kernel would be one
> place to start it off)
> 
> The problem: Large (64 bit) hex values are cumbersome - especially
> when they contain strings of 0's in the middle
> 
> Suggestion: Print hex value with a seperator every 4 or 8 nybbles
> to aid in counting.  After some discussion it seems that _
> is a decent seperator - e.g.
> 
> 1000_0000_0000_1234
> 
> this is especially useful when you have a pile of numbers like
> 
> 1000000021771245
> 
> and you are trying to see if that is bigger or smaller than 
> the number 1000000232349876, yet it is pretty obvious when you
> try and compare 1000_0000_2177_1245 and 1000_0002_3234_9876.
> 
> I originally thought of using : like IPv6 but this can get
> in the way on languages which use : for other things.
> (and I don't think it is worth doing packed numbers like IPv6
> does - i.e. 1000_0_2177_1245 would be invalid).
> 
> For clarity, it would seem best to use a distinct format character;
> so perhaps prefix these numbers by 0y (read Oi!) and then you
> could use %y (and %Y if you REALLY want) in printf. Scanf equivalents
> would be taught to understand both formats; using 0y and _ makes
> code that doesn't understand the format fail noisily. So:
> 
> 0ydead_beef_1ced_ac1d
> 
> I don't think there is the necessity to force zero padding, so 
> 1_2177_1245 is valid; but _ shall not be the first character
> (so as not to construct an identifier). (I'm vaguely remembering
> that VHDL allows _ padding?)
> 
> If people like this then I'd be happy to write a modified
> printf/scanf, and I suggest that it gets used in limited places
> until the same could be integrated in gdb/binutils/other tools.
> 
> Suggestions and constructive comments welcome and apologies
> for disturbing your games of wack-the-penguin.

Hi David,
2.6.1-mm4 has a variant of this, limited to bitmaps and using the
comma as the seperator.   See bitmap_parse and bitmap_snprintf in
lib/bitmap.c

Replacing the comma with the underscore and moving the whole shebang
to printf/scanf sounds like a good idea to me.  Printf *should* be
able to manipulate bitmaps just as it does for other basics types
like strings and ints.

Why don't you whip up a patch and see what happens?

Regards,
Joe
