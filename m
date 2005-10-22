Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVJVXJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVJVXJE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 19:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVJVXJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 19:09:03 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:37007 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751274AbVJVXJC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 19:09:02 -0400
Date: Sat, 22 Oct 2005 16:09:43 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       dipankar@in.ibm.com, vatsa@in.ibm.com, rusty@au1.ibm.com, mingo@elte.hu,
       manfred@colorfullife.com
Subject: Re: [PATCH] RCU torture testing
Message-ID: <20051022230943.GA5846@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051001182056.GA1613@us.ibm.com> <20051002210549.GA8503@elf.ucw.cz> <20051003143009.GB1300@us.ibm.com> <1128350188.17024.14.camel@laptopd505.fenrus.org> <20051003152602.GD1300@us.ibm.com> <1128353520.17024.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128353520.17024.19.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 05:31:59PM +0200, Arjan van de Ven wrote:
> 
> > Good point -- all I really need for module parameters is the number
> > of readers.  I should be able to have module load start the test and
> > module unload stop it (any problems with this approach?). 
> 
> only one potential gotcha; it means you can't load the system to the
> extend that the shell doesn't get cpu time otherwise the admin can never
> issue the unload. Maybe a time limit on the testing? (optional as module
> parm for all I care)

OK...  I tried both debugfs and modules, and the modules approach turned
out to be much more tester-friendly.  With debugfs, one must do a special
build of the kernel to enable debugfs -- which will also include other
test code that might skew results -- and the fact that debugfs does not
yet seem to have a standard mount point makes scripting less effective.

In contrast, the modules approach can be used even on an already running
kernel that you did not plan to test ahead of time.

So modules it is.  Patch submitted separately.

							Thanx, Paul
