Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUFKQaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUFKQaJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUFKQ1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:27:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51395 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264225AbUFKQWh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:22:37 -0400
Message-ID: <40C9DC3E.3050802@pobox.com>
Date: Fri, 11 Jun 2004 12:22:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>
Subject: Re: flush cache range proposal (was Re: ide errors in 7-rc1-mm1 and
 later)
References: <1085689455.7831.8.camel@localhost> <20040605092447.GB13641@suse.de> <20040606161827.GC28576@bounceswoosh.org> <200406100238.11857.bzolnier@elka.pw.edu.pl> <20040610061141.GD13836@suse.de> <20040610164135.GA2230@bounceswoosh.org> <40C89F4D.4070500@pobox.com> <40C8A241.50608@pobox.com> <20040610203350.GB2230@bounceswoosh.org>
In-Reply-To: <20040610203350.GB2230@bounceswoosh.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric D. Mudama wrote:
> On Thu, Jun 10 at 14:02, Jeff Garzik wrote:
> 
>> Oh, also:
>>
>> We'll need to write up precisely _why_ this is used, and give some 
>> examples of usage, for people reading the proposal (mostly T13-ish 
>> people) who have not been following the lkml barrier discussion closely.
> 
> 
> One comment...
> 
> There will need to be queued versions of this command, both legacy
> and first-party, since a flush cache command will abort an outstanding
> queue with error.
> 
> Second, I'm trying to figure out exactly how this might be used...


With flush cache range, it should perform exactly the same as a 
traditional flush cache with regards to queueing-related issues.

ATA drives normally used without queueing would be a target for this 
type of proposal.  Hopefully lower-end devices would not have trouble 
implementing flush cache (range).

Moving forward, in ATA TCQ is largely a transitory step to NCQ.

As such, Linux will probably have two methods of implementing barriers, 
the "pre-NCQ" method, and the NCQ method.

The pre-NCQ method most certainly involves heavy flush cache use.

The NCQ method, I presume, would involve almost exclusive use of queued 
FUA commands.  That way the OS knows precisely what has not yet hit the 
platter, on all data writes to disk.  It needs only to wait for queue 
completion before submitting the commit block (sector), also FUA.

	Jeff


