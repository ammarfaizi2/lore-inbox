Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbTFROL4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 10:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbTFROKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 10:10:55 -0400
Received: from auemail2.lucent.com ([192.11.223.163]:59031 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265219AbTFROIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 10:08:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.30053.342115.873654@gargle.gargle.HOWL>
Date: Wed, 18 Jun 2003 10:21:25 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, stoffel@lucent.com,
       gibbs@scsiguy.com, linux-kernel@vger.kernel.org, willy@w.ods.org,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
In-Reply-To: <20030618130533.1f2d7205.skraw@ithnet.com>
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
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephan> 7 days continuous test
Stephan> one file data corruption on day 1
Stephan> one file data corruption on day 4
Stephan> two file data corruptions on day 6
 
Stephan> Test is performed as follows:

Stephan> around 70-100 GB of data is transferred to a nfs-server with
Stephan> rc8 onto a RAID5 on 3ware-controller.  The data is then
Stephan> copied via tar onto a SDLT drive connected to an aic
Stephan> controller.  Afterwards the data is verified by tar.

Is the data verified after the transfer to the NFS server?  Does it
pass muster then using MD5 sums on the files?

What happens if you cut the tape drive out of the loop and copy the
data to another partition on the 3ware controller and do the compare
then?

I assume you're doing:

  tar -c -f /dev/tape --verify /path/to/files

and that's when you get the errors?  Or are you writing to tape, and
then doing a compare with:

  tar -c -f /dev/tape /path/to/files
  tar -d -f /dev/tape /path/to/files

Stephan> Since rc8 this runs stable (froze before during the first
Stephan> day).

How much RAM is in the box, and how much free space is on the
filesystem?  I've been trying to replicate this type of test on
2.5.7x, but I've been having issues.  I'm also just dumping a pile of
MP3s to tape and reading them back to check.

Stephan> Most of the several files tar'ed are beyond the 2 GB file
Stephan> size. They vary from around 100MB upto about 15 GB per file,
Stephan> around 70 GB minimum summed up.  Of course I exchanged the
Stephan> tapes and the drive. Didn't get better.

This is an interesting data point.  What happens if you make all the
files be 2.5gb in size, do you get corruption more consistently then?  

I'm interested in this issue because I want to make sure that tape
backups work reliably on Linux.  

John
