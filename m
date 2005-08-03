Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVHCLvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVHCLvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVHCLtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:49:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:23982 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262236AbVHCLrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:47:18 -0400
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <m1ack0xuzq.fsf@ebiederm.dsl.xmission.com>
References: <1122908972.18835.153.camel@gaston>
	 <20050802095312.GA1442@elf.ucw.cz>
	 <m1ack0xuzq.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 13:43:07 +0200
Message-Id: <1123069387.30257.33.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 08:40 -0600, Eric W. Biederman wrote:
> Pavel Machek <pavel@ucw.cz> writes:
> 
> > Hi!
> >
> >> Why are we calling driver suspend routines in these ? This is _not_
> >
> > Well, reason is that if you remove device_suspend() you'll get
> > emergency hard disk park during powerdown. As harddrives can survive
> > only limited number of emergency stops, that is not a good idea.
> 
> Then the practical question is: do we suspend the disk by
> calling device_suspend() for every device.  Or do we modify
> the ->shutdown() method for the disk.

afaik, IDE used to have a shutdown callback or a shutdown notifier
already anyway. If that was lost, then this is a different problem. If
SATA and/or SCSI aren't doing it, then they need fixing, but suspend()
isn't the solution.

Ben.


