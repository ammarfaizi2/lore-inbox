Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTJGQAJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbTJGQAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:00:08 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:49145 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262429AbTJGQAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:00:00 -0400
Date: Tue, 7 Oct 2003 09:59:37 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: "E. Gryaznova" <grev@Namesys.COM>, linux-kernel@vger.kernel.org
Subject: Re: Can dbench be used for benchmarking fs?
Message-ID: <20031007095937.A1593@schatzie.adilger.int>
Mail-Followup-To: Nikita Danilov <Nikita@Namesys.COM>,
	"E. Gryaznova" <grev@Namesys.COM>, linux-kernel@vger.kernel.org
References: <3F82B4C6.707221A@namesys.com> <20031007082944.D1564@schatzie.adilger.int> <16258.53615.17755.970961@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16258.53615.17755.970961@laputa.namesys.com>; from Nikita@Namesys.COM on Tue, Oct 07, 2003 at 06:45:03PM +0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 07, 2003  18:45 +0400, Nikita Danilov wrote:
> Andreas Dilger writes:
>  > On Oct 07, 2003  16:42 +0400, E. Gryaznova wrote:
>  > > I use dbench for benchmarking the file systems and some results are
>  > > suspicious for me.
>  > > :
>  > > :
>  > > :
>  > > As the result: the measuring deviation is equal = 23.4062 - 15.7005 =
>  > > 7.7057 or about ~38% from average value.
>  > > 
>  > > So, I have 2 questions :
>  > > 1. Is there a way to avoid such big deviations on measuring a file
>  > > systems throughput and to get more stable results?
>  > > 2. Can dbench be used for benchmarking the file systems and if it is so
>  > > -- what is the predictable error on the measuring?
>  > 
>  > Dbench is not a good filesystem benchmark, because it deletes all of the
>  > files at the end.  Use something else for the filesystem benchmark - there
> 
> Err... What is wrong with deleting all files at the end? Or do you mean
> it should mix file operations during run?
> 
>  > are lots of them (bonnie, iozone, mongo, etc).
> 
> But why variance is so large?

Dbench is a bad filesystem benchmark because if all (or some large part)
of the files are deleted before the VM flushes them to disk, then you are
not really testing filesystem performance very much.  If you have enough
RAM in your system and a fast enough CPU you could complete the entire
dbench run without ever writing any data to disk.  There is some filesystem
activity (you need to create files and map pages), but it isn't a good test
of filesystem throughput.

The reason there is so much variability in the tests is that if the test
takes even a small amount more time to run this means more data gets flushed
to disk by the VM (instead of being deleted and never written), making the
test run longer and even _more_ data needs to get written, etc.

Dbench is a good multi-threaded filesystem stress program, but it isn't
a good benchmark.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

