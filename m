Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265281AbTFROlS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 10:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbTFROlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 10:41:18 -0400
Received: from mail.ithnet.com ([217.64.64.8]:21254 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S265281AbTFROlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 10:41:03 -0400
Date: Wed, 18 Jun 2003 16:54:25 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "John Stoffel" <stoffel@lucent.com>
Cc: marcelo@conectiva.com.br, stoffel@lucent.com, gibbs@scsiguy.com,
       linux-kernel@vger.kernel.org, willy@w.ods.org, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030618165425.7db8d907.skraw@ithnet.com>
In-Reply-To: <16112.30053.342115.873654@gargle.gargle.HOWL>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
	<16103.39056.810025.975744@gargle.gargle.HOWL>
	<20030613114531.2b7235e7.skraw@ithnet.com>
	<Pine.LNX.4.55L.0306171744280.10802@freak.distro.conectiva>
	<20030618130533.1f2d7205.skraw@ithnet.com>
	<16112.30053.342115.873654@gargle.gargle.HOWL>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jun 2003 10:21:25 -0400
"John Stoffel" <stoffel@lucent.com> wrote:

> 
> Stephan> 7 days continuous test
> Stephan> one file data corruption on day 1
> Stephan> one file data corruption on day 4
> Stephan> two file data corruptions on day 6
>  
> Stephan> Test is performed as follows:
> 
> Stephan> around 70-100 GB of data is transferred to a nfs-server with
> Stephan> rc8 onto a RAID5 on 3ware-controller.  The data is then
> Stephan> copied via tar onto a SDLT drive connected to an aic
> Stephan> controller.  Afterwards the data is verified by tar.
> 
> Is the data verified after the transfer to the NFS server?  Does it
> pass muster then using MD5 sums on the files?

No, the content is not verified to be the same as on the nfs clients. But
this is not the point here, it could as well be bad content that is saved to
tape, and if you get wrong verification for this, your bad data simply got
worse. Right?

> What happens if you cut the tape drive out of the loop and copy the
> data to another partition on the 3ware controller and do the compare
> then?

I have not managed to get the corruption on archives written to (the same)
3ware partition instead of tape up to this day.

> 
> I assume you're doing:
> 
>   tar -c -f /dev/tape --verify /path/to/files

No. See your second guess.

> and that's when you get the errors?  Or are you writing to tape, and
> then doing a compare with:
> 
>   tar -c -f /dev/tape /path/to/files
>   tar -d -f /dev/tape /path/to/files

Yes, I am separately verifying with "-d".

> Stephan> Since rc8 this runs stable (froze before during the first
> Stephan> day).
> 
> How much RAM is in the box, and how much free space is on the
> filesystem?  I've been trying to replicate this type of test on
> 2.5.7x, but I've been having issues.  I'm also just dumping a pile of
> MP3s to tape and reading them back to check.

See first post of the thread, in case it already vanished: 3 GB RAM, 320 GB
filesystem space, at least half free.

> Stephan> Most of the several files tar'ed are beyond the 2 GB file
> Stephan> size. They vary from around 100MB upto about 15 GB per file,
> Stephan> around 70 GB minimum summed up.  Of course I exchanged the
> Stephan> tapes and the drive. Didn't get better.
> 
> This is an interesting data point.  What happens if you make all the
> files be 2.5gb in size, do you get corruption more consistently then?  

Hm, I haven't tried this so far. My next guess would have been not to verify
but to read the data completely in (to disk) again and then do a verification
based on a file-compare utility. If there is a difference one can have a real
look on the data, which is a bit of a mess on tape.

> I'm interested in this issue because I want to make sure that tape
> backups work reliably on Linux.  

Well, two of the same kind :-)

Regards,
Stephan
