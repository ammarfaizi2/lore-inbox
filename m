Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbUKDVFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbUKDVFw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbUKDVE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:04:58 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15275 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262444AbUKDUtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:49:32 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: contention on profile_lock
Date: Thu, 4 Nov 2004 12:49:21 -0800
User-Agent: KMail/1.7
Cc: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org,
       edwardsg@sgi.com, dipankar@in.ibm.com
References: <200411021152.16038.jbarnes@engr.sgi.com> <200411041156.23559.jbarnes@engr.sgi.com> <20041104201257.GA14786@holomorphy.com>
In-Reply-To: <20041104201257.GA14786@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411041249.21718.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 4, 2004 12:12 pm, William Lee Irwin III wrote:
> On Thu, Nov 04, 2004 at 11:56:23AM -0800, Jesse Barnes wrote:
> > ..but since I haven't heard from Dipankar, here's a patch that removes
> > the profile_hook notifier list altogether in favor of a simple flag that
> > controls whether or not to call the oprofile timer routine directly. 
> > Does it look ok?
>
> This looks reasonable to me.

John pointed out that this breaks modules.  Would registering and 
unregistering a function pointer thus be module safe?  Dipankar, hopefully 
you have something better?

static int timer_start(void)
{
 /* Setup the callback pointer */
 oprofile_timer_notify = oprofile_timer;
 return 0;
}


static void timer_stop(void)
{
 /* Tear down the callback pointer after sync_kernel */
 synchronize_kernel();
 oprofile_timer_notify = NULL;
}

Thanks,
Jesse
