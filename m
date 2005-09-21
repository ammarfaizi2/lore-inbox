Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbVIUBBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbVIUBBx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 21:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVIUBBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 21:01:53 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:32834 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750861AbVIUBBw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 21:01:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mYPRH7M3rYmv1T/irhcrp1TjZyjuTS/Lv/GGJANkqAxaVB+78d2yGlpnSKWql4uDuZuo4TLjLiO5f6PMlljRyZxcMLDvu4BqyPJmWGu7S1SsHZZPviZOY+5gE3hPDhUunannJw1OLBARto5KVMeY2uOI1TmH9sNP9jiA3oh2kvk=
Message-ID: <e692861c05092018017ceef484@mail.gmail.com>
Date: Tue, 20 Sep 2005 21:01:51 -0400
From: Gregory Maxwell <gmaxwell@gmail.com>
Reply-To: gmaxwell@gmail.com
To: "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@suse.cz>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
In-Reply-To: <20050921000425.GF6179@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>
	 <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz>
	 <20050921000425.GF6179@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/05, Theodore Ts'o <tytso@mit.edu> wrote:
> The script could be improved by select random locations to damage the
> filesystem, instead of hard-coding the seek=7 value.  Seek=7 is good
> for testing ext2/ext3 filesystems, but it may not be ideal for other
> filesystems.

What would be interesting would be to overwrite random blocks in an
sub-exponentially increasing fashion, fsck and measure file loss at
every step. You fail the test if the system panics reading a FS that
passed a fsck. It would be interesting to chart files lost and files
silently corrupted over time...

Another interesting thought would be to snapshot a file system over
and over again while it's got a disk workout suite running on it..
Then fsck the snapshots, and check for the amount of data loss and
corruption.

> There is a very interesting paper that I coincidentally just came
> across today that talks about making filesystems robust against
> various different forms of failures of modern disk systems.  It is
> going to be presented at the upcoming 2005 SOSP conference.
> 
>         http://www.cs.wisc.edu/adsl/Publications/iron-sosp05.pdf

Very interesting indeed, although it almost seems silly to tackle the
difficult problem of making filesystems highly robust against oddball
failure modes while our RAID subsystem falls horribly on it's face in
the fairly common (and conceptually easy to handle) failure mode of a
raid-5 where two disks have single unreadable blocks on differing
parts of the disk. (the current raid system hits one bad block, fails
the whole disk, then you attempt a rebuild and while reading hits the
other bad block and downs the array).
