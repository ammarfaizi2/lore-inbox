Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282413AbRLWRm5>; Sun, 23 Dec 2001 12:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282508AbRLWRmq>; Sun, 23 Dec 2001 12:42:46 -0500
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:11406 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S282413AbRLWRm3>; Sun, 23 Dec 2001 12:42:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: esr@thyrsus.com
Subject: Re: Configure.help editorial policy
Date: Sun, 23 Dec 2001 04:40:26 -0500
X-Mailer: KMail [version 1.3.1]
Cc: David Garfield <garfield@irving.iisd.sra.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011220143247.A19377@thyrsus.com> <20011222081345.ETGO12125.femail34.sdc1.sfba.home.com@there> <20011222045805.A24575@thyrsus.com>
In-Reply-To: <20011222045805.A24575@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011223174227.NCJM25224.femail12.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 December 2001 04:58 am, Eric S. Raymond wrote:
> Rob Landley <landley@trommello.org>:
> > If you're going with a uniform terminology argument, you should drop MiB
> > altogether.  Unless you want to submit a patch to the kernel to
> > standardize all the other occurences everywhere else? :)
>
> Rob, you haven't looked at the actual changes I made, have you?

I looked at the patch, which was actually fairly small.  But it didn't seem 
to be the only potential change along these lines, and I thought I'd object 
now and avoid the rush. (Yeah I know, "too late"...)

> If you had, you'd realized that I have not introduced "kibibyte",
> or "mebibyte" or any of those terms anywhere.

Maybe not in this patch, but I got the impression it signified a policy 
decision to change terminology and stick with the new one uniformly, at least 
in the help files.

Since then, another part of the thread has indicated (and the help file now 
says at the top) that the help file will say "binary megabytes" instead of 
mebibytes. "mebibytes" for binary megabytes?  If this policy was there in the 
original patch, I missed it.

> The Configure.help
> changes involve only the IEC-standard abbreviations KiB, MiB, and GiB.

I didn't know the ISO was merely rubber-stamping somebody else's standard, 
but I can't say I'm suprised.  Well, I suppose I'm all for "catalyzing 
progress in the information-industry and university communities", as the 
IEC's web page says (isn't google fun).  Gee, we'd never be able to figure 
out what to call things if these guys weren't around to make decisions for 
us...

Specifically, it seems they adpoted it as amendment 2 to IEC 60027-2, 
standardizing kibi, mebi, gibi, tebi, pebi, and exbi, with symbols Ki, Mi, 
Gi, Ti, Pi, and Ei.  (A PiB obvioiusly and unambiguously being the number of 
bytes required to hold an accurate floating point representation of Pi.  :)

This does not, in fact, remove the term "mebibytes" to the discussion.  It 
means the current policy is to selectively follow part of the standard, and 
explicitly ignore the rest of the standard as too ugly to live.  The prefix 
"mebi" is, in fact, explicitly part of the IEC standard the ISO AOLed, thus 
"mebibytes" is what "MiB" is short for.  (I wasn't even the one to introduce 
the term mebibytes into this thread.)

> Try criticizing what I actually did, as opposed to what you merely *assume*
> I did.  You'll be more convincing that way.

Ooh, why start now? :)

What you did was announce a new editorial policy.  Look at the subject line 
of the thread.  That's noticeably larger than a single patch.

My objection is that this switch does not seem to be based on improving the 
understandability of the documentation to that documentation's intended users 
(who, on the whole, consider "7K RAM" to be sufficiently unambiguous without 
even a B).  We've always used domain based differentiation (ram is binary, 
networking is decimal, disk needs to be specified because manufacturers lie 
for marketing reasons).  This seems to be a solution in search of a problem.

Now I agree that as numbers get bigger the distinction matters more (2% per 
kilobyte, 5% per megabyte, 7% per gigabyte, and almost 10% per terabyte).  
But the binary or decimal nature of the measurement has always been 
application specific up until now, and I'm curious why that's suddenly not 
good enough anymore.  The new method is a much more fine-grained level of 
detail which is, in fact, easier to screw up.

Is the help file even currently accurate with this extra distinction made?  
Look at NCR53c8xx SCSI support, which says the transfer rate is 80 MB/s.  Is 
that really, accurately a million decimal megabytes per second?  Is it 80.3 
or 80.7?  Has anyone ever cared to confirm this who was not capable of 
looking in the code to determine the answer?  Is there a POINT in specifying 
"Men in Black" units everywhere that is currently generally accepted practice 
to default to binary (although using i for bInary makes as much sense as 
using i for decImal, if you ask me)?

The switch appears to be based on the assumption that conformance to a 
standard issued by a bureaucratic body is arbitrarily better than established 
practice.  And yet that's not what it does, because it refuses to use the 
long form...

The help file STILL uses the prefix "mega" without specifying binary or 
decimal in at least these sections:

Synchronous transfer frequency in MHz
Enable kernel debugging symbols
Virtual memory file system support
Remote GDB kernel debugging
GDB Stub kernel debug

Just looking at the first, do you really think saying "binary mega-transfers" 
is going to be less confusing?  How about "mebi-transfers", people will know 
right off what THAT means without having to look it up...

And you've already implied you want to change the symbol set for 
CONFIG_NINO_4MB and such.  How deeply into the kernel will these changes go?

The patch is a can of worms, and abandoning the current domain-based 
defaults (ram is binary, network is decimal, disk needs to pick one) is not 
something I see as an improvement.  But you're the maintainer...

Rob
