Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbUJ1Ion@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbUJ1Ion (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 04:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbUJ1Ion
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 04:44:43 -0400
Received: from digitalimplant.org ([64.62.235.95]:39354 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262831AbUJ1Iol
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 04:44:41 -0400
Date: Thu, 28 Oct 2004 01:44:32 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Paul Mackerras <paulus@samba.org>
cc: akpm@osdl.org, "" <mochel@osdl.org>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix deadlocks on dpm_sem
In-Reply-To: <16760.33519.670998.641860@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.50.0410280142130.13935-100000@monsoon.he.net>
References: <16760.33519.670998.641860@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Oct 2004, Paul Mackerras wrote:

> Currently the device_pm_foo() functions are rather prone to deadlocks
> during suspend/resume.  This is because the dpm_sem is held for the
> duration of device_suspend() and device_resume() as well as
> device_pm_add() and device_pm_remove().  If for any reason you get a
> device addition or removal triggered by a device's suspend or resume
> code, you get a deadlock.  (The classic example is a USB host adaptor
> resuming and discovering that the mouse you used to have plugged in
> has gone away.)
>
> This patch fixes the problem by using a separate semaphore, called
> dpm_list_sem, to cover the places where we need the device pm lists to
> be stable, and by being careful about how we traverse the lists on
> suspend and resume.  I have analysed the various cases that can occur
> and I am confident that I have handled them all correctly.  I posted
> this patch together with a detailed analysis 10 days ago.
>
> Andrew, could this go in -mm for testing please?  Pat, any comments?

Sorry for the long delay in responding. I don't have a problem with it,
especially since it fixes a real problem. But, I wonder if there is a
better way to handle devices. The multiple lists themselves seem a little
wonky..

Thanks,


	Pat

