Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVATBT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVATBT5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 20:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVATBT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 20:19:56 -0500
Received: from mail.joq.us ([67.65.12.105]:14526 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262020AbVATBTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 20:19:50 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       CK Kernel <ck@vds.kolivas.org>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH][RFC] sched: Isochronous class for unprivileged soft rt
 scheduling
References: <41ED08AB.5060308@kolivas.org> <87is5tx61a.fsf@sulphur.joq.us>
	<41EE2987.1040005@kolivas.org> <873bwxpckv.fsf@sulphur.joq.us>
	<41EEF649.4070705@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 19 Jan 2005 19:21:23 -0600
In-Reply-To: <41EEF649.4070705@kolivas.org> (Con Kolivas's message of "Thu,
 20 Jan 2005 11:07:37 +1100")
Message-ID: <87pt00gajw.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Jack O'Quin wrote:
>> Try again with JACK 0.99.48.  It's in CVS now, but you probably need
>> this tarball to get around the dreaded SourceForge anon CVS lag...
>>
>> http://www.joq.us/jack/tarballs/jack-audio-connection-kit-0.99.48.tar.gz
>
> Thanks it finally ran to completion. By the way the patch you sent
> with the test suite did not apply so I had to do it manually
> (booraroom..)

Oops!  Sorry.  I generated those by hand using some rather crude 
`diff -u .... >> xxx.diff' commands.  

We should just add Rui's latest version to JACK CVS.

> Since I (finally) have it running at this end at last I'll do some
> benchmarking of my own to see how (lack of) priorities affects
> SCHED_ISO. If it is inadequate, it wont be too difficult to add them
> to the design. The problem with priorities is that once you go over
> the cpu limit everyone suffers equally; but that's a failsafe that you
> shouldn't actually hit in normal usage so it probably doesn't
> matter... 

I'd be surprised if we're hitting it in this test.  AFAICT, our
"Average DSP Load" should approximate your CPU limit.  That's running
in the 30% to 40% range.  Is there any way to verify this?  Is your
running average readable in /proc/sys/kernel somewhere?

We do need to test that the system degrades gracefully when the CPU is
overloaded.  That *will* happen (the dreaded P4 float denormal
problems quickly come to mind).  At some point, the user should be
allowed to choose how much CPU to consume, possibly shutting down
plugins as needed.

> Hmm come to think of it, it probably _is_ a good idea to implement
> priority support afterall.

Hard to say for sure without trying it.  These threads are dealing
with a realtime cycle that is smaller than normal scheduler time
slices.  Getting all the work done is important.  But, getting it done
in the right order might make a difference for important statistics
like Max Delay.
-- 
  joq
