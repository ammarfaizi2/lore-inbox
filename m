Return-Path: <linux-kernel-owner+w=401wt.eu-S1755170AbWL3Q7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbWL3Q7O (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 11:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755171AbWL3Q7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 11:59:14 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:1440 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755170AbWL3Q7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 11:59:13 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: Re: Oops in 2.6.19.1
Date: Sat, 30 Dec 2006 16:59:35 +0000
User-Agent: KMail/1.9.5
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Chuck Ebbert <76306.1226@compuserve.com>
References: <200612201421.03514.s0348365@sms.ed.ac.uk> <200612280402.23474.s0348365@sms.ed.ac.uk> <200612280414.20266.s0348365@sms.ed.ac.uk>
In-Reply-To: <200612280414.20266.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612301659.35982.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 December 2006 04:14, Alistair John Strachan wrote:
> On Thursday 28 December 2006 04:02, Alistair John Strachan wrote:
> > On Thursday 28 December 2006 02:41, Zhang, Yanmin wrote:
> > [snip]
> >
> > > > Here's a current decompilation of vmlinux/pipe_poll() from the
> > > > running kernel, the addresses have changed slightly. There's no xchg
> > > > there either:
> > >
> > > Could you reproduce the bug by the new kernel, so we could get the
> > > exact address and instruction of the bug?
> >
> > It crashed again, but this time with no output (machine locked solid). To
> > be honest, the disassembly looks right (it's like Chuck said, it's
> > jumping back half way through an instruction):
> >
> > c0156f5f:       3b 87 68 01 00 00       cmp    0x168(%edi),%eax
> >
> > So c0156f60 is 87 68 01 00 00..
> >
> > This is with the GCC recompile, so it's not a distro problem. It could
> > still either be GCC 4.x, or a 2.6.19.1 specific bug, but it's serious.
> > 2.6.19 with GCC 3.4.3 is 100% stable.
>
> Looks like a similar crash here:
>
> http://ubuntuforums.org/showthread.php?p=1803389

I've eliminated 2.6.19.1 as the culprit, and also tried toggling "optimize for 
size", various debug options. 2.6.19 compiled with GCC 4.1.1 on an Via 
Nehemiah C3-2 seems to crash in pipe_poll reliably, within approximately 12 
hours.

The machine passes 6 hours of Prime95 (a CPU stability tester), four memtest86 
passes, and there are no heat problems.

I have compiled GCC 3.4.6 and compiled 2.6.19 with an identical config using 
this compiler (but the same binutils), and will report back if it crashes. My 
bet is that it won't, however.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
