Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265554AbTHXJrE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 05:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265974AbTHXJrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 05:47:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:34488 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S281604AbTHXJrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 05:47:00 -0400
Date: Sun, 24 Aug 2003 02:48:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Zheng, Jeff" <jeff.zheng@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is it a bug (about share memory)?
Message-Id: <20030824024841.7c641454.akpm@osdl.org>
In-Reply-To: <37FBBA5F3A361C41AB7CE44558C3448E011958E9@pdsmsx403.ccr.corp.intel.com>
References: <37FBBA5F3A361C41AB7CE44558C3448E011958E9@pdsmsx403.ccr.corp.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zheng, Jeff" <jeff.zheng@intel.com> wrote:
>
> I tried to use share memory to check vm overcommit by check Committed_AS
> in /proc/meminfo. It seems that attach of share momory will add the value
> of Committed_AS but detach of share memory does not reduce the value of
> Committed_AS.

shmdt() will not release resources.  Run `ipcs' after your test app and you
will see the shm segment is still there.

Release it with ipcrm and Committed_AS falls back as expected.

