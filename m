Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVBSFEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVBSFEE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 00:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVBSFEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 00:04:04 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:17125 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261616AbVBSFEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 00:04:00 -0500
To: Vicente Feito <vicente.feito@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: workqueue - process context
X-Message-Flag: Warning: May contain useful information
References: <200502190148.11334.vicente.feito@gmail.com>
	<52is4ptae0.fsf@topspin.com>
	<200502190202.08782.vicente.feito@gmail.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 18 Feb 2005 21:03:58 -0800
In-Reply-To: <200502190202.08782.vicente.feito@gmail.com> (Vicente Feito's
 message of "Sat, 19 Feb 2005 02:02:08 +0000")
Message-ID: <52ekfdta2p.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 19 Feb 2005 05:03:59.0292 (UTC) FILETIME=[6BD757C0:01C51640]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Vicente> What if I need the module to be unloaded cause It's
    Vicente> mutually exclusive with another module to be loaded, and
    Vicente> I still need to run the works in a workqueue time before
    Vicente> that happens? That's completely out of the picture?cause
    Vicente> that might be useful.

That doesn't sound like a good idea.  For one thing, how does the
second module get the workqueue pointer from the first module?  The
simplest solution would be for each module to create and destroy its
own workqueue.  However, if you really need a shared workqueue for
some reason, then have a simple third module that can remain loaded
and have it manage the workqueue for both of your other modules.

    Roland> By the way, the module (or any code calling
    Roland> destroy_workqueue()) must make sure that it has race
    Roland> conditions that might result in work being submitted to
    Roland> the queue while it is being destroyed.

    Vicente> yes, I think flushing is enough, is it?

Usually, but you have to be extra-careful if you have any work
functions that might resubmit themselves.

 - Roland

