Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVC3R3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVC3R3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 12:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVC3R3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 12:29:22 -0500
Received: from rzfoobar.is-asp.com ([217.11.194.155]:48532 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id S261889AbVC3R3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 12:29:15 -0500
Message-ID: <424AE1E9.8050804@is-teledata.com>
Date: Wed, 30 Mar 2005 19:29:13 +0200
From: Lutz Vieweg <lutz.vieweg@is-teledata.com>
Organization: Innovative Software AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040322 wamcom.org
X-Accept-Language: de, German, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: select() not returning though pipe became readable
References: <4242E0E2.4050407@is-teledata.com> <20050324170731.70a31f99.akpm@osdl.org>
In-Reply-To: <20050324170731.70a31f99.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Lutz Vieweg <lutz.vieweg@is-teledata.com> wrote:
> 
>>I'm currently investigating the following problem, which seems to indicate
>>a misbehaviour of the kernel:
>>
>>A server software we implemented is sporadically "hanging" in a select()
>>call since we upgraded from kernel 2.4 to (currently) 2.6.9 (we have to wait
>>for 2.6.12 before we can upgrade again due to the shared-mem-not-dumped-into-
>>core-files problem addressed there).
   ...
>>Any ideas?
>>Any hints on what to do to investigate the problem further?
> 
> 
> Could you at least test 2.6.12-rc1?  Otherwise we might be looking for a
> bug whicj isn't there.

We'll do that, but it will take some time, as the server requirements are such
that we cannot easily setup yet another instance, we don't have that many 32GB-RAM
4-way-opterons :-)


Jim Nance wrote:
>>We are using that pipe, which is known only to the same one process, to
>>cause select() to return immediately if a signal (SIGUSR1) had been
>>delivered to the process (by another process), there's a signal handler
>>installed that does nothing but a (non-blocking) write of 1 byte to the
>>writing end of the pipe.
> 
> 
> I'm not sure if this is what is causing your problem, but shouldnt you
> be doing a blocking write?  It may be that the pipe is not writeable
> at the moment the signal arives.  I think that could cause the symptoms
> you describe.

If the pipe wasn't writeable at the time when the signal handler tried to
write a byte, that would mean there were already N (probably 4096) bytes in
the pipe, causing the select() to fall through, anyway. The semantic of
the pipe is not to count signal deliveries, but only to contain "something"
if there had been a reason to fall through the select().

Regards,

Lutz Vieweg


