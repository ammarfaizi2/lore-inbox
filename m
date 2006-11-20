Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966646AbWKTWjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966646AbWKTWjz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966637AbWKTWjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:39:55 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:31168 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S966644AbWKTWjy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:39:54 -0500
Subject: Re: [PATCH -mm 0/2] Use freezeable workqueues to avoid
	suspend-related XFS corruptions
From: Nigel Cunningham <nigelc@bur.st>
Reply-To: nigelc@bur.st
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Chinner <dgc@sgi.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <1164061586.15714.1.camel@nigel.suspend2.net>
References: <200611160912.51226.rjw@sisk.pl>
	 <200611202140.47322.rjw@sisk.pl>
	 <1164060206.14889.13.camel@nigel.suspend2.net>
	 <200611202318.29207.rjw@sisk.pl>
	 <1164061586.15714.1.camel@nigel.suspend2.net>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 09:39:50 +1100
Message-Id: <1164062390.15714.5.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry to reply again)

On Tue, 2006-11-21 at 09:26 +1100, Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2006-11-20 at 23:18 +0100, Rafael J. Wysocki wrote:
> > I think I/O can only be submitted from the process context.  Thus if we freeze
> > all (and I mean _all_) threads that are used by filesystems, including worker
> > threads, we should effectively prevent fs-related I/O from being submitted
> > after tasks have been frozen.
> 
> I know that will work. It's what I used to do before the switch to bdev
> freezing. I guess I need to look again at why I made the switch. Perhaps
> it was just because you guys gave freezing kthreads a bad wrap as too
> invasive or something. Bdev freezing is certainly fewer lines of code.

No, it looks like I wrongly believed that XFS was submitting I/O off a
timer, so that freezing kthreads wasn't enough. In that case, it looks
like freezing kthreads should be a good solution.

Regards,

Nigel

