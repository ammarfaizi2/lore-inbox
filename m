Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWCUJRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWCUJRh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 04:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWCUJRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 04:17:37 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:38266 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932210AbWCUJRg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 04:17:36 -0500
In-Reply-To: <20060320181255.16932b0d.akpm@osdl.org>
Subject: Re: [2/3 PATCH] Kprobes: User space probes support- readpage hooks
Sensitivity: 
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, davem@davemloft.net, linux-kernel@vger.kernel.org,
       prasanna@in.ibm.com, suparna@in.ibm.com
X-Mailer: Lotus Notes Release 6.5.1IBM February 19, 2004
Message-ID: <OFB22908E4.CE9C1F2E-ON80257138.0030CAF3-80257138.0032BABE@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Tue, 21 Mar 2006 09:14:06 +0000
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.53HF247 | January 6, 2005) at
 21/03/2006 09:17:57
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Andrew, the need is probably better stated as one where system-wide probing
or tracing is possible. There are times where one needs a global view. Of
course one can use multiple tools to obtain such data e.g. probes in kernel
space strace in user space and so on.  The advantages of supporting user
probes are as follows:

1) A single tool providing the data capture in a consistent manner eases
the problems of correlation of events across multiple tools (for kernel and
user space)
2) The dynamic aspect allows ad hoc probepoints to be inserted  where no
existing instrumentation is provided (emergency debug scenario for
example).
3) The user probe distinguishes itself from all other externally managed
tracing mechanisms in that probepoints are globally applied - i.e. without
reference to PID. Compare this with ptrace breakpoints (hence strace and
gdb) where tracepoints and breakpoints are localized to a specified set of
processes. user-probes achieves this by design without the side effects
(privatization of pages) that ptrace has.  Again this supports the global
view.
4) user-probes also supports the registering of the probepoints before an
the probed code is loaded. The clearly has advantages for catching
initialization problems.


A real life example of where this capability would have been very useful is
with a performance problem I am currently investigating. It involves a GPFS
+ SAMBA + TCPIP +  RDAC and some user-space video serving application. We
are looking are where the latencies are accumulating in the system for the
specific user application. It's a very hard problem. Having multiple tools
serve up a partial view and having to coordinate these view from both data
analysis and data gathering perspectives is a real nightmare.

- -
Richard J Moore
IBM Advanced Linux Response Team - Linux Technology Centre
MOBEX: 264807; Mobile (+44) (0)7739-875237
Office: (+44) (0)1962-817072


                                                                           
             Andrew Morton                                                 
             <akpm@osdl.org>                                               
                                                                        To 
             21/03/2006               prasanna@in.ibm.com                  
             02:12                                                      cc 
                                      ak@suse.de, davem@davemloft.net,     
                                      suparna@in.ibm.com, Richard J        
                                      Moore/UK/IBM@IBMGB,                  
                                      linux-kernel@vger.kernel.org         
                                                                       bcc 
                                                                           
                                                                   Subject 
                                      Re: [2/3 PATCH] Kprobes: User space  
                                      probes support- readpage hooks       
                                                                           
                                                                           




Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
>
> The basic idea is to insert probes on user applications which may or
>  may not be in memory, at the time of probe insertion.

umm yes, but what for?

What does this entire feature *do*?  Why does Linux need it?

OK, so it allows kernel modules to set breakpoints (via debug traps) into
user code.  But why do we want to be able to do that?  What are the
use-cases?

This may sound like boringly obvious stuff to you, but without a complete
problem statement from the designers, how are we to evaluate their proposed
solution?



