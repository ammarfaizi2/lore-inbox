Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbTDYAAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264552AbTDXX7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:59:44 -0400
Received: from A17-250-248-87.apple.com ([17.250.248.87]:52677 "EHLO
	smtpout.mac.com") by vger.kernel.org with ESMTP id S264545AbTDXX6e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:58:34 -0400
Date: Fri, 25 Apr 2003 10:07:23 +1000
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: skraw@ithnet.com (Stephan von Krawczynski),
       linux-kernel@vger.kernel.org (linux-kernel)
To: John Bradford <john@grabjohn.com>
From: Stewart Smith <stewartsmith@mac.com>
In-Reply-To: <200304191622.h3JGMI9L000263@81-2-122-30.bradfords.org.uk>
Message-Id: <E41731BA-76B1-11D7-BE62-00039346F142@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, April 20, 2003, at 02:22  AM, John Bradford wrote:

>> I wonder whether it would be a good idea to give the linux-fs
>> (namely my preferred reiser and ext2 :-) some fault-tolerance.
>
> Fault tollerance should be done at a lower level than the filesystem.

I would (partly) disagree. On the FS level, you would still have to 
deal with the data having gone away (or become corrupted). Simply 
passing a (known) corrupted block to a FS isn't going to do anything 
useful. Having the FS know that "this data is known crap" could tell it 
to
a) go look at a backup structure (e.g. one of the many superblock 
copies)
b) guess (e.g. in disk allocation bitmap, just think of them all as 
used)
c) fail with error (e.g. "cannot read directory due to a physical 
problem with the disk"
d) try to reconstruct the data (e.g. search around the disk for magic 
numbers)

<snip>
> The filesystem doesn't know or care what device it is stored on, and
> therefore shouldn't try to predict likely failiures.

but it should be tolerant of them and able to recover to some extent. 
Generally, the first sign that a disk is dying (to an end user) is when 
really-weird-stuff(tm) starts happening. A nice error message from the 
file system when they try to go into the directory (or whatever) would 
be a lot nicer.

You could generalize the failure down to an extents type record (i.e. 
offset and length) which would suit 99.9% of cases (i think :). In the 
case of post-detection of error, the extra effort is probably worth it.

these kinda issues are coming up in my honors thesis too, so there 
might even be the (dreaded) code and discussion sometime near the end 
of the year :)
------------------------------
Stewart Smith
stewartsmith@mac.com
Ph: +61 4 3884 4332
ICQ: 6734154

