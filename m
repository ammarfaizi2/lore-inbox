Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270692AbTHJV3a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270701AbTHJV3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:29:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:13966 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270692AbTHJV33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:29:29 -0400
Date: Sun, 10 Aug 2003 14:29:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: ranty@debian.org
Cc: linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: [PATCH] [2.6.0-test3] request_firmware related problems.
Message-Id: <20030810142928.4b734e8d.akpm@osdl.org>
In-Reply-To: <20030810210646.GA6746@ranty.pantax.net>
References: <20030810210646.GA6746@ranty.pantax.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manuel Estrada Sainz <ranty@debian.org> wrote:
>
>  Please apply the following patches.

Please, send just one patch per email, each one having its own changelog
info.  There's just no way anyone's patch import tools can handle a single
changelog and multiple attachments.  It is painful.

>   - request_firmware_own-workqueue.diff:
>  	-  In it's current form request_firmware_async() sleeps way too
>  	   long on the system's shared workqueue, which makes it
>  	   unresponsive until the firmware load finishes, gets canceled
>  	   or times out.

Does this mean that we have another gaggle of kernel threads for all the
time the system is up?

It might be better to create a custom kernel thread on-demand, or kill off
the workqueue when its job has completed.

