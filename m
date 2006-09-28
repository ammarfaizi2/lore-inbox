Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbWI1UFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbWI1UFH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbWI1UFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:05:07 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:37803 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP
	id S1751996AbWI1UFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:05:05 -0400
Message-ID: <000501c6e339$70a154a0$962e8d52@aldipc>
From: "roland" <devzero@web.de>
To: "Andrew Morton" <akpm@osdl.org>, "Jay Lan" <jlan@engr.sgi.com>
Cc: "Fengguang Wu" <fengguang.wu@gmail.com>, <linux-kernel@vger.kernel.org>,
       <lserinol@gmail.com>
References: <0e2001c6de7a$fe756280$962e8d52@aldipc><359067036.19509@ustc.edu.cn><008f01c6e27a$f9bd5460$962e8d52@aldipc><20060927155549.4a69490d.akpm@osdl.org><451C1AAA.3090301@engr.sgi.com> <20060928120952.9f09cbf7.akpm@osdl.org>
Subject: Re: I/O statistics per process
Date: Thu, 28 Sep 2006 22:05:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrew, jay - thank you very much for giving your comments on this issue and 
discussing this!

> I'd be interested in your opinions on all the above, please.

just kidding here a little bit (pardon!) - but from a user/admin perspective 
we "just" want something like this:

http://www.my-vserver.de/stuff/linux/process-explorer.png (especially mind 
the I/O columns in the middle of the screenshot)

awesome tool - but unfortunately mr. russinovich is working for the wrong 
company/developing for the wrong operating system.... ;)

regards
roland





----- Original Message ----- 
From: "Andrew Morton" <akpm@osdl.org>
To: "Jay Lan" <jlan@engr.sgi.com>
Cc: "roland" <devzero@web.de>; "Fengguang Wu" <fengguang.wu@gmail.com>; 
<linux-kernel@vger.kernel.org>; <lserinol@gmail.com>
Sent: Thursday, September 28, 2006 9:09 PM
Subject: Re: I/O statistics per process


> On Thu, 28 Sep 2006 11:55:38 -0700
> Jay Lan <jlan@engr.sgi.com> wrote:
>
>> Andrew Morton wrote:
>> > On Wed, 27 Sep 2006 23:22:02 +0200
>> > "roland" <devzero@web.de> wrote:
>> >
>> >>thanks. tried to contact redflag, but they don`t answer. maybe support 
>> >>is
>> >>being on holiday.... !?
>> >>
>> >>linux kernel hackers - there is really no standard way to watch i/o 
>> >>metrics
>> >>(bytes read/written) at process level?
>> >
>> > The patch csa-accounting-taskstats-update.patch in current -mm kernels
>> > (whcih is planned for 2.6.19) does have per-process chars-read and
>> > chars-written accounting ("Extended accounting fields").  That's 
>> > probably
>> > not waht you really want, although it might tell you what you want to 
>> > know.
>> >
>> >>it`s extremly hard for the admin to track down, what process is hogging 
>> >>the
>> >>disk - especially if there is more than one task consuming cpu.
>>
>> Rolend,
>>
>> The per-process chars-read and chars-writeen accounting is made
>> available through taskstats interface (see Documentation/accounting/
>> taskstats.txt) in 2.6.18-mm1 kernel. Unfortunately, the user-space CSA
>> package is still a few months away. You may, for now, write your
>> own taskstats application or go a long way to port the in-kernel
>> implementation of pagg/job/csa.
>>
>> However, the "Externded acocunting fields" patch does not provide you
>> straight forward answer. The patch provides accounting data only at
>> process termination (just like the BSD accounting) and it seems that
>> you want to see which run-away application (ie, alive) eating up your
>> disk. The taskstats interface offers a query mode (command-response),
>> but currently only delayacct uses that mode. We would need to make
>> those data available in the query mode in order for application to
>> see accounting data of live processes.
>
> ow.  That is a rather important enhancement to have.
>
>> >
>> > csa-accounting-taskstats-update.patch makes that information available 
>> > to
>> > userspace.
>> >
>> > But it's approximate, because
>> >
>> > - it doesn't account for disk readahead
>> >
>> > - it doesn't account for pagefault-initiated reads (althought it easily
>> >   could - Jay?)
>> >
>> > - it overaccounts for a process writing to an already-dirty page.
>> >
>> >   (We could fix this too: nuke the existing stuff and do
>> >
>> > current->wchar += PAGE_CACHE_SIZE;
>> >
>> >    in __set_page_dirty_[no]buffers().) (But that ends up being wrong if
>> >    someone truncates the file before it got written)
>> >
>> > - it doesn't account for file readahead (although it easily could)
>> >
>> > - it doesn't account for pagefault-initiated readahead (it could)
>> >
>> >
>> > hm.  There's actually quite a lot we could do here to make these fields
>> > more accurate and useful.  A lot of this depends on what the definition 
>> > of
>> > these fields _is_.  Is is just for disk IO?  Is it supposed to include
>> > console IO, or what?
>
> I'd be interested in your opinions on all the above, please.
> 

