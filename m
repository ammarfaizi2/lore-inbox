Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWHPOVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWHPOVk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWHPOVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:21:40 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:60141 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751078AbWHPOVj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:21:39 -0400
Date: Wed, 16 Aug 2006 22:45:29 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org
Subject: Re: [PATCH 7/7] file: Modify struct fown_struct to use a struct pid.
Message-ID: <20060816184529.GB472@oleg>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com> <11556661943487-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11556661943487-git-send-email-ebiederm@xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15, Eric W. Biederman wrote:
>
> File handles can be requested to send sigio and sigurg
> to processes.   By tracking the destination processes
> using struct pid instead of pid_t we make the interface
> safe from all potential pid wrap around problems.

As I can see, this patch adds 2 user visible changes. I am
not arguing, but probably it makes sense to document this.

Before this patch, fcntl(F_GETOWN) returns the same pid that
was given to fcntl(F_SETOWN). Now it returns 0 if there were
no process/group with such a pid when F_SETOWN was called.

The second change is good (I'd say this is bugfix). It is
not possible anymore to send the signal to not yet created
processes via fcntl(F_SETOWN, last_pid + a_little), or hit
a problem with pid re-use.

Oleg.

