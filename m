Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268432AbRIDTvy>; Tue, 4 Sep 2001 15:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268511AbRIDTve>; Tue, 4 Sep 2001 15:51:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22154 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268432AbRIDTvU>; Tue, 4 Sep 2001 15:51:20 -0400
Subject: Re: [RFD] readonly/read-write semantics
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        Linus Torvalds <torvalds@transmeta.com>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF40F28F05.61359C2E-ON87256ABD.006684BD@boulder.ibm.com>
From: "Bryan Henderson" <hbryan@us.ibm.com>
Date: Tue, 4 Sep 2001 12:50:48 -0700
X-MIMETrack: Serialize by Router on D03NM088/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 09/04/2001 01:50:51 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>> 1) I want to see files open for write have nothing to do with it.  Unix
>> open/close is not a transaction, it's just a connection.  Some
applications
>> manage to use open/close as a transaction, but we're seeing less and
less
>> of that as more sophisticated facilities for transactions become
available.
>>
>> How many times have we all been frustrated trying to remount read only
when
>> some log file that hasn't been written to for hours is open for write?
>>
>> A file write is in progress when a write() system call hasn't returned,
not
>> when the file is open for write.
>
>Uh-oh...  How about shared mappings?

It's always shared mappings, isn't it?  :-)

Virtual memory access to the file is even easier, though.  A write in
progress is an individual store to virtual memory.  The only way you could
even see it is if a page fault is in progress.  So the most you would need
to wait for in going into the hard "read only" state I defined is for any
page I/O to complete.  And for the "no new writes" state, you just write
protect all the pages (and any new ones that fault in too).



