Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWAQS3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWAQS3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWAQS3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:29:48 -0500
Received: from [81.2.110.250] ([81.2.110.250]:17541 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932149AbWAQS3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:29:47 -0500
Subject: Re: RFC [patch 00/34] PID Virtualization Overview
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Suleiman Souhlal <ssouhlal@FreeBSD.org>, Serge Hallyn <serue@us.ibm.com>,
       linux-kernel@vger.kernel.org, Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <1137521557.5526.18.camel@localhost.localdomain>
References: <20060117143258.150807000@sergelap>
	 <43CD18FF.4070006@FreeBSD.org>
	 <1137517698.8091.29.camel@localhost.localdomain>
	 <43CD32F0.9010506@FreeBSD.org>
	 <1137521557.5526.18.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 18:29:10 +0000
Message-Id: <1137522550.14135.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-17 at 10:12 -0800, Dave Hansen wrote:
> You do assign new pids, at least as far as the kernel is concerned.
> However, any processes that continue to run would get confused if their
> pid changed.  You have to make sure that the tasks have a _consistent_
> view of which process is which pid.

Don't reassign the pid at all. Keep task->container and do the job
explicitly. Most task searches for a pid are abstracted already and most
users of ->pid who try and use it for comparing two tasks for equality
or for keeping a task reference are already terminally racey and want
fixing anyway.

It raises a few other minor questions - one is /proc - but if container
0 was the usual one then putting the other containers into a subdir
would break nothing. Alternatively proc could allow multiple mounts and
a container = option to get the fs view right in chroot trees. The
subdirectories would be nice for management views.

You'd also need some process management items for other contexts - kill
etc but most of that can be done just by having a fork_into_container()
ability.

Alan

