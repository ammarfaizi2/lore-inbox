Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWIQFB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWIQFB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 01:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWIQFB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 01:01:26 -0400
Received: from main.gmane.org ([80.91.229.2]:40408 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932123AbWIQFBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 01:01:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ganesan Rajagopal <rganesan@myrealbox.com>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Date: Sun, 17 Sep 2006 10:24:23 +0530
Message-ID: <xkvh64fn6qkg.fsf@grajagop-lnx.cisco.com>
References: <Pine.LNX.4.64.0609151535030.6761@scrub.home> <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <20060915131317.aaadf568.akpm@osdl.org> <450BCF97.3000901@sgi.com> <450C20C7.30604@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: grajagop-lnx.cisco.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.51 (gnu/linux)
Cancel-Lock: sha1:WmWAgF8aVLcV1wIaesnd3MsgBGc=
Cc: ltt-dev@shafik.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Karim Yaghmour <karim@opersys.com> writes:

> And I submit to you an idea which I submitted to Ingo yesterday and have
> not yet received feedback on. Here's static markup as it could be
> implemented:
>
> The plain function:
>  int global_function(int arg1, int arg2, int arg3)
>  {
>          ... [lots of code] ...
>
>          x = func2();
>
>          ... [lots of code] ...
>  }
>
> The function with static markup:
>  int global_function(int arg1, int arg2, int arg3)
>  {
>          ... [lots of code] ...
>
>          x = func2(); /*T* @here:arg1,arg2,arg3 */
>
>          ... [lots of code] ...
>  }
>
> The semantics are primitive at this stage, and they could definitely
> benefit from lkml input, but essentially we have a build-time parser
> that goes around the code and automagically does one of two things:
> a) create information for binary editors to use
> b) generate an alternative C file (foo-trace.c) with inlined static
>    function calls.

This makes sense to me, when combined with kprobes. I refer to the dtrace
Usenix http://www.sun.com/bigadmin/content/dtrace/dtrace_usenix.pdf. They
argue (Section 4.2 Statically-defined Tracing):

"While FBT (Function Boundary Tracing) allows for comprehensive probe
coverage, one must be familar with the kernel implementation to use it
effectively. To have probes with semantic meaning, one must allow probes to
be statically declared in the implementation. The mechanism for implemting
this is typically a macro that expands to a conditional call into a tracing
framework if tracing is enabled. While the probe effect of this mechanism is
small, it is observable: even when disabled, the expanded macro introduces a
load, a compare and a taken branch.

In keeping with our philosophy of zero probe effect when disabled, we have
implemnted a statically defined tracing (SDT) provider by defining a C macro
that expands to a call to a non-existent function with a well-defined prefix
("__dtrace_probe_"). When the kernel linker sees a relocation against a
function with this prefix, it replaces the call instruction with a
no-operation and records the full name of the bogus function along with the
location of the call site. Wehn the SDT provider loads, it queries the
auxiliary structure and creates a probe with a name specified by the
function name. When a SDT probe is enabled, teh no-operation at the call
site is patched to be a call into an SDT-controlled trampoline that
transfers control into DTrace."






-- 
Ganesan Rajagopal

