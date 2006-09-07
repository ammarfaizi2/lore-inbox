Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbWIGN7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWIGN7K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 09:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWIGN7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 09:59:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49345 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751773AbWIGN7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 09:59:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jean Delvare <jdelvare@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] proc: readdir race fix (take 3)
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com>
	<200609062312.57774.jdelvare@suse.de>
	<m1zmdcty4i.fsf@ebiederm.dsl.xmission.com>
	<200609071031.33855.jdelvare@suse.de>
Date: Thu, 07 Sep 2006 07:57:52 -0600
In-Reply-To: <200609071031.33855.jdelvare@suse.de> (Jean Delvare's message of
	"Thu, 7 Sep 2006 10:31:33 +0200")
Message-ID: <m1wt8frd7j.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <jdelvare@suse.de> writes:

> On Thursday 7 September 2006 00:43, Eric W. Biederman wrote:
>> Have you tested 2.6.18-rc6 without my patch?
>
> Yes I did, it didn't crash after a couple hours. Of course it doesn't 
> prove anything as the crash appears to be the result of a race.
>
> I'll now apply Oleg's fix and see if things get better.
>
>> I guess the practical question is what was your test methodology to
>> reproduce this problem?  A couple of more people running the same
>> test on a few more machines might at least give us confidence in what
>> is going on.
>
> "My" test program forks 1000 children who sleep for 1 second then look for 
> themselves in /proc, warn if they can't find themselves, and exit. So 
> basically the idea is that the process list will shrink very rapidly at 
> the same moment every child does readdir(/proc).
>
> I attached the test program, I take no credit (nor shame) for it, it was 
> provided to me by IBM (possibly on behalf of one of their own customers) 
> as a way to demonstrate and reproduce the original readdir(/proc) race 
> bug.

Ok.  So whatever is creating lots of child threads that tripped you
up is probably peculiar to the environment on your laptop.

Eric
