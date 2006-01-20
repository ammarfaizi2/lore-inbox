Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWATNnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWATNnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 08:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWATNnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 08:43:12 -0500
Received: from main.gmane.org ([80.91.229.2]:3796 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750886AbWATNnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 08:43:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ian Soboroff <isoboroff@acm.org>
Subject: Re: io performance...
Date: Fri, 20 Jan 2006 08:42:35 -0500
Message-ID: <9cfek33vwvo.fsf@nist.gov>
References: <43CB4CC3.4030904@fastmail.co.uk> <43CD2405.4070902@cfl.rr.com>
	<43CDED23.5060701@fastmail.co.uk> <43CE5C7A.5060608@cfl.rr.com>
	<43D07C08.5000903@fastmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: static-216-49-77-242.dsl.cavtel.net
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:WpGs7ZBB97AXdmETEoAT33UIXiA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk> writes:

> Phillip Susi wrote:
>> Right, the kernel does not know how many disks are in the array, so
>> it can't automatically increase the readahead.  I'd say increasing
>> the readahead manually should solve your throughput issues.
>
> Any guesses for a good number?
>
> We're in RAID10 (2+2) at the moment on 2.6.8-smp. These are the block
> numbers I'm getting using bonnie++ :
>
>[...]
> We're still wondering why rd performance is so low - seems to be the
> same as a single drive. RAID10 should be the same performance as RAID0
> over two drives, shouldn't it?

I think bonnie++ measures accesses to many small files (INN-like
simulation) and database accesses.  These are random accesses, which
is the worst access pattern for RAID.  Seek time in a RAID equals the
longest of all the drives in the RAID, rather than the average.  So
bonnie++ is domninated by your seek time.

Ian


