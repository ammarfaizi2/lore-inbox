Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbTJEP7c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 11:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbTJEP7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 11:59:32 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:32412
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263135AbTJEP7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 11:59:31 -0400
Message-ID: <3F803FB4.6050900@redhat.com>
Date: Sun, 05 Oct 2003 08:58:44 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Peter_W=E4chtler?= <pwaechtler@mac.com>
CC: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, bo.z.li@intel.com
Subject: Re: [PATCH] [2/2] posix message queues
References: <1065196646.3682.54.camel@picklock.adams.family>	 <3F7DBCF6.3050407@colorfullife.com> <1065282666.2448.57.camel@picklock.adams.family>
In-Reply-To: <1065282666.2448.57.camel@picklock.adams.family>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wächtler wrote:

> Userspace translates SIGEV_THREAD to something that uses SIGEV_SIGNAL.
> Ulrich made a suggestion to use a futex, but I think of something even
> more lightweight. Just put the requestor right to sleep.

This has the disadvantage that it codifies the requirement of creating
the thread for the userlevel signaling ahead of time.  While this is a
valid implementation it is not the best (resource-wise) and doesn't
allow for optimizations.  Using a futex will allow to implement a scheme
where one single thread does the waiting for possibly many requests.
Imagine the benefits in case there are dozens of outstanding requests.
The additional system exit+entry isn't that expensive to justify
removing the flexibility.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

