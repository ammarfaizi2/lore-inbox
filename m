Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWH2UCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWH2UCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWH2UCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:02:22 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:32236 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751400AbWH2UCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:02:21 -0400
Date: Tue, 29 Aug 2006 13:03:04 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: ego@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       arjan@infradead.org, rusty@rustcorp.com.au, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@intel.linux.com,
       davej@redhat.com, dipankar@in.ibm.com, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 4/4] Rename lock_cpu_hotplug/unlock_cpu_hotplug
Message-ID: <20060829200304.GF1290@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060824103417.GE2395@in.ibm.com> <1156417200.3014.54.camel@laptopd505.fenrus.org> <20060824140342.GI2395@in.ibm.com> <1156429015.3014.68.camel@laptopd505.fenrus.org> <44EDBDDE.7070203@yahoo.com.au> <20060824150026.GA14853@elte.hu> <20060825035328.GA6322@in.ibm.com> <20060827005944.67f51e92.pj@sgi.com> <20060829180511.GA1495@us.ibm.com> <20060829123102.88de61fa.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829123102.88de61fa.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 12:31:02PM -0700, Paul Jackson wrote:
> Paul E. McKenney wrtoe:
> > Can the locusts reasonably take a return value from the acquisition
> > primitive and feed it to the release primitive?
> 
> Yes - the locusts typically do:
> 
>     mutex_lock(&callback_mutex);
>     ... a line or two to read or write cpusets ...
>     mutex_unlock(&callback_mutex);
> 
> The lock and unlock are just a few lines apart.  I could easily pass
> a value from the lock (acquisition) to the unlock (release).
> 
> Why do you ask?

Because passing the value from the acquire to the release could remove
the need to store anything in the task structure, but allow the freedom
of implementation that would be provided by storing things in the task
structure.

Let me throw something together...

							Thanx, Paul
