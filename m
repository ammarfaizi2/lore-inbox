Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312230AbSCRIFq>; Mon, 18 Mar 2002 03:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312232AbSCRIFh>; Mon, 18 Mar 2002 03:05:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47374 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312230AbSCRIFc>;
	Mon, 18 Mar 2002 03:05:32 -0500
Date: Mon, 18 Mar 2002 08:05:31 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
Message-ID: <20020318080531.W4836@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au> <3C945D7D.8040703@mandrakesoft.com> <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 01:41:37PM +0000, Anton Altaparmakov wrote:
> We don't need fadvise IMHO. That is what open(2) is for. The streaming 
> request you are asking for is just a normal open(2). It will do read ahead 
> which is perfect for streaming (of data size << RAM size in its current form).

	A quick real world example of where fadvise can work well.
Imagine a database appliction that doesn't use O_DIRECT (for whatever
reason, could even be that they don't trust the linux implementation yet
:-).  So, this database gets a query.  That query requires a full table
scan, so it calls fadvise(fd, F_SEQUENTIAL).  Then another query does
row-specific access, and caching helps.  So it wants to turn off
F_SEQUENTIAL.
	Other applications can use this sort of stuff.  DBM could, for
instance.  So might GIMP.  Etc.  Dynamic hints have real world
applications.


Joel


-- 

print STDOUT q
Just another Perl hacker,
unless $spring
	-Larry Wall

			http://www.jlbec.org/
			jlbec@evilplan.org
