Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWHAEni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWHAEni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWHAEni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:43:38 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:56504 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751260AbWHAEni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:43:38 -0400
Date: Mon, 31 Jul 2006 21:41:02 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: David Masover <ninja@slaphack.com>
cc: tdwebste2@yahoo.com, Theodore Tso <tytso@mit.edu>,
       Nate Diller <nate.diller@gmail.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of 
 view"expressed by kernelnewbies.org regarding reiser4 inclusion]
In-Reply-To: <44CED777.5080308@slaphack.com>
Message-ID: <Pine.LNX.4.63.0607312133080.15179@qynat.qvtvafvgr.pbz>
References: <20060801034726.58097.qmail@web51311.mail.yahoo.com>
 <44CED777.5080308@slaphack.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006, David Masover wrote:

>> And perhaps a
>> really good clustering filesystem for markets that
>> require NO downtime. 
>
> Thing is, a cluster is about the only FS I can imagine that could reasonably 
> require (and MAYBE provide) absolutely no downtime. Everything else, the more 
> you say it requires no downtime, the more I say it requires redundancy.
>
> Am I missing any more obvious examples where you can't have enough 
> redundancy, but you can't have downtime either?

just becouse you have redundancy doesn't mean that your data is idle enough for 
you to run a repacker with your spare cycles. to run a repacker you need a time 
when the chunk of the filesystem that you are repacking is not being accessed or 
written to. it doesn't matter if that data lives on one disk or 9 disks all 
mirroring the same data, you can't just break off 1 of the copies and repack 
that becouse by the time you finish it won't match the live drives anymore.

database servers have a repacker (vaccum), and they are under tremendous 
preasure from their users to avoid having to use it becouse of the performance 
hit that it generates. (the theory in the past is exactly what was presented in 
this thread, make things run faster most of the time and accept the performance 
hit when you repack). the trend seems to be for a repacker thread that runs 
continuously, causing a small impact all the time (that can be calculated into 
the capacity planning) instead of a large impact once in a while.

the other thing they are seeing as new people start useing them is that the 
newbys don't realize they need to do somthing as archaic as running a repacker 
periodicly, as a result they let things devolve down to where performance is 
really bad without understanding why.

David Lang
