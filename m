Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTLELLl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 06:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263857AbTLELLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 06:11:41 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:64269 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263653AbTLELLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 06:11:40 -0500
Message-ID: <3FD06A77.4050901@aitel.hist.no>
Date: Fri, 05 Dec 2003 12:22:31 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: rob@landley.net
CC: Szakacsits Szabolcs <szaka@sienet.hu>, linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
References: <200312041432.23907.rob@landley.net> <Pine.LNX.4.58.0312042300550.2330@ua178d119.elisa.omakaista.fi> <200312041802.52067.rob@landley.net>
In-Reply-To: <200312041802.52067.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Thursday 04 December 2003 15:10, Szakacsits Szabolcs wrote:
> 
>>On Thu, 4 Dec 2003, Rob Landley wrote:
>>
>>>What are the downsides of holes?  [...] is there a performance penalty to
>>>having a file with 1000 4k holes in it, etc...)
>>
>>Depends what you do, what fs you use. Using XFS XFS_IOC_GETBMAPX you might
>>get a huge improvement, see e.g. some numbers,
>>
>>	http://marc.theaimsgroup.com/?l=reiserfs&m=105827549109079&w=2
>>
>>The problem is, 0 general purpose (like cp, tar, cat, etc) util supports
>>it, you have to code your app accordingly.
> 
> 
> Okay, I'll bite.  How would one go about adding hole support to cat? :)

Easy.  Look at the data you're writing. Don't ever write zeroes, seek
ahead in the file being written instead.  The filesystem will create a hole
if possible.  You may want to optimize this a bit by not seeking past
very small runs of zeroes.

Of course cat is sometimes used to write to things that aren't regular
files, so make sure seek is supported and fall back to ordinary writing
when it isn't.

Helge Hafting

