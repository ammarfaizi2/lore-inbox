Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbVJLSUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbVJLSUE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 14:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbVJLSUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 14:20:04 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:27621 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751488AbVJLSUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 14:20:02 -0400
Subject: Re: ide_wait_not_busy oops still with 2.6.14-rc3 (Re: 1GHz pbook
	15", linux 2.6.14-rc2 oops on resume)
From: Lee Revell <rlrevell@joe-job.com>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1128948118.23434.13.camel@localhost>
References: <1128323544.4602.5.camel@localhost>
	 <pan.2005.10.06.19.19.22.673915@nn7.de>  <1128720351.17365.48.camel@gaston>
	 <1128948118.23434.13.camel@localhost>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 14:17:29 -0400
Message-Id: <1129141049.10599.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-10 at 14:41 +0200, Soeren Sonnenburg wrote:
> On Sat, 2005-10-08 at 07:25 +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2005-10-06 at 21:19 +0200, Soeren Sonnenburg wrote:
> > > On Mon, 03 Oct 2005 07:12:24 +0000, Soeren Sonnenburg wrote:
> > > 
> > > > Hi all,
> > > > 
> > > > when a dvd featuring some iso content is in the dvd-drive and the
> > > > machine is put to sleep mode, it will give the following oops on resume.
> > > > It is working without problems if no media is in the drive.
> > > > Voluntary preemption is ON.
> > > > Find below the dmesg output when a dvd is in the drive.
> > > 
> > > now it is:
> [incomplet oops]
> 
> ok, here is the complete one:
> 
> BUG: soft lockup detected on CPU#0!

This isn't an Oops.  What the soft lockup detector is telling you is
that one CPU detected that another CPU was running something in the
kernel for a LONG time without rescheduling which is considered a bug.
The fix is to make ide_wait_not_busy() preemptible.

Lee

