Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967327AbWKZH0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967327AbWKZH0F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 02:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967329AbWKZH0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 02:26:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63950 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S967327AbWKZH0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 02:26:02 -0500
Date: Sun, 26 Nov 2006 02:25:38 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>, Larry Woodman <lwoodman@redhat.com>
Subject: Re: OOM killer firing on 2.6.18 and later during LTP runs
Message-ID: <20061126072538.GA5223@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andy Whitcroft <apw@shadowen.org>,
	Larry Woodman <lwoodman@redhat.com>
References: <4568AFB1.3050500@mbligh.org> <20061125132828.16a01762.akpm@osdl.org> <20061126030045.GA29656@redhat.com> <20061125231153.5cbd4581.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061125231153.5cbd4581.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 11:11:53PM -0800, Andrew Morton wrote:
 > On Sat, 25 Nov 2006 22:00:45 -0500
 > Dave Jones <davej@redhat.com> wrote:
 > 
 > > On Sat, Nov 25, 2006 at 01:28:28PM -0800, Andrew Morton wrote:
 > >  > On Sat, 25 Nov 2006 13:03:45 -0800
 > >  > "Martin J. Bligh" <mbligh@mbligh.org> wrote:
 > >  > 
 > >  > > On 2.6.18-rc7 and later during LTP:
 > >  > > http://test.kernel.org/abat/48393/debug/console.log
 > >  > 
 > >  > The traces are a bit confusing, but I don't actually see anything wrong
 > >  > there.  The machine has used up all swap, has used up all memory and has
 > >  > correctly gone and killed things.  After that, there's free memory again.
 > > 
 > > We covered this a month or two back.  For RHEL5, we've ended up
 > > reintroducing the oom killer prevention logic that we had up until
 > > circa 2.6.10.   It seemed that there exist circumstances where
 > > given a little more time, some memory hogging apps will run to completion
 > > allowing other allocators to succeed instead of being killed.
 > 
 > I _think_ what you're describing here is a false-positive oom-killing?  But
 > Martin appears to be hitting a genuine oom.
 
what we saw during the rhel5 testing was that yes, the machine _was_ OOM
*temporarily*, but if instead of killing the task trying to allocate, we
postponed the killing a few times, it would give other tasks the opportunity
to complete writeout, or free up memory some other way, allowing the
allocating process to succeed shortly afterwards.

 > But it does appear that some changes are needed, because lots of things got
 > oom-killed.
 >
 > I think.  Maybe not - there's no timestamping in those logs and it is of
 > course possible that we're seeing unrelated ooms which happened a long time
 > apart.

Maybe, but it does sound spookily familiar.
The last time Larry's patch got floated to lkml it was met with
"Ah!, but we have new oom killer changes in -git which might solve this".
We tried them. They didn't.

		Dave

-- 
http://www.codemonkey.org.uk
