Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTLNXQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 18:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTLNXQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 18:16:29 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:18305
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262762AbTLNXQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 18:16:28 -0500
Date: Sun, 14 Dec 2003 18:15:36 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Peter Breitenlohner <peb@mppmu.mpg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.23 dual Xeon detection problem + patch (fwd)
In-Reply-To: <Pine.LNX.4.58.0312141309280.1027@pcl321.mppmu.mpg.de>
Message-ID: <Pine.LNX.4.58.0312141814550.23752@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0312141309280.1027@pcl321.mppmu.mpg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Dec 2003, Peter Breitenlohner wrote:

> Hi,
>
> originally I sent this to the maintainer (Ingo Molnar), but since I didn't
> get any response for about two weeks I am now sending this to the
> developer's list (with the patch -- originally as attachement -- now
> inlined).
> -------------------- start of patch ------------------
> --- linux-2.4.23/include/asm-i386/smpboot.h.orig	2003-08-25 13:44:43.000000000 +0200
> +++ linux-2.4.23/include/asm-i386/smpboot.h	2003-12-02 16:49:46.000000000 +0100
> @@ -73,11 +73,9 @@
>   */
>  static inline int cpu_present_to_apicid(int mps_cpu)
>  {
> -	if (clustered_apic_mode == CLUSTERED_APIC_XAPIC)
> -		return raw_phys_apicid[mps_cpu];
>  	if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
>  		return (mps_cpu/4)*16 + (1<<(mps_cpu%4));
> -	return mps_cpu;
> +	return raw_phys_apicid[mps_cpu];
>  }

What was NR_CPUS in your kernel config?

