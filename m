Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbVJGO7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbVJGO7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbVJGO7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:59:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:62640 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030301AbVJGO7y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:59:54 -0400
Date: Fri, 7 Oct 2005 09:59:52 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] ppc64: EEH Add event/internal state statistics
Message-ID: <20051007145952.GX29826@austin.ibm.com>
References: <20050930004800.GL29826@austin.ibm.com> <20050930005451.GC6173@austin.ibm.com> <17219.46514.903283.21680@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17219.46514.903283.21680@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 09:14:58PM +1000, Paul Mackerras was heard to remark:
> Linas writes:
> 
> > 03-eeh-statistics.patch
> 
> > +	if (!dn) {
> > +		__get_cpu_var(no_dn)++;
> 
> We have to make sure we are not preemptible when we use
> __get_cpu_var, since it uses smp_processor_id().  It's not clear to me
> that we have ensured that in every case where we use __get_cpu_var.
> Are you sure that we hold a spinlock, or are at interrupt level, or
> have explicitly disabled preemption at every point where we use
> __get_cpu_var?

Tese used to be plain-old global variables, but someone submitted 
a patch that to turn them into the __get_cpu_var() form. I don't 
know why; there's no real performance reason, since these are almost 
never incremented, except a bit during boot.  What if we just change 
them back to global vars?

I've also day-dreamed about moving these stats to somewhere in
in the /sys directory. Any suggestions there?

--linas

