Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269353AbUICH6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269353AbUICH6B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269360AbUICH6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:58:01 -0400
Received: from asplinux.ru ([195.133.213.194]:44046 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S269353AbUICH5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:57:47 -0400
Message-ID: <413826A6.4000503@sw.ru>
Date: Fri, 03 Sep 2004 12:09:10 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>, torvalds@osdl.org,
       dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: INIT hangs with tonight BK pull (2.6.9-rc1+)
References: <200409030204.11806.dtor_core@ameritech.net> <20040903073230.GM3106@holomorphy.com>
In-Reply-To: <20040903073230.GM3106@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>After doing BK pull last night INIT gets stuck in do_tty_hangup after
>>executing rc.sysinit. Was booting fine with pull from 2 days ago...
>>Anyone else seeing this?
>>I suspect pidhash patch because it touched tty_io.c, but I have not tried
>>reverting it as it is getting too late here... So I apologize in advance
>>if I am pointing finger at the innocent ;)
> 
> 
> Well, I was excited about blowing away 100B from each task but am now
> a bit concerned about the semantic impact of the refcounting part of it.
> It's unclear what pins an ID while a tty has a reference to it without
> the reference counting; Kirill, could you answer this?
stop.
tty doesn't hold reference to ID neither in my patch nor in the original 
kernel.
tty only knows session ID and wants to traverse all tasks with such ID. 
if task dies it calls detach_pid() and it won't be found in such a loop.
No reference counting is required.

The problem was in loop. Or more exactly my 
do_each_task_pid()/while_each_task_pid() macros were incompatible with 
continue statement inside. It was really foolish error. Like the most are...

Kirill

