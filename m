Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbUDXQB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUDXQB7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 12:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbUDXQB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 12:01:59 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:31439 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S262441AbUDXQB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 12:01:57 -0400
Date: Sat, 24 Apr 2004 10:02:25 -0600
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
Message-ID: <20040424160224.GA26244@bounceswoosh.org>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu> <Pine.LNX.4.53.0404231624010.1352@chaos> <yw1xoepio24x.fsf@kth.se> <Pine.LNX.4.53.0404231651120.1643@chaos> <40898834.7040803@techsource.com> <20040424022458.GA16166@zero> <20040424073622.GN596@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20040424073622.GN596@alpha.home.local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24 at  9:36, Willy Tarreau wrote:
>On Fri, Apr 23, 2004 at 10:24:58PM -0400, Tom Vier wrote:
>> On Fri, Apr 23, 2004 at 05:18:44PM -0400, Timothy Miller wrote:
>> > In a drive with multiple platters and therefore multiple heads, you 
>> > could read/write from all heads simultaneously.  Or is that how they 
>> > already do it?
>> 
>> fwih, there was once a drive that did this. the problem is track alignment.
>> these days, you'd need seperate motors for each head.
>
>I think they now all do it. Haven't you noticed that drives with many
>platters are always faster than their cousins with fewer platters ? And
>I don't speak about access time, but about sequential reads.

Only one read/write element can be active at one time in a modern disk
drive.  The issue is that while the drive's headstack was originally
in alignment, all sorts of factors can cause it to fall out of
alignment.  If that occurs, the heads might not line up with each
other, meaning that when you used to line up with A1 and B1 (side A,
cylinder 1) your two heads now align with A1 and B40.

Every surface has embedded servo information, which allows the drive
to work around mechanical variability and handling damage.  The
difference in position between adjacent heads in a drive factors into
a parameter called "head switch skew".  Head switch skew is "how long
does it take us to seek to the next sequential LBA after reading the
last LBA on a track/head?"  Track-to-track skew is how long to seek
and settle on the adjacent track on the same head.

These two parameters are used to generate the drive's format, which in
turn account for the sequential throughput.  (higher skews means lower
usage duty cycle means lower overall throughput.)  If the skews are
set too low, the drive blows revs because it can't settle in time for
the LBA it needs to read.

In general, a drive with lots of heads will perform better on most
workloads because it doesn't have to seek as far radially to cover the
same amount of data.  However, a single-headed and a multi-headed
drive of the same generation should be virtually identical in
sequential throughput... within a few percent.  If anything, the
single-headed drive should be a bit faster because track-to-track
skews are typically smaller than headswitch skews.

--eric



-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

