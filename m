Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268631AbUHME6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268631AbUHME6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 00:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268975AbUHME6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 00:58:20 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47763 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268631AbUHME6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 00:58:16 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040812235116.GA27838@elte.hu>
References: <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu>  <20040812235116.GA27838@elte.hu>
Content-Type: text/plain
Message-Id: <1092373132.3450.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 00:58:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 19:51, Ingo Molnar wrote:
> i've uploaded the latest version of the voluntary-preempt patch:
>      
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O6
> 

Interesting results.  One of the problems is kallsyms_lookup, triggered
by the printks:

 0.100ms (+0.000ms): emit_log_char (printk)
 0.100ms (+0.000ms): emit_log_char (printk)
 0.101ms (+0.000ms): emit_log_char (printk)
 0.101ms (+0.000ms): preempt_schedule (printk)
 0.101ms (+0.000ms): release_console_sem (printk)
 0.102ms (+0.000ms): preempt_schedule (release_console_sem)
 0.102ms (+0.000ms): call_console_drivers (release_console_sem)
 0.103ms (+0.000ms): _call_console_drivers (call_console_drivers)
 0.103ms (+0.000ms): __call_console_drivers (call_console_drivers)
 0.105ms (+0.001ms): vt_console_print (__call_console_drivers)
 0.106ms (+0.001ms): vc_cons_allocated (vt_console_print)
 0.108ms (+0.001ms): preempt_schedule (release_console_sem)
 0.108ms (+0.000ms): __print_symbol (print_context_stack)
 0.109ms (+0.001ms): kallsyms_lookup (__print_symbol)
 0.491ms (+0.381ms): sprintf (__print_symbol)
 0.492ms (+0.000ms): vsprintf (sprintf)
 0.492ms (+0.000ms): vsnprintf (vsprintf)
 0.494ms (+0.001ms): number (vsnprintf)
 0.496ms (+0.001ms): number (vsnprintf)
 0.497ms (+0.001ms): printk (__print_symbol)
 0.497ms (+0.000ms): vscnprintf (printk)
 0.497ms (+0.000ms): vsnprintf (vscnprintf)
 0.499ms (+0.001ms): emit_log_char (printk)
 0.499ms (+0.000ms): emit_log_char (printk)

 0.778ms (+0.000ms): emit_log_char (printk)
 0.779ms (+0.000ms): emit_log_char (printk)
 0.779ms (+0.000ms): preempt_schedule (printk)
 0.779ms (+0.000ms): release_console_sem (printk)
 0.780ms (+0.000ms): preempt_schedule (release_console_sem)
 0.780ms (+0.000ms): call_console_drivers (release_console_sem)
 0.781ms (+0.000ms): _call_console_drivers (call_console_drivers)
 0.781ms (+0.000ms): __call_console_drivers (call_console_drivers)
 0.781ms (+0.000ms): vt_console_print (__call_console_drivers)
 0.782ms (+0.000ms): vc_cons_allocated (vt_console_print)
 0.782ms (+0.000ms): preempt_schedule (release_console_sem)
 0.782ms (+0.000ms): __print_symbol (print_context_stack)
 0.783ms (+0.000ms): kallsyms_lookup (__print_symbol)
 1.448ms (+0.665ms): sprintf (__print_symbol)
 1.448ms (+0.000ms): vsprintf (sprintf)
 1.448ms (+0.000ms): vsnprintf (vsprintf)
 1.450ms (+0.001ms): number (vsnprintf)
 1.452ms (+0.001ms): number (vsnprintf)
 1.453ms (+0.000ms): printk (__print_symbol)
 1.453ms (+0.000ms): vscnprintf (printk)
 1.453ms (+0.000ms): vsnprintf (vscnprintf)
 1.455ms (+0.001ms): emit_log_char (printk)
 1.456ms (+0.000ms): emit_log_char (printk)

Lee



