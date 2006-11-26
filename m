Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967325AbWKZHM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967325AbWKZHM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 02:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967324AbWKZHM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 02:12:58 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44253 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S967323AbWKZHM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 02:12:58 -0500
Date: Sat, 25 Nov 2006 23:11:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>, Larry Woodman <lwoodman@redhat.com>
Subject: Re: OOM killer firing on 2.6.18 and later during LTP runs
Message-Id: <20061125231153.5cbd4581.akpm@osdl.org>
In-Reply-To: <20061126030045.GA29656@redhat.com>
References: <4568AFB1.3050500@mbligh.org>
	<20061125132828.16a01762.akpm@osdl.org>
	<20061126030045.GA29656@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006 22:00:45 -0500
Dave Jones <davej@redhat.com> wrote:

> On Sat, Nov 25, 2006 at 01:28:28PM -0800, Andrew Morton wrote:
>  > On Sat, 25 Nov 2006 13:03:45 -0800
>  > "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>  > 
>  > > On 2.6.18-rc7 and later during LTP:
>  > > http://test.kernel.org/abat/48393/debug/console.log
>  > 
>  > The traces are a bit confusing, but I don't actually see anything wrong
>  > there.  The machine has used up all swap, has used up all memory and has
>  > correctly gone and killed things.  After that, there's free memory again.
> 
> We covered this a month or two back.  For RHEL5, we've ended up
> reintroducing the oom killer prevention logic that we had up until
> circa 2.6.10.   It seemed that there exist circumstances where
> given a little more time, some memory hogging apps will run to completion
> allowing other allocators to succeed instead of being killed.

I _think_ what you're describing here is a false-positive oom-killing?  But
Martin appears to be hitting a genuine oom.

But it does appear that some changes are needed, because lots of things got
oom-killed.

I think.  Maybe not - there's no timestamping in those logs and it is of
course possible that we're seeing unrelated ooms which happened a long time
apart.

> For reference, here's the patch that Larry Woodman came up with
> for RHEL5.

gulp.
