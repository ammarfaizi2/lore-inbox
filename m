Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263296AbTDRXNv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 19:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTDRXNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 19:13:51 -0400
Received: from dialup-36.157.221.203.acc50-nort-cbr.comindico.com.au ([203.221.157.36]:29700
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263296AbTDRXNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 19:13:50 -0400
Message-ID: <3EA08962.2010506@cyberone.com.au>
Date: Sat, 19 Apr 2003 09:25:22 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Toon van der Pas <toon@hout.vanvergehaald.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4
References: <20030418014536.79d16076.akpm@digeo.com> <20030418154911.GA16046@hout.vanvergehaald.nl>
In-Reply-To: <20030418154911.GA16046@hout.vanvergehaald.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toon van der Pas wrote:

>On Fri, Apr 18, 2003 at 01:45:36AM -0700, Andrew Morton wrote:
>
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm4/
>>
>>. A bunch of anticipatory scheduler patches.
>>
>>  For the first time ever, AS is working well with both IDE and SCSI
>>  under all the usual tests.
>>
>>  It works just fine on SCSI with zero TCQ tags, and with four TCQ tags. 
>>  At eight tags, read-vs-write performace is starting to measurably drop off.
>>  At 32 tags it is about 2000x slower than at zero or four tags.
>>
>>  My recommendation, as always, is to disable SCSI TCQ completely.  If you
>>  really must, set it to four tags.
>>
>
>What about drivers that bypass de SCSI layer?
>I administer a server with a Mylex RAID controller (DAC960)...
>
I'd say they will show the same behaviour. As far as we can tell
its an interaction between badly behaving TCQ disks (those which
allow lots of writes to bypass a read), and the anticipatory
scheduler. We will be working on fixing this so those inclined
can use huge numbers of outstanding tags without things going
too haywire.

