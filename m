Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263199AbTCYTRf>; Tue, 25 Mar 2003 14:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263239AbTCYTRf>; Tue, 25 Mar 2003 14:17:35 -0500
Received: from galileo.bork.org ([66.11.174.148]:40453 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id <S263199AbTCYTRe>;
	Tue, 25 Mar 2003 14:17:34 -0500
Date: Tue, 25 Mar 2003 14:28:43 -0500
From: Martin Hicks <mort@bork.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Generic way to control display of debug printk's
Message-ID: <20030325192843.GB11198@bork.org>
References: <20030321223717.GA1241@bork.org> <b5ggva$2lu$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ggva$2lu$1@cesium.transmeta.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Mar 21, 2003 at 06:15:06PM -0800, H. Peter Anvin wrote:
> Followup to:  <20030321223717.GA1241@bork.org>
> By author:    Martin Hicks <mort@wildopensource.com>
> In newsgroup: linux.dev.kernel
> > 
> > It seems to me that a generic way to dynamically control the printing
> > of certain messages to the console during kernel boot is required.
> > Systems that really need this are large SMP systems or NUMA machines
> > with a large number of nodes.  The number of messages that appear 
> > per-node or per-cpu is huge in these machines.
> > 
> 
> See KERN_EMERG, KERN_ALERT, KERN_CRIT, KERN_ERR, KERN_WARNING,
> KERN_NOTICE, KERN_INFO, KERN_DEBUG.

Okay, perhaps I didn't clearly identify the problem last time.  The
problem is the number of messages that go into the log_buf.  On
large systems we can certainly just crank up the size of log_buf, but I
don't see this as a terribly elegant solution.

I think there should be some facility, mirroring the way we can set a
threshold for console messages, to decide if a message is logged at all.
For example, setting console_loglevel and log_loglevel (the new
threshold) to 7 results in no KERN_DEBUG messages begin printed to the
console or the log.

I'm testing a patch now, but are there any comments on the basic idea?
Is it preferrable to just crank up the size of log_buf?

mh

-- 
Martin Hicks  ||  mort@bork.org  || PGP/GnuPG: 0x4C7F2BEE
plato up 2 days, 22:44, 14 users,  load average: 2.64, 0.94, 0.34
Great Spirits have always encountered opposition from mediocre minds
						-Albert Einstein
