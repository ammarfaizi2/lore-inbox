Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUCNXPp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 18:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUCNXPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 18:15:45 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:13820 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S262006AbUCNXPo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 18:15:44 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: kernel threads holding /dev/console
References: <yw1x8yi3dpz8.fsf@ford.guide>
	<20040314150346.387b59a6.akpm@osdl.org>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 15 Mar 2004 00:15:41 +0100
In-Reply-To: <20040314150346.387b59a6.akpm@osdl.org> (Andrew Morton's
 message: 03:46 -0800")
Message-ID: <yw1x4qsrdnqa.fsf@ford.guide>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> mru@kth.se (Måns Rullgård) wrote:
>>
>> I'm trying to set up a pivot_root hack to do some things, switch root,
>>  and then unmount the original root.  However, the unmount fails
>>  because ksoftirqd/0, events/0, kblockd/0 and aio/0 have /dev/console
>>  opened.  Why are they doing this?  Can it be prevented?  This happens
>>  when using kernel 2.6.3 (2.6.4 is reportedly broken on Alpha).  It
>>  works with a 2.4 kernel using the same script.  Does anyone have a
>>  hint?
>
> That's a bug.
>
> keventd and friends are currently holding /dev/console open three times. 
> It's all inherited from init.
>
> Steal the relevant parts of daemonize() to fix that up.

That did the trick.  Thanks for the quick response.

-- 
Måns Rullgård
mru@kth.se
