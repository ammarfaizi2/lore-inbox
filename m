Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161272AbWJDP66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161272AbWJDP66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbWJDP65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:58:57 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:2178 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1161272AbWJDP65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:58:57 -0400
Date: Wed, 4 Oct 2006 17:57:47 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Willy Tarreau <w@1wt.eu>,
       Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>,
       linux-kernel@vger.kernel.org
Subject: Compressing pages [was: Re: Smaller compressed kernel source tarballs?]
Message-ID: <20061004155747.GA4096@wohnheim.fh-wedel.de>
References: <20061002033511.GB12695@zimmer> <20061002033531.GA5050@1wt.eu> <Pine.LNX.4.61.0610031227420.32633@yvahk01.tjqt.qr> <4522AAC1.7050703@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4522AAC1.7050703@cfl.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 October 2006 14:24:01 -0400, Phillip Susi wrote:
> Jan Engelhardt wrote:
> >There are lots of obscure compression formats that achieve somewhat 
> >better compression at the cost of MUCH more time (neglecting they are 
> >not too open), such as MS CAB and ACE.
> 
> CAB is an archive container format, not a compression algorithm.  Last 
> time I worked on some code to handle it, they used the standard LZW 
> algorithm implemented by gzip ( but had the ability to support others in 
> the future ) and could only compress 32kb blocks.  The small block size 
> led to poor compression.

Actually, compression in 4KiB blocks is a _very_ interesting
benchmark.  Jffs2 works with that size for compression and other
compressed filesystems likely do the same, although possibly with
something larger like 64KiB.

And the results are completely different in that benchmark.  Gzip
actually beats bzip2 hands-down on compression ratio, for example.

I used to have a script, but cannot find it anymore.  Basically
something like:

while (read next 4KiB from input file) {
	compress chunk
	add compressed_size to total
}
print total

Jörn

-- 
Unless something dramatically changes, by 2015 we'll be largely
wondering what all the fuss surrounding Linux was really about.
-- Rob Enderle
