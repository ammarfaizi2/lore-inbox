Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290640AbSBUEvY>; Wed, 20 Feb 2002 23:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292169AbSBUEvP>; Wed, 20 Feb 2002 23:51:15 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:48031 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290640AbSBUEvC>; Wed, 20 Feb 2002 23:51:02 -0500
Date: Wed, 20 Feb 2002 20:49:55 -0800
From: kravetz@us.ibm.com
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
        Paul Jackson <pj@engr.sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
Message-ID: <20020220204955.A1474@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <Pine.LNX.4.21.0202201826120.7476-100000@sx6.ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0202201826120.7476-100000@sx6.ess.nec.de>; from efocht@ess.nec.de on Wed, Feb 20, 2002 at 06:57:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 06:57:05PM +0100, Erich Focht wrote:
> Hi,
> 
> this is another attempt to overcome a limitation of the
> O(1) scheduler: set_cpus_allowed() can only be called for current
> processes.

Great!  I'm glad someone is looking into this.  Didn't look at
your patch too closely, but one obvious issue comes to mind.
How does the caller of set_cpus_allowed() lock down the specified
task so that set_cpus_allowed() can be sure it is still valid?
Obviously, this only becomes an issue when you open up the
routine to tasks other than 'current' as you have done.  Do you
want to do task validation within set_cpus_allowed() with the
tasklist_lock held?

-- 
Mike
