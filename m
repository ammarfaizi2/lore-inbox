Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTJDGj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 02:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbTJDGj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 02:39:56 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:3476 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S261914AbTJDGjz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 02:39:55 -0400
Message-ID: <3F7E6B10.2000503@redhat.com>
Date: Fri, 03 Oct 2003 23:39:12 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?UGV0ZXIg77+9?= <pwaechtler@mac.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       bo.z.li@intel.com, manfred@colorfullife.com
Subject: Re: [PATCH] [2/2] posix message queues
References: <1065196646.3682.54.camel@picklock.adams.family>
In-Reply-To: <1065196646.3682.54.camel@picklock.adams.family>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wächtler wrote:

> +			if (q->notify.sigev_notify == SIGEV_THREAD) {
> +				
> +				err = -ENOSYS;
> +				pr_info("mq_*send: SIGEV_THREAD not supported\n");
> +			}

In all the SIGEV_THREAD cases I suggest that you expect to be passed a
futex address.  Upon completion you increment the value and call
sys_futex with FUTEX_WAKE.

This gives plenty of freedom at userlevel to implement the actual work.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

