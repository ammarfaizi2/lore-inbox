Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751942AbWISTIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbWISTIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbWISTIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:08:53 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:49299 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751942AbWISTIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:08:52 -0400
Date: Tue, 19 Sep 2006 14:09:00 +0530
From: "S. P. Prasanna" <prasanna@in.ibm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, Tom Zanussi <zanussi@us.ibm.com>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       systemtap@sources.redhat.com, ltt-dev@shafik.org
Subject: Re: [PATCH] Linux Kernel Markers 0.2 for Linux 2.6.17
Message-ID: <20060919083900.GE23836@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060919183447.GA16095@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060919183447.GA16095@Krystal>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 02:34:47PM -0400, Mathieu Desnoyers wrote:
[....]
> --- /dev/null
> +++ b/kernel/Kconfig.marker
> @@ -0,0 +1,75 @@
> +# Code markers configuration
> +
> +menu "Marker configuration"
> +
> +
> +config MARK
> +	bool "Enable MARK code markers"
> +	default y
> +	help
> +	  Activate markers that can call printk or can be instrumented
> +	  dynamically.
> +
> +choice
> +	prompt "MARK code marker behavior"
> +	default MARK_KPROBE
> +	depends on MARK
> +	help
> +	  Configuration of markers that can call printk or can be
> +	  instrumented dynamically.
> +
> +config MARK_KPROBE
> +	bool "KPROBE"
> +	---help---
> +	Change markers for a symbol "__mark_modulename_event".
> +config MARK_JPROBE
> +	bool "JPROBE"
> +	---help---
> +	Change markers for a symbol "__mark_modulename_event"
> +	and create a target for a high speed dynamic probe.
> +config MARK_FPROBE
> +	bool "FPROBE"
> +	---help---
> +	Change markers for a function call.
> +config MARK_PRINT
> +	bool "PRINT"
> +	---help---
> +	Call printk from the marker.
> +endchoice
> +
> +config MARK_NOPRINT
> +	bool "Enable MARK_NOPRINT code markers"
> +	default y
> +	help
> +	  Activate markers that cannot call printk.
> + 
> +choice
> +	prompt "MARK_NOPRINT code marker behavior"
> +	default MARK_NOPRINT_KPROBE
> +	depends on MARK_NOPRINT
> +	help
> +	  Configuration of markers that cannot call printk.
> +
> +config MARK_NOPRINT_KPROBE
> +	bool "KPROBE"
> +	---help---
> +	Change markers for a symbol "__mark_modulename_event".
> +config MARK_NOPRINT_JPROBE
> +	bool "JPROBE"
> +	---help---
> +	Change markers for a symbol "__mark_modulename_event"
> +	and create a target for a high speed dynamic probe.
> +config MARK_NOPRINT_FPROBE
> +	bool "FPROBE"
> +	---help---
> +	Change markers for a function call.
> +endchoice
> +
> +config MARK_STATIC
> +	bool "Enable MARK_STATIC code markers"
> +	default n
> +	help
> +	  Activate markers that cannot be instrumented dynamically. They will
> +	  generate function calls to each function-style probe.
> +
> +endmenu

I think having so many config options is not a good idea, you can group them
and reduce the number of config options.

Thanks
Prasanna

-- 
Prasanna S.P.
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
