Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264400AbTDOIRW (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 04:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTDOIRW (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 04:17:22 -0400
Received: from dialup-120.157.221.203.acc50-nort-cbr.comindico.com.au ([203.221.157.120]:49668
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S264400AbTDOIRV (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 04:17:21 -0400
Message-ID: <3E9BC2A8.7090306@cyberone.com.au>
Date: Tue, 15 Apr 2003 18:28:24 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Benefits from computing physical IDE disk geometry?
References: <200304142122_MC3-1-346E-A549@compuserve.com>
In-Reply-To: <200304142122_MC3-1-346E-A549@compuserve.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:

>>If RAID1 can use the generic elevator then it should. I
>>guess it can't though.
>>
>
>
>  No, but it is feeding IO requests into the elevators of the 
>block devices below it.  For a given read, all it wants to do
>is pick one device to handle the work.  If it could look into
>the queues maybe it could make better decisions.
>
OK right. As far as I can see, the algorithm in the RAID1 code
is used to select the best drive to read from? If that is the
case then I don't think it could make better decisions given
more knowledge. It really wants to know if the disk head is
close to request x however it is impossible to tell where the
disk head will be by the time request x is the next in line
for that disk, regardless if it can look at the low level
queues or not.

It seems to me that a better way to layer it would be to have
the complex (ie deadline/AS/CFQ/etc) scheduler handling all
requests into the raid block device, then having a raid
scheduler distributing to the disks, and having the disks
run no scheduler (fifo).

In practice the current scheme probably works OK, though I
wouldn't know due to lack of resources here :P

