Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbTI2MeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 08:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbTI2MeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 08:34:08 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:33408
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263300AbTI2MeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 08:34:02 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: John Bradford <john@grabjohn.com>, Larry McVoy <lm@bitmover.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: log-buf-len dynamic
Date: Mon, 29 Sep 2003 07:30:52 -0500
User-Agent: KMail/1.5
References: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com> <200309290356.27600.rob@landley.net> <200309291124.h8TBOlam000872@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200309291124.h8TBOlam000872@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309290730.52631.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 September 2003 06:24, John Bradford wrote:
> > BK is really just a merging tool that fixes rejects
> > automatically, everything else is details...
>
> IFF that is true, then taking this to it's logical extreme, what is
> the point in having an SCM system for kernel development at all?
>
> It could be argued that what we really need is enhanced versions of
> diff and patch that actually understand C constructs and are able to
> make intellegent decisions about merging two pieces of code, even
> without knowledge of other merges.

But you can't always make intelligent merging decisions without knowledge 
about other merges.

Suppose that tree 1 has a line "x=function(3*yy)+2", and tree 2 has the 
corresponding line "x=fred+1".  Your only merge choice is to pick one or the 
other.  You as a fully intelligent human being have no other choice unless 
you're writing fresh code.

Now let's look at the patch history back to where the two trees diverged from:

Patch series:

original line:
	x=yy+1;

Patch 1:
-	x=yy+1;
+	x=function(3*yy)+2;

Patch 2:
-	x=yy+1;
+	x=fred+1;

Looking at this, you can see that the result you probably want is 
"x=function(3*fred)+2;", but you couldn't figure that out until you'd see the 
original line they both diverged from.  One tree probably had s/yy/fred/ 
applied to it, and the other tweaked the algorithm, thus the merges conflict 
going either way.

But if the original line had instead been "x=fred+2;", the logical merge would 
instead be "x=function(3*yy)+1;". 

Original line:
	x=fred+2;

Patch 1:
-	x=fred+2;
+	x=function(3*yy)+2;

Patch 2:
-	x=fred+2;
+	x=fred+1;

Logical merge: "x=function(3*yy)+1;"

You CANNOT KNOW THIS until you see the common ancestor they diverged from.  
There just isn't enough information to work it out, unless you do so from 
first principles by actually comprehending the algorithm being implemented 
and what the changes are trying to accomplish.

That's why bitkeeper has to remember all the past changes to do its job of 
merging new ones.

> 'Enhanced' is, of course, a complete understatement.  What I am
> suggesting is basicaly adding A.I. functionality to diff and patch, to
> the point where they can merge three pieces of C code as efficiently
> as a good developer can.

If you've gotten AI working, why not just have it write the code and save us 
the trouble?

> This would probably involve analysing code and identifying discrete
> sections, (analogous to the way a human developer would draw a flow
> chart), within which the purpose of algorithms and variable names
> could be deduced.

You're suggesting making a computer figure out the purpose of something.  
Uh-huh.  Has this ever happened, even once, in the entire history of 
computing?

> This knowledge could then be used to adapt code
> that was submitted as a diff against a compltely different piece of
> code.

Written in a diferent language, performing a completely different task even...

> Ultimately, it should be possible for two people to independently
> write code to do a certain task, for one of them to add an extra
> facility to their codebase, and for the enhanced diff and patch tools
> to then add this facilty to the other, completely separate,
> implementation.

It'd be nice, sure.  I do not know how to implement that.  I don't know 
anybody who does.  If you do, by all means code it up.  (My guess is you 
don't understand the scope of the problem, but I could always be wrong....)

> John

Rob
