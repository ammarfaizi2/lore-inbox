Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTKJCFj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 21:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbTKJCFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 21:05:38 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:2188 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262425AbTKJCFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 21:05:37 -0500
Subject: Re: [PATCH] cfq + io priorities
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: axboe@suse.de, guichaz@yahoo.fr
Content-Type: text/plain
Organization: 
Message-Id: <1068428977.722.65.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Nov 2003 20:49:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:
> On Sun, Nov 09 2003, Guillaume Chazarain wrote:

>> A process has an assigned io nice level, anywhere
>> from 0 to 20. Both of
>>
>> OK, I ask THE question : why not using the normal
>> nice level, via current->static_prio ? This way,
>> cdrecord would be RT even in IO, and nice -19
>> updatedb would have a minimal impact on the system.
>
> I don't want to tie io prioritites to cpu
> priorities, that's a design decision.

Sure, but do it in a way that's friendly to
all the apps and admins that only know "nice".

nice_cpu   sets CPU niceness
nice_net   sets net niceness
nice_disk  sets disk niceness
...
nice       sets all niceness values at once

>>> these end values are "special" - 0 means the process
>>> is only allowed to do io if the disk is idle, and 20
>>> means the process io is considered
>>
>> So a process with ioprio == 0 can be forever
>> starved. As it's not
>
> Yes
>
>> done this way for nice -19 tasks (unlike FreeBSD),
>> wouldn't it be safer to give a very long deadline
>> to ioprio == 0 requests ?
>
> ioprio == 0 means idle IO. It follows from that that
> you can risk infinite starvation if other io is happening.
> Otherwise it would not be idle io :-)
>
> CFQ doesn't assign request deadlines. That would
> be another way of handling starvation.

Keeping IO niceness as similar to CPU niceness as
you can would be very good for admins.


