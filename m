Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbULBRHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbULBRHN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 12:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbULBRHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 12:07:13 -0500
Received: from mail.joq.us ([67.65.12.105]:6579 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261691AbULBRHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:07:03 -0500
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Andrew Burgess <aab@cichlid.com>, linux-kernel@vger.kernel.org,
       jackit-devel@lists.sourceforge.net
Subject: Re: [Jackit-devel] Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
References: <200412021546.iB2FkK5a005502@cichlid.com>
	<20041202170315.067d7853@mango.fruits.de>
	<87y8ggekds.fsf@sulphur.joq.us>
	<20041202175756.0e50f101@mango.fruits.de>
From: "Jack O'Quin" <joq@io.com>
Date: 02 Dec 2004 11:07:39 -0600
In-Reply-To: <20041202175756.0e50f101@mango.fruits.de>
Message-ID: <87hdn4eihw.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schmidt <mista.tapas@gmx.net> writes:

> I suppose instead of catching the signal the user might just monitor the
> syslog. I'm not sure there's printk's triggered by thisalready , but i'm
> sure if not, ingo might add them. So a trivial patch for jackd would
> probably look like this:
> 
> --- libjack/client.c.orig       2004-12-02 17:55:04.000000000 +0100
> +++ libjack/client.c    2004-12-02 17:56:23.000000000 +0100
> @@ -1238,6 +1238,9 @@
>                         if (control->sync_cb)
>                                 jack_call_sync_client (client);
>  
> +                       // enable atomicity check for RP kernels
> +                       gettimeofday(1,1);
> +
>                         if (control->process) {
>                                 if (control->process (control->nframes,
>                                                       control->process_arg)
> @@ -1247,7 +1250,10 @@
>                         } else {
>                                 control->state = Finished;
>                         }
> -
> +
> +                       // disable atomicity check
> +                       gettimeofday(0,1);
> +
>                         if (control->timebase_cb)
>                                 jack_call_timebase_master (client);
>  

The sync_cb and timebase_cb callbacks actually need to be RT-safe,
too.  ;-)

Is printk() guaranteed not to wait inside the kernel?  I am not
familiar with its internal implementation.
-- 
  joq
