Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268372AbUJDRwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268372AbUJDRwi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 13:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268379AbUJDRwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 13:52:37 -0400
Received: from pat.uio.no ([129.240.130.16]:43764 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S268372AbUJDRuu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 13:50:50 -0400
Subject: Re: [PATCH] lockd
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Steve Dickson <SteveD@redhat.com>
Cc: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41617958.2020406@RedHat.com>
References: <41617958.2020406@RedHat.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1096912231.22446.60.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 04 Oct 2004 19:50:31 +0200
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 04/10/2004 klokka 18:24, skreiv Steve Dickson:

> Hey Neil,

Hey! This is the client side NLM code... 8-)

>  	clear_thread_flag(TIF_SIGPENDING);
> -	interruptible_sleep_on_timeout(&lockd_exit, HZ);
> -	if (nlmsvc_pid) {
> +	set_current_state(TASK_UNINTERRUPTIBLE);

Nope. Those clearly are not the same.

Note that you probably also want to move the call to
set_current_state(TASK_INTERRUPTIBLE) inside the loop. In that case you
can also remove the call to set_current_state(TASK_RUNNING) ('cos
schedule_timeout() will do that for you).

Also, why aren't you using the more standard DECLARE_WAITQUEUE(__wait)?

Cheers,
  Trond

