Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154269-31090>; Sat, 19 Dec 1998 09:47:14 -0500
Received: from 8dyn47.delft.casema.net ([195.96.123.47]:26648 "EHLO rosie.BitWizard.nl" ident: "root") by vger.rutgers.edu with ESMTP id <154209-31090>; Sat, 19 Dec 1998 09:46:25 -0500
Message-Id: <199812191537.QAA03388@cave.bitwizard.nl>
Subject: Re: mmap() is slower than read() on SCSI/IDE on 2.0 and 2.1
In-Reply-To: <19981218010838.D28066@cerebro.laendle> from Marc Lehmann at "Dec 18, 98 01:08:38 am"
To: pcg@goof.com (Marc Lehmann)
Date: Sat, 19 Dec 1998 16:37:34 +0100 (MET)
Cc: linux-kernel@vger.rutgers.edu
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Marc Lehmann wrote:
> On Thu, Dec 17, 1998 at 06:52:50AM +0000, Linus Torvalds wrote:
> > Umm, the easiest hint is probably to just look at the faulting address. 
> > We have it available, after all. 
> > 
> > I suspect that such a simple heuristic would be fairly accurate, and it
> > can be coupled with other heuristics to further increase the accuracy. 
> 
> file copy, yes. But grep (and probably lots of others) don't access memory
> sequentially (as faster search algorithms exist)

A fast search algorithm, touches memory every n bytes where n is the
size of the largest constant string that you're searching for. 

That way "n" is typically small, so that you end up hitting the first
n bytes pretty often.

If you're acessing 

	struct blabla {
        int ...
	float ...
	char [];
	}

mmapped from a file, you might be looking for a certain float. As long
as you're doing a linear search, you'll again hit the first few bytes
of a page pretty often.


				Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
*   Never blow in a cat's ear because if you do, usually after three or  *
*   four times, they will bite your lips!  And they don't let go for at  *
*   least a minute. -- Lisa Coburn, age 9

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
