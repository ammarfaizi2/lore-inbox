Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWCXXHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWCXXHu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWCXXHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:07:50 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:49328 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S964804AbWCXXHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:07:49 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: RSS Limit implementation issue
To: Ram Gupta <ram.gupta5@gmail.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Sat, 25 Mar 2006 00:06:54 +0100
References: <5ErmY-5vN-5@gated-at.bofh.it> <5EGm2-2eZ-27@gated-at.bofh.it> <5TBku-7fu-3@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FMvNW-0000xW-C7@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Gupta <ram.gupta5@gmail.com> wrote:
> On 2/9/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> On Iau, 2006-02-09 at 15:10 -0600, Ram Gupta wrote:

>> > I am working to implement enforcing RSS limits of a process. I am
>> > planning to make a check for rss limit when setting up pte. If the
>> > limit is crossed I see couple of  different ways of handling .
>> >
>> > 1. Kill the process . In this case there is no swapping problem.
>>
>> Not good as the process isn't responsible for the RSS size so it would
>> be rather random.
>>
> 
> I doubt I am missing some point here. I dont understand why the
> process isn't responsible for RSS size. This limit is process specific
> & the count of rss increases when the process maps some page in its
> page table.

It can't be responsible because the kernel is controlling the RSS size e.g.
by prefetching or swapping out. The process has very little means of
influencing these mechanisms, nor is there a way to actively shrink the RSS.

(It's perfectly legal to e.g. mmap a large file (1 GB) and memcopy that area
into another mmaped file, and the kernel is expected to keep sane even on a
16 MB machine.)

You may introduce a mechanism that allows a process to keep it's RSS < n,
but you'll have to deal with legacy processes at least for the next 20 years.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
