Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWBOVBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWBOVBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 16:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWBOVBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 16:01:53 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44182 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751291AbWBOVBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 16:01:53 -0500
To: David Lang <dlang@digitalinsight.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: pid_t range question
References: <Pine.LNX.4.61.0602071122520.327@chaos.analogic.com>
	<m1pslystkz.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61.0602091751220.30108@yvahk01.tjqt.qr>
	<m1r76c2yhf.fsf@ebiederm.dsl.xmission.com>
	<9a8748490602091213p2e020355ue516d59b7d0b6c81@mail.gmail.com>
	<Pine.LNX.4.61.0602101420550.31246@yvahk01.tjqt.qr>
	<Pine.LNX.4.62.0602151238520.5446@qynat.qvtvafvgr.pbz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Feb 2006 14:00:50 -0700
In-Reply-To: <Pine.LNX.4.62.0602151238520.5446@qynat.qvtvafvgr.pbz> (David
 Lang's message of "Wed, 15 Feb 2006 12:40:21 -0800 (PST)")
Message-ID: <m18xscs5fh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <dlang@digitalinsight.com> writes:

> On Fri, 10 Feb 2006, Jan Engelhardt wrote:
>
>>> Any of those 3 scheemes should keep pids below 6 digits as much as
>>> possible. We can still hit the cosmetic problem on boxes where more
>>> than 99999 processes are actually running at the same time, but most
>>> users will never encounter that.
>>>
>> I'd say let's remain doing whatever we're doing now. That is, a maximum of
>> 32768 concurrent pids, and whoever needs more (e.g. Sourceforge shell,
>> etc.) can always raise it to their needs.
>
> when you say 'continue doing what we are doing now' do you mean to include the
> hard-coded limit of 32K pids? or do you mean to not worry about the cosmetic
> issue and change the code to not hard-code the limit, but instead honor a
> max_pid >32K?

We actually do honor a max_pid > 32K but only if we are 64bit.

We need to fix /proc and resolve the issue that 32K pids takes about 320M
of RAM.  Which is 1/2 to 1/3 of all of low memory, on a 32bit box, if
we want a hight max_pid than 32K.  Of course 32K is also a very nice
number for the pid bitmap allocator as it is only 1 page.

With about 80K task structures+stack the machine goes 00M, because you
have exhausted all of low memory.

Eric
