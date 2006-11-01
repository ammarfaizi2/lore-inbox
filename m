Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423785AbWKADFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423785AbWKADFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 22:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423846AbWKADFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 22:05:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:27230 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1423785AbWKADFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 22:05:48 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,377,1157353200"; 
   d="scan'208"; a="153951571:sNHT24418996"
Date: Tue, 31 Oct 2006 18:44:11 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, Andi Kleen <ak@suse.de>,
       Lee Revell <rlrevell@joe-job.com>, Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, len.brown@intel.com
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061031184411.E3790@unix-os.sc.intel.com>
References: <1161969308.27225.120.camel@mindpipe> <1162009373.26022.22.camel@localhost.localdomain> <1162177848.2914.13.camel@localhost.portugal> <200610301623.14535.ak@suse.de> <1162253008.2999.9.camel@localhost.portugal> <20061030184155.A3790@unix-os.sc.intel.com> <1162345608.2961.7.camel@localhost.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1162345608.2961.7.camel@localhost.portugal>; from sergio@sergiomb.no-ip.org on Wed, Nov 01, 2006 at 01:46:48AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 01:46:48AM +0000, Sergio Monteiro Basto wrote:
> On Mon, 2006-10-30 at 18:41 -0800, Siddha, Suresh B wrote:
> > On Tue, Oct 31, 2006 at 12:03:28AM +0000, Sergio Monteiro Basto wrote:
> > > time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
> > > time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
> > > time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
> > > time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
> > 
> > Is this the reason why you are saying your system has unsynchronized TSC?
> > Some where in this thread, you mentioned that Lost ticks happen even
> > when you use  "notsc"
> > 
> > This sounds to me as a different problem. Can you send us the output
> > of /proc/interrupts?
> 
> /proc/interrupts on kernel 2.6.18
> http://bugzilla.kernel.org/attachment.cgi?id=9384&action=view
> dmesg w/o notsc kernel 2.6.19-rc4
> http://bugzilla.kernel.org/attachment.cgi?id=9385&action=view
> /proc/interrupts kernel 2.6.19-rc4 
> http://bugzilla.kernel.org/attachment.cgi?id=9386&action=view
> dmesg w/ notsc kernel 2.6.19-rc4 
> http://bugzilla.kernel.org/attachment.cgi?id=9387&action=view
> /proc/interrupts kernel 2.6.19-rc4
> http://bugzilla.kernel.org/attachment.cgi?id=9388&action=view
> list of interrupts give by windows XP
> http://bugzilla.kernel.org/attachment.cgi?id=9389&action=view

First of all, from "lost timer ticks" messages and the fact that "notsc"
decreases the number of ticks lost can't be concluded as a TSC sync issue.

Some device is hogging interrupts which results in lost timer ticks and from
your 2.6.18 interrupts info, usb seems to be the culprit.. It is probably
a side effect that "notsc" decreases the lost timer ticks..

copied Len who seems to be the owner of the bug for his thoughts..
(http://bugzilla.kernel.org/show_bug.cgi?id=6419) 

thanks,
suresh
