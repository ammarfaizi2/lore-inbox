Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274681AbRJNHhA>; Sun, 14 Oct 2001 03:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274666AbRJNHgv>; Sun, 14 Oct 2001 03:36:51 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:51678 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S274749AbRJNHgd>;
	Sun, 14 Oct 2001 03:36:33 -0400
From: "John L. Males" <jlmales@softhome.net>
Organization: Toronto, Ontario, Canada
To: Andrea Arcangeli <andrea@suse.de>
Date: Sun, 14 Oct 2001 03:36:55 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re[08]: [CFT][PATCH] smoother VM for -ac
Reply-to: jlmales@softhome.net
CC: Rik van Riel <riel@conectiva.com.br>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Robert Love <rml@tech9.net>
Message-ID: <3BC90857.20424.67CBFF@localhost>
In-Reply-To: <20011012075429.N714@athlon.random>
In-Reply-To: <3BC64882.27834.2D200B0@localhost>; from jlmales@softhome.net on Fri, Oct 12, 2001 at 01:33:54AM -0500
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrea,

***** FYI, I am not on the kernel mailing list *****

I had a had a chance to do some testing with the unofficial SuSE
2.4.12 Kernel that I believe is based on your 2.4.12aa1.  

I used:

ftp://ftp.suse.com/pub/people/mantel/next/RPM/k_i386-2.4.12-0.i386.rpm

I have an AMD K6-2-500 and find that the Pentium or "default" SuSE
kernels hang using the AMD K6-2.  I was unable to compile the kernel
from the souce using:

ftp://ftp.suse.com/pub/people/mantel/next/linux-2.4.12.SuSE-0.tar.bz2

due some unknow technical problems.  One was "make xconfig" would not
build, and using "make oldconfig" and the usual make commands to
build a kernel caused a error with a module a ways down.  The kernel
image compiled fine.

Ok, enough of those side issues.  The meat of the testing results is
that the k_i386-2.4.12-0.i386.rpm kernel seems to fair very well with
the testing I have done.  The tests take about 20 minutes to complete
with the k_i386-2.4.12-0.i386.rpm kernel.  The test mix is a bit
interesting, so I will only suggest it might be nice to shorten the
lapsed time of the test, but may not be possible due to I/O being the
bottleneck.

With respect to comparing the same test but using the 2.4.10-ac12
kernel that appears to have the both of Rik van Riel's patches:

http://lwn.net/2001/1011/a/cache-reclaim.php3
http://lwn.net/2001/1011/a/smooth.php3

The results were not great.  The "exact" same test takes a little
over 3 hours to complete. 

The part of the test that seems to cause problems with the
2.4.10-ac12 involves a 300MB working set.  This 300MB working set was
on top of a basic 60MB (combined System, shared, cache and buffer)
after the initial system start up.  The system used for testing has
256MB RAM and 256MB Swap file.  It seems the 2.4.10-ac12 ends up with
extra memory (overhead??) allocated during this part of the test to
basically have next to nil shared+cache+buffer whilst having both RAM
and the cache full to the brim.  If that is not enough the
2.4.10-ac12 seems to vary at times back and forth +-25MB while the
working set is still trying to be processed by the kernel.  Along the
way the the 2.4.10-ac12 kernel also tends to kill or cause a signal 9
to some of the working set applications, but despite this the system
seems to churn on this 300MB working set for just about 3 hours
(other part of test brings total to just over 3 hours).

By comparison the k_i386-2.4.12-0.i386.rpm test during this same
300MB workig set showed little extra overhead.  Hence 300 + 60 did
cause RAM to fill up and next to nil of share+cache+buffer, but the
swap file too the balance in a more expected manner, i.e about 120 MB
into the swap file.  Hence the swap file was never pressured to it
full limit as would be expected.

In terms of workstation responsiveness, it was not great with the
k_i386-2.4.12-0.i386.rpm kernel, but was extremely, extremely to
ignoring workstation activity or taking in the order of 5+ minutes to
respond to simple things like launching qps, or changing directories
with kruiser and many big time problems getting into the screen saver
to unlock the workstation.

I do need to refine my tests a bit.  One thing I am going to do is
move the detailed system information I am trying to log during the
test to a different physical drive than where the swap files are
located.  I suspect this should ease the contention that may be
ensuing between the system's need to page to the swap file and the
need to keep logging the metric information.

I also need to find a way to collect certain metric information
during the test.  Not being a developer (I am a QA/Testing Person) it
may take me a bit of effort to cut and carve what I need from qps and
xosview to get the metric information that is lacking for these
tests.  I suspect I will not be able to look into the cutting and
carving of code until next weekend.  I may try this test on the
2.4.9-ac18, maybe even the 2.2.19 for a feel if they are greatly
different in results to the two kernels tested earlier today.


Regards,

John L. Males
Willowdale, Ontario
Canada
14 October 2001 03:36
mailto:jlmales@softhome.net


Date sent:      	Fri, 12 Oct 2001 07:54:29 +0200
From:           	Andrea Arcangeli <andrea@suse.de>
To:             	"John L. Males" <jlmales@softhome.net>
Copies to:      	Rik van Riel <riel@conectiva.com.br>,
linux-mm@kvack.org,
       	linux-kernel@vger.kernel.org, Alan Cox
<alan@lxorguk.ukuu.org.uk>
Subject:        	Re: [CFT][PATCH] smoother VM for -ac

> On Fri, Oct 12, 2001 at 01:33:54AM -0500, John L. Males wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > - -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Andrea,
> > 
> > I can do.  I see this is a VM is of keen interest.  Question for
> > you.
> >  To really compare apples to apples I could spider a web site or
> > two just find.  Then the challenge is to replay the "test" on the
> > gui, say KDE for example.  Do you know of any good tools that
> > would alow me to do a GUI record/playback?  I can then do an A vs
> > B comparison. 
> 
> For testing the repsonsiveness I usually check the startup time of
> applications like netscape with cold cache, later I just start an
> high vm load on my desktop and I see how long can I keep working
> without being too hurted. the first is certainly a measurable test,
> the second isn't reliable since it doesn't generate raw numbers and
> it's too much in function of the human feeling but it shows very
> well any
> patological problem of the code. But they may not be the best
> tests.  
> 
> > Also, remind me, can I find your kernel to test on the SuSE FTP
> > site or via kernel.org.  I had tried a few of the SuSE 2.4
> > kernels a few levels back and I recall I was going to the people
> > directory of the FTP site and getting them from mantel I seem to
> > recollect.
> 
> That's still fine procedure, only make sure to pick the latest
> 2.4.12 one based on 2.4.12aa1 before running the tests. thanks,
> 
> > I will search about on internet to see if I can find a
> > record/playback too to get some sort of good A vs B comparison.
> > 
> > 
> > Regards,
> > 
> > John L. Males
> > Willowdale, Ontario
> > Canada
> > 12 October 2001 01:33
> > mailto:jlmales@softhome.net
> 
> Andrea


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use 
<http://www.pgp.com>
Comment: .

iQA/AwUBO8lOiuAqzTDdanI2EQLfrgCfTPXHDyEEoAWfTdWC28UaMzv1EAQAoKKT
PjOOkmCNggHekWz35GZugJnt
=FfXm
-----END PGP SIGNATURE-----



"Boooomer ... Boom Boom, how are you Boom Boom" Boomer 1985 - February/2000
