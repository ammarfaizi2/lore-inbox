Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbTHaTNV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 15:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbTHaTNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 15:13:21 -0400
Received: from iris.coastside.net ([207.213.212.14]:44748 "HELO
	iris.coastside.net") by vger.kernel.org with SMTP id S261629AbTHaTNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 15:13:20 -0400
Mime-Version: 1.0
Message-Id: <p06001fdabb77f774f0a1@[10.2.0.101]>
In-Reply-To: <3F52199B.5020808@kegel.com>
References: <3F52199B.5020808@kegel.com>
Date: Sun, 31 Aug 2003 12:08:56 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: Andrea VM changes
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 8:51am -0700 8/31/03, Dan Kegel wrote:
>In the test-and-measurement system I'm developing,
>it turned out the sanest thing to do with OOM conditions
>was to consider them user errors, and to handle them
>by dumping memory usage info about processes and slab caches,
>then halt.  It's been very helpful because it turns flaky
>conditions into rock-solid failures.  Too bad this drastic
>approach isn't appropriate for general use.

Likewise in an HA environment, if you've got a standby node 
available, we prefer to fail over on an oom condition or (or an oops, 
for that matter) than to try to continue running in some randomly 
crippled way. The node in question can then reboot and return to 
service as a standby.

Ideally, we'd have a notifier that would be triggered for every 
unanticipated process kill (oom, oops, whatever).
-- 
/Jonathan Lundell.
