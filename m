Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266622AbUF3LgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUF3LgW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 07:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUF3LgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 07:36:22 -0400
Received: from ozlabs.org ([203.10.76.45]:4064 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266622AbUF3LgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 07:36:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16610.39955.554139.858593@cargo.ozlabs.ibm.com>
Date: Wed, 30 Jun 2004 20:55:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] PPC64: log firmware errors during boot.
In-Reply-To: <20040629191046.Q21634@forte.austin.ibm.com>
References: <20040629191046.Q21634@forte.austin.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas,

> Firmware can report errors at any time, and not atypically during boot.
> However, these reports were being discarded until th rtasd comes up,
> which occurs fairly late in the boot cycle.  As a result, firmware
> errors during boot were being silently ignored. 

As far as I can see the main change is in log_rtas_len, which is
called from pSeries_log_error, which is called from do_event_scan and
rtasd(), and do_event_scan is only called from rtasd().  And
get_eventscan_parms() is already called at the beginning of rtasd().
So I don't see the point of the get_eventscan_parms call in
log_rtas_len.  The other change is also in pSeries_log_error.

What am I missing?

> This patch at least gets them printk'ed so that at least they show 
> up in boot.msg/syslog.  There are two other logging mechanisms,
> nvram and rtas, that I didn't touch because I don't understand 
> the reprecussions.  In particular, nvram logging isn't enabled
> until late in the boot ... but what's the point of nvram logging
> if not to catch messages that occured very early in boot ?? 

Indeed.

As for printk'ing the errors, it is annoying and it seems of somewhat
dubious benefit to me, given that it is just incomprehensible hex
numbers that can go on and on.  There has to be a better way.  Putting
it in nvram seems like a better option to me.  I don't know of any
reason why we can't use nvram quite early on.

Paul.
