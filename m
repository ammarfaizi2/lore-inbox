Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWGMRGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWGMRGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 13:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWGMRGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 13:06:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:23320 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030253AbWGMRGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 13:06:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OZo0h6WodqMLKza+RpqO6pYbF253A5ePQA5C68MHZ4yBq+og4B7Sf5D5m3DzP/nzpUOCIll+6vYKSjH2qdY9TGGM7z5+FX4woXmJBvAdvvxkyLIxcHi5ZN8XtA6TUnyWYejsO6emWPM/QzXyEGZ7eFRaXstfOuIyLAi2TYg7cSg=
Message-ID: <787b0d920607131006p5f55c9c7veadb840042a10ba@mail.gmail.com>
Date: Thu, 13 Jul 2006 13:06:32 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
Cc: ak@suse.de, tytso@mit.edu, drepper@redhat.com, arjan@infradead.org,
       rdunlap@xenotime.net, akpm@osdl.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org
In-Reply-To: <m1lkqx30pl.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607122200m4785f7ddmddf40c079a7460cb@mail.gmail.com>
	 <m164i257sl.fsf@ebiederm.dsl.xmission.com>
	 <787b0d920607130915q664d298bra8f6fee9286d8109@mail.gmail.com>
	 <m1lkqx30pl.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Albert Cahalan" <acahalan@gmail.com> writes:

> > Matching keywords, as is needed for /proc/*/status,
> > is also horribly slow. I ended up using gperf to make
> > a perfect hash table, then gcc's computed goto for
> > jumping to the code, and it still wasn't cheap to do.
> > (while /sys lacks this, the extra open-read-close is
> > certain to be far worse)
>
> I agree matching keywords and such seems slow.
>
> If the only overhead comes from open-read-close we can
> come up with a sys_readfile that doesn't need to actually
> open the file for one shot cases.

A sys_readfile would be great. It probably should
work like readlink. Supplying a struct stat without
a race condition would be good too.

Note that /sys will still be needlessly slow because
of the one-item-per-file idea. One of the few good
things about /proc is that you can get a whole
struct full of data all at once.

Fixing one bottleneck just leads to the next. It's best
to fix all the anti-performance stupidity at once.
