Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312119AbSCXWzL>; Sun, 24 Mar 2002 17:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312127AbSCXWzB>; Sun, 24 Mar 2002 17:55:01 -0500
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:41900 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id <S312119AbSCXWyp>; Sun, 24 Mar 2002 17:54:45 -0500
Date: Sun, 24 Mar 2002 22:54:01 +0000
From: Nick Craig-Wood <ncw@axis.demon.co.uk>
To: Andrew Morton <akpm@zip.com.au>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>, yodaiken@fsmlabs.com,
        Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020324225401.A30709@axis.demon.co.uk>
In-Reply-To: <Pine.LNX.4.33.0203161203050.31971-100000@penguin.transmeta.com> <200203242112.WAA09406@cave.bitwizard.nl> <3C9E46BD.D0BEEB2A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 01:35:57PM -0800, Andrew Morton wrote:
> Frankly, all the discussion I've seen about altering page sizes
> threatens to add considerable complexity for very dubious gains.
> The only place where I've seen a solid justification is for
> scientific applications which have a huge working set, and need
> large pages to save on TLB thrashing.

A widely used example is mprime - the mersenne prime finding program (
http://www.mersenne.org/ ).  This typically uses 8 or more MBytes of
RAM which it completely thrashes.

The program is written in very efficient assembler code and has been
designed not to thrash the TLB as much as possible, but with a working
set of > 8 MBs (which is iterated through many times a second at
maximum memory bandwith) large pages would make a real improvement to
it.  Since each run takes weeks any improvement would be eagerly
snatched at by the 1000s of people running this program ;-)

If there was some hack where 4MB pages could be allocated for
applications like this then I'd be very happy!

-- 
Nick Craig-Wood
ncw@axis.demon.co.uk
