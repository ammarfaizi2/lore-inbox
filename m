Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272746AbTHEMnc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272745AbTHEMn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:43:26 -0400
Received: from pwmail.portoweb.com.br ([200.248.222.108]:46230 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S272743AbTHEMnA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:43:00 -0400
Date: Tue, 5 Aug 2003 09:46:12 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: Willy Tarreau <willy@w.ods.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre10
In-Reply-To: <20030801224753.GA912@alpha.home.local>
Message-ID: <Pine.LNX.4.44.0308050944370.20487-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2 Aug 2003, Willy Tarreau wrote:

> On Fri, Aug 01, 2003 at 01:19:11PM -0300, Marcelo Tosatti wrote:
> > 
> > Hello,
> > 
> > Here goes -pre10, hopefully the last -pre of 2.4.22. 
> > 
> > It contains a bunch of important fixes, detailed below.
> > 
> > Please help testing.
> 
> Hi Marcelo,
> 
> First, one word : Congratulations !
> 
> This is the _first_ vanilla 2.4 kernel which I can run _unpatched_ on my
> customer's firewalls. This one was stressed all the day at 4000 hits/s.
> Subsystems and drivers include aic7xxx, cpqarray, bonding, tulip, eepro100,
> sunhme, PIII / PPro SMP, netfilter. Everything looks fine and smooth even at a
> sustained write rate of 900 kB/s (logs). I only loose and corrupt significant
> number of firewall logs above 3000 lines/s if I don't extend the log buffer
> size. I've been using the fairly simple attached patch for a few months now
> with success (no loss up to 5600 lines/s). I believe Randy Dunlap has already
> got nearly the same one included in 2.5/2.6, so may want to include it too
> since it's not really intrusive, although my customer can survive with one
> patch :-)
> 
> Second, I'm writing this mail from my alpha :
> 
> bash-2.03$ uname -a
> Linux alpha 2.4.22-pre10 #1 Fri Aug 1 23:20:31 CEST 2003 alpha unknown
> 
> It compiled without a glitch and I've got no error in the logs yet. The
> previous stable version on this machine was 2.4.21-rc3 + aic7xxx from Justin.
> For the record, this one is an NFS server on reiserfs on soft raid5 on aic7xxx.
> 
> Third, my VAIO likes it a lot since I can now power it off without holding the
> button during 4 seconds !
> 
> So for me, it looks like the cleanest 2.4 to date. I will only tell you in 450
> days if it's as much reliable as have been my old ones for the last 450 days of
> interrupted service :-)
> 
> I hope we'll get other positive records so that we can quickly get 2.4.22.

Great! 

Its good to see everyone who contributed to latter 2.4 having their work
recognized.



> Thanks to you and all others in $ChangeLog for this good version ! Willy
>  ============ patch : make LOG_BUF_LEN configurable at config time
> ============
> 
> diff -urN wt10-pre3/Documentation/Configure.help wt10-pre3-log-buf-len/Documentation/Configure.help
> --- wt10-pre3/Documentation/Configure.help	Wed Mar 19 09:58:25 2003
> +++ wt10-pre3-log-buf-len/Documentation/Configure.help	Tue Mar 25 08:20:35 2003
> @@ -25231,6 +25231,19 @@
>    output to the second serial port on these devices.  Saying N will
>    cause the debug messages to appear on the first serial port.
>  
> +Kernel log buffer length shift
> +CONFIG_LOG_BUF_SHIFT
> +  The kernel log buffer has a fixed size of :
> +      64 kB (2^16) on MULTIQUAD and IA64,
> +     128 kB (2^17) on S390
> +      32 kB (2^15) on SMP systems
> +      16 kB (2^14) on UP systems
> +
> +  You have the ability to change this size with this parameter which
> +  fixes the bit shift used to get the buffer length (which must be a
> +  power of 2). Eg: a value of 16 sets the buffer to 64 kB (2^16).
> +  The default value of 0 uses standard values above.

I dont see a problem with this patch and it is useful. 

Please resubmit it at 2.4.23-pre time, okey? 

Thanks for your patches and testing. They are very welcome.

