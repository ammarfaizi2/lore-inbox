Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135590AbRDSIWM>; Thu, 19 Apr 2001 04:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135591AbRDSIWC>; Thu, 19 Apr 2001 04:22:02 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:42758 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S135590AbRDSIV6>; Thu, 19 Apr 2001 04:21:58 -0400
Message-ID: <3ADE9FFA.3E8476C2@idb.hist.no>
Date: Thu, 19 Apr 2001 10:21:14 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Jeremy Jackson <jerj@coplanar.net>, linux-kernel@vger.kernel.org
Subject: Re: Is there a way to turn file caching off ?
In-Reply-To: <Pine.LNX.3.96.1010418134153.20558A-100000@medusa.sparta.lu.se> <3ADD99E8.FB7F8542@coplanar.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson wrote:

> currently all the kernel's heuristics are feed-back control loops.
> what you are asking for is a feed-forward system: a way for the application
> to tell kernel "I'm only reading this once, so after I'm done, throw it out
> straight away"
> and "I'm only writing this data, so after I'm done, start writing it out and
> then forget it"
> 
This is hard to get right.  Sure - your unpack/copy program read once
and
writes once.  But the stuff might be used shortly thereafter by
another process.  For example:  I unpack a kernel tarball.  tar
knows it writes only once and might not need more than 5M to do
this as efficient as possible with my disks.  A lot of other cache
could be saved, fewer things swapped out.
But then I compile it.  Todays system ensures that lots of the source
is in memory already.  Limiting the caching to what tar needed
however will force the source to be read from disk once during
the compile - not what I want at all.  

A program may know its own access pattern, but it don't usually know
future access patterns.  Well, backing up the entire fs could benefit
from a something like this, you probably won't need the backup again
soon.  But this is hard to know in many other cases.

Helge Hafting
