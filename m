Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUG1TqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUG1TqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 15:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUG1Tpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 15:45:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:23017 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263040AbUG1Tpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 15:45:36 -0400
Date: Wed, 28 Jul 2004 12:44:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: ebiederm@xmission.com, kaos@sgi.com, linux-kernel@vger.kernel.org,
       suparna@in.ibm.com, mbligh@aracnet.com, fastboot@osdl.org
Subject: Re: Announce: dumpfs v0.01 - common RAS output API
Message-Id: <20040728124405.1a934bec.akpm@osdl.org>
In-Reply-To: <200407281106.17626.jbarnes@engr.sgi.com>
References: <16734.1090513167@ocs3.ocs.com.au>
	<200407280903.37860.jbarnes@engr.sgi.com>
	<m1bri06mgw.fsf@ebiederm.dsl.xmission.com>
	<200407281106.17626.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>
> On Wednesday, July 28, 2004 11:00 am, Eric W. Biederman wrote:
> > > I think this could end up being a good thing.  It gives more people a
> > > stake in making sure that driver shutdown() routines work well.
> >
> > Which actually is one of the items open for discussion currently.
> > For kexec on panic do we want to run the shutdown() routines?
> 
> We'll have to do something about incoming dma traffic and other stuff that the 
> devices might be doing.  Maybe a arch specific callout to do some chipset 
> stuff?
> 

Does ongoing DMA actually matter?  After all,the memory which is being
dma-ed into is pre-reserved and allocated for that purpose, and the dump
kernel won't be using it.

It would be polite to pause for a number of seconds to allow things to go
quiet, but apart from that I think all we need to ensure is that the
drivers in the dump kernel firmly whack the hardware before reinitialising
it?

