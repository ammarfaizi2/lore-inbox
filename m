Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTLBSdU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTLBSdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:33:20 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:63247
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262864AbTLBSdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:33:16 -0500
Date: Tue, 2 Dec 2003 10:33:10 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: kernwek jalsl <edityacomm@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Rmap was: 2.4.20 page cache information
Message-ID: <20031202183310.GT1566@mis-mike-wstn.matchmail.com>
Mail-Followup-To: kernwek jalsl <edityacomm@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20031202123323.73771.qmail@web20712.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031202123323.73771.qmail@web20712.mail.yahoo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 04:33:23AM -0800, kernwek jalsl wrote:
> Hello Everyone;
> 
> On my embedded system having 64MB of RAM and no swap,
> I see the  following information on opening
> /proc/meminfo:
> 

Everything goes through the page cache, including all of your apps.  The
executables are mapped through the page cache, cache is combined with     
executable data.

And you have a kernel patched with the rmap VM.

All numbers are seperate below:

>        total:    used:    free:  shared: buffers: 
> cached:
> Mem:  62894080 47947776 14946304        0  4964352
> 23674880
> Swap:        0        0        0
> MemTotal:        61420 kB

MemTotal = 

> MemFree:         14596 kB
> Active:          32340 kB
> Inact_dirty:         0 kB
> Inact_laundry:    6336 kB
> Inact_clean:       236 kB
> Inact_target:     7780 kB

Not sure why Inact_target is in there, but it adds up almost perfect to
memtotal.

These below are within the active/inactive lists:

> MemShared:           0 kB
> Buffers:          4848 kB
> Cached:          23120 kB
> SwapCached:          0 kB

> ActiveAnon:      10760 kB
> ActiveCache:     21580 kB

Remember, that's active.  If it's not active, then it's in the inactive
list.  And it doesn't show inactive_anon memory (because it's not on a
seperate list)

> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:        61420 kB
> LowFree:         14596 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB
> 

Don't try adding the numbers on stock 2.4, they're just not fully accounted
in /proc/meminfo, but with rmap you can get close.

> As I see the total memory belonging to page cache is 
> 23MB and the anonymous list is 10MB. But if I count
> the RSS values for all the processes running on the
> system, it hardly comes to 15MB. Where is the rest of
> the 18MB? If I understand the "cached:" = (pages in
> the page cache - buffer cache). Even if I am doing
> lots of file activity; I cannot imagine the file
> system reads and writes holding up 18MB of the page 
> cache. Am I missing something here?

