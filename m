Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268411AbUHaPw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268411AbUHaPw0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 11:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268738AbUHaPw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 11:52:26 -0400
Received: from mail.tmr.com ([216.238.38.203]:6662 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268411AbUHaPwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 11:52:22 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] waitid system call
Date: Tue, 31 Aug 2004 11:53:12 -0400
Organization: TMR Associates, Inc
Message-ID: <ch26fb$8ps$1@gatekeeper.tmr.com>
References: <20040831062656.GU11465@devserv.devel.redhat.com><12606.1093348262@www48.gmx.net> <20040830234057.2bdec761.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1093967147 9020 192.168.12.100 (31 Aug 2004 15:45:47 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <20040830234057.2bdec761.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jakub Jelinek <jakub@redhat.com> wrote:
> 
>>On Mon, Aug 30, 2004 at 11:04:46PM -0700, Roland McGrath wrote:
>> > +			/*
>> > +			 * For a WNOHANG return, clear out all the fields
>> > +			 * we would set so the user can easily tell the
>> > +			 * difference.
>> > +			 */
>> > +			if (!retval)
>> > +				retval = put_user(0, &infop->si_signo);
>> > +			if (!retval)
>> > +				retval = put_user(0, &infop->si_errno);
>> > +			if (!retval)
>> > +				retval = put_user(0, &infop->si_code);
>> > +			if (!retval)
>> > +				retval = put_user(0, &infop->si_pid);
>> > +			if (!retval)
>> > +				retval = put_user(0, &infop->si_uid);
>> > +			if (!retval)
>> > +				retval = put_user(0, &infop->si_status);
>>
>> Is it really necessary to check the exit code after each put_user?
>> 	if (!retval && access_ok(VERIFY_WRITE, infop, sizeof(*infop)))) {
>> 		retval = __put_user(0, &infop->si_signo);
>> 		retval |= __put_user(0, &infop->si_errno);
>> 		retval |= __put_user(0, &infop->si_code);
>> 		retval |= __put_user(0, &infop->si_pid);
>> 		retval |= __put_user(0, &infop->si_uid);
>> 		retval |= __put_user(0, &infop->si_status);
>> 	}
>> is what kernel usually does when filling multiple structure members.
> 
> 
> I don't think it matters much.  Taking seven trips into the fault handler
> where one would do seems a bit dumb though.

If all you need is good/bad you could just separate the put_user calls 
with || and only go through the error handler once.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
