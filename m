Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268781AbUJUM4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268781AbUJUM4b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUJUM4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:56:24 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:54693 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S267362AbUJUMxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 08:53:12 -0400
Date: Thu, 21 Oct 2004 14:53:55 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Chris Wright <chrisw@osdl.org>
Cc: mingo@elte.hu, johansen@immunix.com, Stephen Smalley <sds@epoch.ncsc.mil>,
       Thomas Bleher <bleher@informatik.uni-muenchen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] delay rq_lock acquisition in setscheduler
Message-ID: <20041021125355.GF8756@dualathlon.random>
References: <20041020183238.U2357@build.pdx.osdl.net> <20041021020022.GB8756@dualathlon.random> <20041020221632.V2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020221632.V2357@build.pdx.osdl.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 10:16:32PM -0700, Chris Wright wrote:
> true.  another alternative is to drop rq_lock and do the checks over.
> i didn't convince myself yet that there's no chance for livelock,
> although it seems unlikely.

yep, since the workload isn't deterministic if the race triggers I got
convinced the retry loop wasn't strictly needed. There should be no
livelock, however with the loop just like with the spinlocks there's no
fariness guarantee on the numa (especially old numa). (and fixing the
spinlocks is easier for the architecture by implementing a fair version
transparently). That's probably the only issue with the loops.
