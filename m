Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbTJRQSd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 12:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbTJRQSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 12:18:33 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:42130 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261687AbTJRQSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 12:18:31 -0400
Date: Sat, 18 Oct 2003 18:18:11 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Eli Carter <eli.carter@inet.com>
Cc: John Bradford <john@grabjohn.com>, jw schultz <jw@pegasys.ws>,
       linux-kernel@vger.kernel.org
Subject: Compressions (was Re: Transparent compression in the FS)
Message-ID: <20031018161811.GA11066@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(The newline above is deliberate, no need for a flamewar)
In-Reply-To: <3F90175B.2000502@inet.com>

On Fri, 17 October 2003 11:22:51 -0500, Eli Carter wrote:
> John Bradford wrote:
> >>
> >>Note that a file compressed with bzip2 is not necessarily smaller than 
> >>the same file compressed with gzip.  (It can be quite a bit larger in 
> >>fact.)
> >
> >Have you noticed that with real-life data, or only test cases?
> 
> Real-life data.  I don't remember the exact details for certain, but as 
> best as I can recall:  I was dealing with copies of output from build 
> logs, telnet sessions, messages files, or the like (i.e. text) that were 
> (many,) many MB in size (and probably highly repetitititititive).  I 
> wound up with a loop that compressed each file into a gzip and a bzip2, 
> compared the sizes, and killed the larger.  There were a number of .gz's 
> that won.  (I have also read that gzip is better at text compression 
> whereas bzip2 is better at binary compression.  No, I don't remember the 
> source.)

Simple example:

dd if=/dev/urandom of=foo count=1 bs=31k
for i in `seq 10`; do cat foo >> bar; done
cp bar foo
time gzip foo
time bzip2 bar
ls -l foo.gz bar.bz2

Notice how bzip2 runs ~80 times longer and output remains ~60% bigger.
And now try this:

time bzip2 foo.gz
ls -l foo.gz.bz2 bar.bz2

How wonderful, bzip2 runs fast again and the result is even smaller.
:)


While this example is constructed, it demonstrates nicely where bzip2
sucks.  It also demonstrates how simply bzip2 could be improved.
Anyone up for a fun hack?

Jörn

-- 
Ninety percent of everything is crap.
-- Sturgeon's Law
