Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbVJLQhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbVJLQhu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 12:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbVJLQht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 12:37:49 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:25734 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751452AbVJLQht convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 12:37:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ru66GkGMLTJB/Uwf5XJFwssV/opFMdMVoeUI8tNdi8VMVV5WiA9LgUQe2FbQ8REOyAxvL+tyJTUMPb9vwu3For/y1kXpcv5uaqXkiS3gwGEGlUAaf/f/3qRMptGw1L7IuVeQwzn19DSYK7HKYvRkf+5PtNPEhoemMDLJYME4AhE=
Message-ID: <5bdc1c8b0510120937r45bbd26fr6f45b6e3a9895d3f@mail.gmail.com>
Date: Wed, 12 Oct 2005 09:37:47 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.14-rc4-rt1
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <1129065696.4718.10.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051011111454.GA15504@elte.hu>
	 <1129064151.5324.6.camel@cmn3.stanford.edu>
	 <5bdc1c8b0510111408n4ef45eadv1e12ec4d1271d971@mail.gmail.com>
	 <5bdc1c8b0510111413q7b1ea391n3bc27924d928b963@mail.gmail.com>
	 <1129065696.4718.10.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Tue, 2005-10-11 at 14:13 -0700, Mark Knecht wrote:
> > The machine had been essentially 'User space idle' for the previous
> > two hours. The screen saver had kicked in. Audio was running and the
> > machine was busy. I woke it up, gave xscreensaver my password, read
> > email, sent the previous mail, then picked up the telephone to make a
> > call. Not 2 seconds later the xruns occurred!
>
> So what does /proc/latency_trace report?
>
> Lee

Well, unfortunately it doesn't appear to report anythign helpful. The
maximum latency report did not change when the xrun occurred. This was
the last one reported and it happened long before the xrun:

(          ardour-8101 |#0): new 22 us maximum-latency critical section.
 => started at timestamp 1104476939: <do_IRQ+0x29/0x50>
 =>   ended at timestamp 1104476962: <do_IRQ+0x39/0x50>

Call Trace: <IRQ> <ffffffff8014c42c>{check_critical_timing+492}
       <ffffffff8014c64b>{sub_preempt_count_ti+75} <ffffffff80110159>{do_IRQ+57}
       <ffffffff8010e16c>{ret_from_intr+0}  <EOI>
<ffffffff8014c64b>{sub_preempt_count_ti+75}
       <ffffffff80249a37>{clear_page+7} <ffffffff8015b75a>{buffered_rmqueue+634}
       <ffffffff8015b963>{__alloc_pages+243} <ffffffff80167018>{do_no_page+264}
       <ffffffff801674ee>{__handle_mm_fault+414}
<ffffffff8014c64b>{sub_preempt_count_ti+75}
       <ffffffff80167c1b>{get_user_pages+971}
<ffffffff80167e00>{make_pages_present+176}
       <ffffffff8016aa0c>{do_mmap_pgoff+1756} <ffffffff801139d6>{sys_mmap+150}
       <ffffffff8010dbc6>{system_call+126}
 =>   dump-end timestamp 1104477102

mark@lightning ~ $

What next? IRQ-off possibly? I think it may be broken for AMD64 right now.

- Mark
