Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751691AbWIUWS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbWIUWS5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbWIUWS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:18:57 -0400
Received: from xenotime.net ([66.160.160.81]:45696 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751645AbWIUWSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:18:49 -0400
Date: Thu, 21 Sep 2006 15:19:51 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
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
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Linux Kernel Markers 0.6 for 2.6.17
Message-Id: <20060921151951.d36d2fc4.rdunlap@xenotime.net>
In-Reply-To: <20060921215644.GA27651@Krystal>
References: <20060921215644.GA27651@Krystal>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 17:56:44 -0400 Mathieu Desnoyers wrote:

> Hi Mathieu,

In your next version, please use a space between "if" and "(".

> --- /dev/null
> +++ b/kernel/marker.c
> @@ -0,0 +1,178 @@
> +/* Pointers can be used around preemption disabled */
> +static int marker_get_pointers(const char *name,
> +	struct marker_pointers *ptrs)
> +{
> +	if(!(ptrs->call && ptrs->jmpselect && ptrs->jmpcall
> +			&& ptrs->jmpinline && ptrs->jmpover)) {
> +		return ENOENT;
> +	}
> +}
> +
> +int marker_set_probe(const char *name, marker_probe_func *probe,
> +		enum marker_type type)
> +{
> +	if(result) {
> +		printk(KERN_NOTICE
> +			"Unable to find kallsyms for markers in %s\n",
> +			name);
> +		goto unlock;
> +	}
> +
> +		case MARKER_CALL:
> +			if(*ptrs.call != __mark_empty_function) {
> +				result = EBUSY;
> +				printk(KERN_NOTICE
> +					"Probe already installed on "
> +					"marker in %s\n",
> +					name);
> +				goto unlock;
> +			}
> +		case MARKER_INLINE:
> +			if(*ptrs.jmpover == *ptrs.jmpinline) {
> +				result = ENODEV;
> +				printk(KERN_NOTICE
> +					"No inline probe exists "
> +					"for marker in %s\n",
> +					name);
> +				goto unlock;
> +			}
> +}
> +
> +void marker_disable_probe(const char *name, marker_probe_func *probe,
> +		enum marker_type type)
> +{
> +	if(result)
> +		goto unlock;
> +
> +		case MARKER_CALL:
> +			if(*ptrs.call == probe) {
> +				*ptrs.jmpselect = *ptrs.jmpover;
> +				*ptrs.call = __mark_empty_function;
> +			}
> +		case MARKER_INLINE:
> +			if(*ptrs.jmpselect == *ptrs.jmpinline)
> +				*ptrs.jmpselect = *ptrs.jmpover;
> +			break;
> +	if(!result && type == MARKER_CALL)
> +		synchronize_sched();
> +}
> 

Thanks.
---
~Randy
