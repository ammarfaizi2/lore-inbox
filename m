Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWATVsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWATVsL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWATVsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:48:11 -0500
Received: from mail.host.bg ([85.196.174.5]:8160 "EHLO mail.host.bg")
	by vger.kernel.org with ESMTP id S1751171AbWATVsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:48:09 -0500
Subject: Re: OOM Killer killing whole system
From: Anton Titov <a.titov@host.bg>
To: Chase Venters <chase.venters@clientec.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0601201401500.14198@turbotaz.ourhouse>
References: <1137337516.11767.50.camel@localhost>
	 <20060120041114.7f06ecd8.akpm@osdl.org>
	 <Pine.LNX.4.64.0601201401500.14198@turbotaz.ourhouse>
Content-Type: multipart/mixed; boundary="=-Ro/H1xwdEd8haIebtIfK"
Organization: Host.bg
Date: Fri, 20 Jan 2006 23:48:05 +0200
Message-Id: <1137793685.11771.58.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ro/H1xwdEd8haIebtIfK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-01-20 at 14:04 -0600, Chase Venters wrote:
> On Fri, 20 Jan 2006, Andrew Morton wrote:
> >> Jan 15 06:05:09 vip 216477 pages slab
> >
> > It's all in slab.  800MB.
> >
> > I'd be suspecting a slab memory leak.  If it happens again, please take a
> > copy of /proc/slabinfo, send it.
> >
> 
> Andrew & Anton,
>  The culprit was 1.5 million SCSI commands in the scsi command cache. 
> 
> Thanks,
> Chase

I currently have this:
scsi_cmd_cache    1458778 1458790    384   10    1 : tunables   54 27
8 : slabdata 145879 145879      0

in /proc/slabinfo, which is pretty close to 1.5 million. The system is
working fine but it should be not very loaded anyway, so a mem leakage
will not show up early. Just checked, that scsi_cmd_cache on other
machines of mine is under 100, so it seems like a problem.

Unfortunately, while being a programmer, I'm totally unaware
what /proc/slabinfo means, but I'm perfectly willing to provide a shell
(in case of Andrew or other famous developer it may be even root) on
this machine.

I'm attaching the /proc/slabinfo

Thanks for help,
Anton



--=-Ro/H1xwdEd8haIebtIfK
Content-Disposition: attachment; filename=slab.gz
Content-Type: application/x-gzip; name=slab.gz
Content-Transfer-Encoding: base64

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


--=-Ro/H1xwdEd8haIebtIfK--

