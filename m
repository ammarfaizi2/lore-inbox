Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161209AbWHAHZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161209AbWHAHZA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161323AbWHAHZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:25:00 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:55312 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1161209AbWHAHY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:24:59 -0400
Message-ID: <44CF01C1.9070802@argo.co.il>
Date: Tue, 01 Aug 2006 10:24:49 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: David Lang <dlang@digitalinsight.com>, David Masover <ninja@slaphack.com>,
       tdwebste2@yahoo.com, Nate Diller <nate.diller@gmail.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view"expressed
 by kernelnewbies.org regarding reiser4 inclusion]
References: <20060801064837.GB1987@thunk.org>
In-Reply-To: <20060801064837.GB1987@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Aug 2006 07:24:57.0365 (UTC) FILETIME=[975ADC50:01C6B53B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
>
> Ah, but as soon as the repacker thread runs continuously, then you
> lose all or most of the claimed advantage of "wandering logs".
> Specifically, the claim of the "wandering log" is that you don't have
> to write your data twice --- once to the log, and once to the final
> location on disk (whereas with ext3 you end up having to do double
> writes).  But if the repacker is running continuously, you end up
> doing double writes anyway, as the repacker moves things from a
> location that is convenient for the log, to a location which is
> efficient for reading.  Worse yet, if the repacker is moving disk
> blocks or objects which are no longer in cache, it may end up having
> to read objects in before writing them to a final location on disk.
> So instead of a write-write overhead, you end up with a
> write-read-write overhead.
>

There's no reason to repack *all* of the data.  Many workloads write and 
delete whole files, so file data should be contiguous.  The repacker 
would only need to move metadata and small files.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

