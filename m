Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269387AbUICIMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269387AbUICIMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269371AbUICIHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:07:51 -0400
Received: from holomorphy.com ([207.189.100.168]:63362 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269373AbUICIHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:07:10 -0400
Date: Fri, 3 Sep 2004 01:06:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: INIT hangs with tonight BK pull (2.6.9-rc1+)
Message-ID: <20040903080628.GN3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kirill Korotaev <dev@sw.ru>, torvalds@osdl.org,
	dtor_core@ameritech.net, linux-kernel@vger.kernel.org
References: <200409030204.11806.dtor_core@ameritech.net> <20040903073230.GM3106@holomorphy.com> <413826A6.4000503@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413826A6.4000503@sw.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Dmitry Torokhov wrote:
>> Well, I was excited about blowing away 100B from each task but am now
>> a bit concerned about the semantic impact of the refcounting part of it.
>> It's unclear what pins an ID while a tty has a reference to it without
>> the reference counting; Kirill, could you answer this?

On Fri, Sep 03, 2004 at 12:09:10PM +0400, Kirill Korotaev wrote:
> stop.
> tty doesn't hold reference to ID neither in my patch nor in the original 
> kernel.
> tty only knows session ID and wants to traverse all tasks with such ID. 
> if task dies it calls detach_pid() and it won't be found in such a loop.
> No reference counting is required.
> The problem was in loop. Or more exactly my 
> do_each_task_pid()/while_each_task_pid() macros were incompatible with 
> continue statement inside. It was really foolish error. Like the most are...

Well, that sounds easy enough to deal with. I suppose the reference
counting argument is that the refcounting is on the tty by the tasks
and not vice-versa, and disassociate_ctty() cleans up the SID reference.


-- wli
