Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTIXOPW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 10:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbTIXOPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 10:15:22 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:262 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261380AbTIXOPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 10:15:19 -0400
Subject: Re: [PATCH] ide-io.c, kernel 2.4.22 Fix for IO stats in
	/proc/partitions, was Re: sard/iostat disk I/O statistics/accounting for
	2.5.8-pre3
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Chad Talbott <ctalbott@google.com>, ".A. Magallon" <jamagallon@able.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20030924092418.A28838@devserv.devel.redhat.com>
References: <20030924092418.A28838@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1064412912.21892.19.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Sep 2003 15:15:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2003-09-24, Chad Talbott wrote:


> Here's the one that I compiled and tested. It makes /proc/partitions
> report correctly.

Looks OK, but I'd defer to an IDE expert on the question of whether this
is the best fix or not.

Basically, you need to pair accounting start points with accounting end
points.  This patch removes the end point from the IDE special-command
postprocessing, but only by manually replacing end_that_request_last()
with a variant which doesn't do accounting.

I'd really rather see a patch which accounted for the start of the
special command in the first place (via "req_new_io()" when the special
request is first queued), as I suspect that might be a more robust way
of doing things.  But as I said, it would take somebody more familiar
with the IDE code to know whether that's really going to be better or
not.

Cheers,
 Stephen

