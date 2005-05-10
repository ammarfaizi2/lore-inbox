Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVEJNc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVEJNc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 09:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVEJNc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 09:32:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:164 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261640AbVEJNcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 09:32:51 -0400
Date: Tue, 10 May 2005 15:32:50 +0200
From: Andi Kleen <ak@suse.de>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Bernd Paysan <bernd.paysan@gmx.de>, suse-amd64@suse.com,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [suse-amd64] False "lost ticks" on dual-Opteron system (=> timer twice as fast)
Message-ID: <20050510133250.GK25612@wotan.suse.de>
References: <200505081445.26663.bernd.paysan@gmx.de> <200505091253.21252.bernd.paysan@gmx.de> <200505091517.30555.bernd.paysan@gmx.de> <200505100653.50775.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505100653.50775.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 06:53:49AM -0400, Ed Tomlinson wrote:
> Maybe on UP too:
> 
> May  8 18:50:25 grover kernel: [143640.507170] Attached scsi removable disk sda at scsi5, channel 0, id 0, lun 0
> May  8 18:50:25 grover kernel: [143640.520422] rtc: lost some interrupts at 1024Hz.
> May  8 18:50:25 grover kernel: [143640.554134] Attached scsi generic sg0 at scsi5, channel 0, id 0, lun 0,  type 0
> May  8 18:50:25 grover kernel: [143640.567693] rtc: lost some interrupts at 1024Hz.
> May  8 18:50:25 grover kernel: [143640.596402] usb-storage: device scan complete
> 
> This from 12-rc3-mm3, UP x86_64 with powernow active.  

More likely it is some driver hogging interrupts (turning them off
for too long). You can boot with report_lost_ticks, then the normal
timer interrupt will complain. Note it always triggers at boot a few
times.

When you find the culprit report it to the driver driver maintainer.

> 
> It might be that the message is OK here since I do not see a fast clock.  I mention this
> since powernow is active here.
> 
> Should HPET be available in UP?

HPET is used on HPET only as the backing clock and to run the timer interrupt,
but not for gettimeofday because using the TSC is considerable
faster there. Actually the actual strategy is  bit more complicated,
it also depends on some other things.

-Andi
