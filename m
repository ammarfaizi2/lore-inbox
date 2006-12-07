Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163705AbWLGXOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163705AbWLGXOe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163724AbWLGXOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:14:34 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52466 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1163705AbWLGXOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 18:14:33 -0500
Date: Thu, 7 Dec 2006 23:22:07 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Chris Friesen" <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: additional oom-killer tuneable worth submitting?
Message-ID: <20061207232207.01af3a79@localhost.localdomain>
In-Reply-To: <45785DDD.3000503@nortel.com>
References: <45785DDD.3000503@nortel.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We add a new "oom_thresh" member to the task struct.
> We introduce a new proc entry "/proc/<pid>/oomthresh" to control it.
> 
> The "oom-thresh" value maps to the max expected memory consumption for 
> that process.  As long as a process uses less memory than the specified 
> threshold, then it is immune to the oom-killer.

You've just introduced a deadlock. What happens if nobody is over that
predicted memory and the kernel uses more resource ?
> 
> On an embedded platform this allows the designer to engineer the system 
> and protect critical apps based on their expected memory consumption. 
> If one of those apps goes crazy and starts chewing additional memory 
> then it becomes vulnerable to the oom killer while the other apps remain 
> protected.

That is why we have no-overcommit support. Now there is an argument for
a meaningful rlimit-as to go with it, and together I think they do what
you really need.

Alan
