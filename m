Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbUB1Wir (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 17:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbUB1Wir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 17:38:47 -0500
Received: from mail.tmr.com ([216.238.38.203]:61319 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261940AbUB1Wil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 17:38:41 -0500
Message-ID: <404118A2.1060301@tmr.com>
Date: Sat, 28 Feb 2004 17:39:30 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x: iowait problem while burning a CD
References: <200402271802.51604.ornati@fastwebnet.it> <Pine.LNX.4.44.0402271915590.1747-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0402271915590.1747-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Fri, 27 Feb 2004, Paolo Ornati wrote:
> 
> 
>>trying to burn a CD "on the fly" I have noticed a strange thing. During the 
>>burning "iowait" remains enough low (~3%, MAX 10%) but, after a little 
>>time, it suddenly and quickly goes up to 80-90%: in this condition MKFS 
>>seems unable to fill the FIFO buffer as quickly as the CD-writer writes  
> 
> 
>>Any ideas?
> 
> 
> At that point, mkisofs is probably running into a bazillion
> small files, in subdirectories all over the place.
> 
> Because a disk seek + track read takes 10ms, it's simply not
> possible to read more than maybe 100 of these small files a
> second, so mkisofs can't keep up.

I certainly have seen this, although there is something odd in the 
process with large files as well. I sometimes see it in 2.4 as well, so 
it may be a characteristic of the application.

What to do about it (things to try, not requirements):

- use fs= to increase the size of the fifo a bit, remember to put "m"
   after the buffer size or it will be taken in bytes. This helps with
   the problem Rik describes
- be sure DMA is on the CD and the drive
- allow ints during io
- I'm told deadline schedular but haven't tried it
- get a new version of cdrecord, build with the 2.6 headers, use
   ATAPI:/dev/hdX for dev= instead of ide-scsi (this is probably not
   critical for data CD in 2.6.2 and later, ide-scsi seems to work)
- use burn-free
- drop the speed of the burn
- build the ISO image first, burn from that instead of a pipe
- use growisofs for DVD

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
