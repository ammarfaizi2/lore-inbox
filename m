Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbVATQ70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVATQ70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVATQ4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:56:19 -0500
Received: from web53806.mail.yahoo.com ([206.190.36.201]:46675 "HELO
	web53806.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262290AbVATQvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:51:38 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=iUl9oTz9Lvdvc8Krf67BCDT4YioZ5OB/JrxGs/Nlx9qvl1Cy7dSgGgwFjcIyC47kZHMgvQKZvW4H/3mAVvMbRFexDgJIo1Xg+7no6byGjlwIiAk6qJOAfeciiF/yG4ksgqwNkE3Rb/ofzURUxYwMcOqi58rVNi3sDaRUC31QDBg=  ;
Message-ID: <20050120165136.36914.qmail@web53806.mail.yahoo.com>
Date: Thu, 20 Jan 2005 08:51:36 -0800 (PST)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: Re: [ANNOUNCE] Linux-tracecalls, a new tool for Kernel development, released 
To: linux-kernel@vger.kernel.org
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200501192037.j0JKbpuA008501@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:

> If it can't find out where a function could be called through a pointer
> (very common due to the OOP-in-C style in the kernel) it has no chance.

Dear Horst,

  No chance of what?

  You do raise an interesting point. Linux-tracecalls already does "find out where a
function could be called through a pointer" internally.  Therefore, it would be trivial
to add some indication to the the head of the call chain that the subsearch aborted
because a callback was detected; and I shall do so in the next release of the tool
(which will shortly after kernel.org kernel 2.6.11 is released). 

  The fact that the tool at this stage of development does not do something that it
was never designed to do, does not make it worthless. Moreover, I believe the burden
of your comments to be ill-considered for the following reasons:

  The functions you refer to are the callbacks that I have explicitly referred
to at http://www.linuxrd.com/~carl/linux-tracecalls :

        “Also, by design, 'linux-tracecalls' will stop tracing when it reaches
         a syscall, a gcc-builtin function or a callback.”

  I should have further pointed out, were it not so obvious, that if the call
chain as produced by the tool begins with function ‘F’ (ie 'F' is the oldest ancestor
of the initial target function) then:

    1)  You have been saved all the work of doing the tracing manually to that
        point, not only for that particular chain but for all the chains leading
        to your initial target function.

    2)  You can then manually check at function ‘F’ to see if there is a callback
        behind it.

    3)  If you find there is a callback behind ‘F’ then you can do another query
        using the actual function represented by the callback as a new initial
        target.

    4)  Callbacks - due to the OOP implications you have pointed out - are in most
        cases ultimately invoked due to syscalls and the core part of the kernel
        generally  (drivers do use OOP of course but it is not the absolute necessity
        there it is in the case of, for example, the VFS).

        That being so the paths to the callbacks are generally short ; thus the tool
        is doing most of the work for you in any case, even in the minority of cases
        involving a callback.

    5)  The tool has also done all the macro expansions of function-yielding macros
        for you, which due to the recursive nature of kernel header files is a major
        job in itself.

  At some future date I would like to add the capabilities you suggest - however
'lnxtc.pl' is presently over 800 lines of code and what you are suggesting is at
least an order of magnitude harder than what has been accomplished already, so it
won't be next week

  If this tool is really as useless as you suggest then I shall discontinue development.

  But I strongly disagree.  NIH?
