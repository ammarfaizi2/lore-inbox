Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWIQFi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWIQFi4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 01:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWIQFi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 01:38:56 -0400
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:59780 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751087AbWIQFiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 01:38:55 -0400
Date: Sun, 17 Sep 2006 01:33:42 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060917053342.GB10796@Krystal>
References: <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu> <20060916175606.GA2837@Krystal> <20060916234047.GA26846@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060916234047.GA26846@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 01:21:38 up 25 days,  2:30,  2 users,  load average: 0.09, 0.16, 0.16
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> 
> > > > Third run : same LTTng instrumentation, with a kprobe handler 
> > > > triggered by each event traced.
> > > 
> > > where exactly did you put the kprobe handler?
> > 
> > ltt_relay_reserve_slot.
> > 
> > See http://ltt.polymtl.ca/svn/tests/kernel/test-kprobes.c to insert 
> > the kprobe. Tests done on LTTng 0.5.111, on a x86 3GHz with 
> > hyperthreading.
> 
> ok. In what way did you enable LTTng instrumentation? I have 0.5.108 
> installed, and i'd like to make sure i do everything as you did, to make 
> the tests comparable. Which kernel config options (default ones?), and 
> what precise lttcl commands did you use, were they the usual:
> 
>   lttctl -n trace -d -l /mnt/debugfs/ltt -t /tmp/trace
> 
> ? What filesystem does /tmp/trace reside on?
> 

I used LTTng 0.5.111 (yes, now with debugfs!) ;).

I ran the tests on a Pentium 4 3 GHz, with hyperthreading enabled. The system
has 1GB of ram. Hard disk : WDC WD1600JD-00H. File system : ext3.

The kernel (2.6.17) is configured with SMP enabled.

Relevant kernel config :

CONFIG_LTT=y
CONFIG_LTT_TRACER=m
CONFIG_LTT_RELAY=m
CONFIG_LTT_ALIGNMENT=y
CONFIG_LTT_HEARTBEAT=y
CONFIG_LTT_HEARTBEAT_EVENT=y
# CONFIG_LTT_SYNTHETIC_TSC is not set
CONFIG_LTT_USERSPACE_GENERIC=y
CONFIG_LTT_NETLINK_CONTROL=m
CONFIG_LTT_STATEDUMP=m
CONFIG_LTT_FACILITY_CORE=y
CONFIG_LTT_FACILITY_FS=y
CONFIG_LTT_FACILITY_FS_DATA=y
CONFIG_LTT_FACILITY_IPC=y
CONFIG_LTT_FACILITY_KERNEL=y
CONFIG_LTT_FACILITY_KERNEL_ARCH=y
# CONFIG_LTT_FACILITY_LOCKING is not set
CONFIG_LTT_FACILITY_MEMORY=y
CONFIG_LTT_FACILITY_NETWORK=y
CONFIG_LTT_FACILITY_NETWORK_IP_INTERFACE=y
CONFIG_LTT_FACILITY_PROCESS=y
CONFIG_LTT_FACILITY_SOCKET=y
CONFIG_LTT_FACILITY_STATEDUMP=y
CONFIG_LTT_FACILITY_TIMER=y
CONFIG_LTT_FACILITY_STACK=y
CONFIG_LTT_PROCESS_STACK=y
CONFIG_LTT_PROCESS_MAX_FUNCTION_STACK=100
CONFIG_LTT_PROCESS_MAX_STACK_LEN=250
CONFIG_LTT_KERNEL_STACK=y
CONFIG_LTT_STACK_SYSCALL=y
CONFIG_LTT_STACK_INTERRUPT=y
CONFIG_LTT_STACK_NMI=y

Huge note : I left CONFIG_LTT_FACILITY_STACK enabled, but THIS IS EXPERIMENTAL.

lttctl commands :

Start tracing :
lttctl -n trace -d -l /mnt/debugfs/ltt -t /tmp/trace1
(note : 0.5.111 uses debugfs, 0.5.108 uses relayfs)

Stop tracing :
lttctl -n trace -R

See http://ltt.polymtl.ca > QUICKSTART for other details (modules to load...)


Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
