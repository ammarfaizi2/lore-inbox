Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267713AbUJCDxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUJCDxT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 23:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUJCDxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 23:53:19 -0400
Received: from gizmo03ps.bigpond.com ([144.140.71.13]:11201 "HELO
	gizmo03ps.bigpond.com") by vger.kernel.org with SMTP
	id S267713AbUJCDxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 23:53:15 -0400
Message-ID: <415F77A7.4070207@bigpond.net.au>
Date: Sun, 03 Oct 2004 13:53:11 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]> <200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com> <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au> <20041002201933.41e4cdc4.pj@sgi.com>
In-Reply-To: <20041002201933.41e4cdc4.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Peter writes:
> 
>>The way I see it you just replace the task's affinity mask with a 
>>pointer to its "CPU set" which contains the affinity mask shared by 
>>tasks belonging to that set ...
> 
> 
> I too like this suggestion.  The current duplication of cpus_allowed and
> mems_allowed between task and cpuset is a fragile design, forced on us
> by incremental feature addition and the need to maintain backwards
> compatibility.

OK.

> 
>>A possible problem is that there may be users whose use of the current 
>>affinity mechanism would be broken by such a change.  A compile time 
>>choice between the current mechanism and a set based mechanism would be 
>>a possible solution.
> 
> 
> Do you mean kernel or application compile time?

Kernel compile time.

>  The current affinity
> mechanisms have enough field penetration that the kernel will have to
> support or emulate these calls for a long period of deprecation at best.

That's unfortunate.  Are the (higher level) ways in which they're used 
incompatible with CPU sets or would CPU sets be seen as being a better 
(easier) way of doing the job?

If the choice is at kernel compile time then those users of the current 
mechanism can choose it and new users can choose CPU sets.  Of course, 
this makes gradual movement from one model to the other difficult to say 
the least.

> 
> So I guess you mean application compile time.  However, the current user
> level support, in glibc and other libraries, for these calls is
> sufficiently confused, at least in my view, that rather than have that
> same API mean two things, depending on a compile time switch, I'd rather
> explore (1) emulating the existing calls, just as they are, (2) adding
> new calls that are try these API's again, in line with our kernel
> changes, and (3) eventually deprecate and remove the old calls, over a
> multi-year period.

I would agree with that.  I guess that emulation would not be possible 
on top of my suggestion hence the requirement for the "fragile design" etc.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
