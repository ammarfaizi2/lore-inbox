Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWJBObp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWJBObp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 10:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWJBObp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 10:31:45 -0400
Received: from tomts20.bellnexxia.net ([209.226.175.74]:12950 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932461AbWJBObo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 10:31:44 -0400
Date: Mon, 2 Oct 2006 10:31:38 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Karim Yaghmour <karim@opersys.com>, Pavel Machek <pavel@suse.cz>,
       Joe Perches <joe@perches.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: [UPDATE] Performance analysis of Linux Kernel Markers 0.20 for 2.6.17
Message-ID: <20061002143138.GA19717@Krystal>
References: <20060930180157.GA25761@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060930180157.GA25761@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 10:27:55 up 40 days, 11:36,  5 users,  load average: 0.22, 0.30, 0.35
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two minor corrections of my results :

* Mathieu Desnoyers (compudj@krystal.dyndns.org) wrote:
[...]
> * Micro-benchmarks
[...]
> The following tests are done with the "optimized" markers only
>
[...]
> - Execute a loop with a marker enabled, with an empty probe. Var args argument
>   setup, probe empty. No preemption disabling.
> NR_LOOPS : 100000
> time delta (cycles): 3363450
> cycles per loop : 33.63
- cycles per loop to disable preemption : 44.08-33.63=10.45
+ cycles per loop to disable preemption : 52.11-33.63=18.48
[...]
> * Size (x86)
> 
> This is the size added by each marker to the memory image :
> 
> - Optimized
> 
> .text section : instructions
> Adds 6 bytes in the "likely" path.
> Adds 32 bytes in the "unlikely" path.
> .data section : r/w data
> 0 byte
+ 4 bytes for the call address
> .rodata.str1 : strings
> Length of the marker name
> .debug_str : strings (if loaded..)
> Length of the marker name + 7 bytes (__mark_)
> .markers
> 8 bytes (2 pointers)
> .markers.c
> 12 bytes (3 pointers)
> 
> - Generic
> 
> .text section : instructions
> Adds 11 bytes in the "likely" path.
> Adds 32 bytes in the "unlikely" path.
> .data section : r/w data
> 1 byte (the activation flag)
+ 4 bytes for the call address
> .rodata.str1 : strings
> Length of the marker name
> .debug_str : strings (if loaded..)
> Length of the marker name + 7 bytes (__mark_)
> .markers
> 8 bytes (2 pointers)
> .markers.c
> 12 bytes (3 pointers)
> 


Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
