Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316799AbSEVAZN>; Tue, 21 May 2002 20:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316800AbSEVAZN>; Tue, 21 May 2002 20:25:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:13560 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316799AbSEVAZM>; Tue, 21 May 2002 20:25:12 -0400
Subject: Re: Kernel BUG 2.4.19-pre8-ac1 + preempt
From: Robert Love <rml@tech9.net>
To: Erik McKee <camhanaich99@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020521194349.67491.qmail@web14206.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 May 2002 17:25:11 -0700
Message-Id: <1022027112.967.86.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-21 at 12:43, Erik McKee wrote:
> Hello
> 
> This output...
> <snip>

I don't think this has anything to do with preempt.  The current task
was not preemptible (hence the error notice on exit - is that why you
blame preempt?).  There is also no preempt_schedule call in your back
trace.

Looks to me like you died coming off an IDE interrupt and a resulting
read - you ran out of free pages and bit the dust there.  Dunno why,
though.  I don't have an mm_inline.h:78 in my tree, but I do have a
DEBUG_LRU near it ...

	Robert Love

