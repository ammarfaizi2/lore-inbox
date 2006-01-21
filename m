Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWAUD3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWAUD3r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 22:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWAUD3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 22:29:47 -0500
Received: from mail.host.bg ([85.196.174.5]:55476 "EHLO mail.host.bg")
	by vger.kernel.org with ESMTP id S1750831AbWAUD3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 22:29:46 -0500
Subject: Re: OOM Killer killing whole system
From: Anton Titov <a.titov@host.bg>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, Chase Venters <chase.venters@clientec.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <1137806248.4122.11.camel@mulgrave>
References: <1137337516.11767.50.camel@localhost>
	 <1137793685.11771.58.camel@localhost>
	 <20060120145006.0a773262.akpm@osdl.org>
	 <200601201819.58366.chase.venters@clientec.com>
	 <20060120165031.7773d9c4.akpm@osdl.org> <1137806248.4122.11.camel@mulgrave>
Content-Type: text/plain
Organization: Host.bg
Date: Sat, 21 Jan 2006 05:29:41 +0200
Message-Id: <1137814181.11771.70.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 19:17 -0600, James Bottomley wrote:
> On Fri, 2006-01-20 at 16:50 -0800, Andrew Morton wrote:
> > For linux-scsi reference, Chase's /proc/slabinfo says:
> > 
> > scsi_cmd_cache    1547440 1547440    384   10    1 : tunables   54   27    8 : 
> > slabdata 154744 154744      0
> 
> There's another curiosity about this: the linux command stack is pretty
> well counted per scsi device (it's how we control queue depth), so if a
> driver leaks commands we see it not by this type of behaviour, but by
> the system hanging (waiting for all the commands the mid-layer thinks
> are outstanding to return).  So, the only way we could leak commands
> like this is in the mid-layer command return logic ... and I can't find
> anywhere this might happen.
> 

Just to mention, that 2.6.14.2 does not have this problem:

vip ~ # cat /proc/slabinfo | grep scsi
scsi_cmd_cache        60     60    384   10    1 : tunables   54   27
8 : slabdata      6      6     27

but my guess is that the problem may be not in SCSI, as not /and
previosly actually/ I have this:

vip ~ # cat /proc/slabinfo | grep reiser
reiser_inode_cache 556594 556614    408    9    1 : tunables   54   27
8 : slabdata  61846  61846      0

which seems too high too

