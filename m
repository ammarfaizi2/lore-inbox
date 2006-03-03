Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWCCREd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWCCREd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 12:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWCCREd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 12:04:33 -0500
Received: from www.starshine.org ([216.240.40.167]:18102 "EHLO
	mx.starshine.org") by vger.kernel.org with ESMTP id S1030246AbWCCREc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 12:04:32 -0500
Date: Fri, 3 Mar 2006 09:04:17 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: SEEK_HOLE and SEEK_DATA support?
Message-ID: <20060303170417.GA26909@starshine.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
From: jimd@starshine.org (Jim Dennis)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 03 Mar 2006 10:15:05 +0100 Arjan van de Ven Wrote:

> On Fri, 2006-03-03 at 03:33 -0500, Lee Revell wrote:
>> On Thu, 2006-03-02 at 13:49 -0800, Jim Dennis wrote:

>>>  I ask primarily because of the interplay between 64-bit systems and
>>>  things like /var/log/lastlog (which appears as a 1.2TiB file due to
>>>  the nfsnobody UID of 4294967294).

>>>  (I'm realize that adding support for these additional seek() flags
>>>  wouldn't solve the problem ... archiving tools would still have to
>>>  implement it.  And I can also hear the argument that Red Hat and
>>>  other
>>>  distributions should re-implement lastlog handling to use a more
>>>  modern
>>>  and efficient hashing/index format and perhaps that they should set
                                                                    ^^- NOT
>>>  nfsnobody to "-1" ... 

    [correction: they should NOT set ...]

>> So the presence of very high UIDs causes lastlog to be huge?  That
>> just
>> sounds like a RedHat bug.

> it causes it to be a sparse file

> lastlog is an array based file format ;) but sparse

 Perhaps I should have been a bit more clear.  /var/log/lastlog has
 been a sparse file in most implementation for ... well ... forever.

 The example issue is that the support for large UIDs and the convention
 of setting nfsnobody to -1 (4294967294) combine to create a file whose
 size is very large.  The du of the file is (in my case) only about
 100KiB.  So there's a small cluster of used blocks for the valid
 corporate UIDs that have ever accessed this machine ... then a huge
 allocate hole, and then one block storing the lastlog timestamp for
 nfsnobody.

 However, this message was not intended to dwell on the cause of that
 huge sparse file ... but rather to inquire as to the core issue; 
 how do we efficiently handle skipping over (potentially huge)
 allocation holes in a portable fashion that might be adopted by
 archiving and other tools?  I provided this example simply to point
 out that it does happen, in the real world and has a significant
 cost (40 minutes to scan through NULs with which the filesystem fills
 the hole for read()s).

 OpenSolaris has implemented a mechanism for doing this and it sounds
 reasonable from my admittedly superficial perspective.

-- 
Jim Dennis
