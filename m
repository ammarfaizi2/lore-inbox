Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTEUH7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbTEUH66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:58:58 -0400
Received: from CPE-203-45-136-67.qld.bigpond.net.au ([203.45.136.67]:60170
	"EHLO oxcoda.safenetbox.biz") by vger.kernel.org with ESMTP
	id S261328AbTEUH4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:56:24 -0400
Date: Wed, 21 May 2003 18:09:17 +1000
From: Menno Smits <menno@netbox.biz>
To: Frank Cusack <fcusack@fcusack.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic with pptpd when mss > mtu
Message-Id: <20030521180917.6f524e6f.menno@netbox.biz>
In-Reply-To: <20030520214301.A3632@google.com>
References: <20030521091442.1bfb41b6.menno@netbox.biz>
	<20030520214301.A3632@google.com>
Organization: NetBox
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SERVER01/Oxcoda/AU(Release 5.0.12  |February 13, 2003) at
 21/05/2003 06:09:17 PM,
	Serialize by Router on SERVER01/Oxcoda/AU(Release 5.0.12  |February 13, 2003) at
 21/05/2003 06:09:18 PM,
	Serialize complete at 21/05/2003 06:09:18 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick and useful reply.

On Tue, 20 May 2003 21:43:01 -0700
Frank Cusack <fcusack@fcusack.com> wrote:

> On Wed, May 21, 2003 at 09:14:42AM +1000, Menno Smits wrote:
> > I'm seeing a kernel oops with 2.4.20 which seems to be related to the
> > PopTop PPTP server. When certain clients connect in (seems to be
> > Win98) and begin large data transfers the kernel will reliably oops.
> > The system crashes hard, the oops doesn't make it to the logs.
> ...
> > I have been able to deal with the issue by using the workaround
> > suggested in the the second post. That is, adding netfilter rules with
> > the TCPMSS target to limit the TCP MSS to PMTU - 40. Apparently the
> > problem is triggered by the MSS being bigger than the MTU (which is
> > 750 in this case).
> 
> Yup.  win98 ignores the negotiated MRU from the PPP peer (MTU on the win98
> side) and sends PPP packets larger than MTU.  As you've discovered. :-)
> 
> Linux doesn't allocate enough space for the decompressor output, and the
> mppe module doesn't properly check that enough space exists.  (That's
> because PPP MPPE packets *shrink* after "decompression", and the mppe
> module assumes at least the same amount of space as the PPP packet is
> allocated for the decompressor.)

That certainly makes sense.

> Grab the latest ftp://ftp.samba.org/pub/unpacked/ppp which corrects both
> of the above problems.

I'll try this and let you know how I go. 

> I'll be posting a patch to lkml to correct the decompressor allocation
> problem, shortly (a few weeks).

Look forward to it.

Regards,
Menno Smits
