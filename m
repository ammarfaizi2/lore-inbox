Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWCMQIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWCMQIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 11:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWCMQIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 11:08:35 -0500
Received: from pat.uio.no ([129.240.130.16]:4755 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932108AbWCMQIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 11:08:34 -0500
Subject: Re: [PATCH] Fix deadlock in RPC scheduling code.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Aurelien Degremont <aurelien.degremont@cea.fr>
Cc: Jacques-Charles Lafoucriere <jc.lafoucriere@cea.fr>,
       Bruno Faccini <bruno.faccini@bull.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200603131516.QAA19564@styx.bruyeres.cea.fr>
References: <200603091035.LAA04829@styx.bruyeres.cea.fr>
	 <1141915219.8293.5.camel@lade.trondhjem.org>
	 <200603101510.QAA17788@styx.bruyeres.cea.fr>
	 <1142004255.8041.26.camel@lade.trondhjem.org>
	 <200603131007.LAA10812@styx.bruyeres.cea.fr>
	 <1142260115.7996.13.camel@lade.trondhjem.org>
	 <200603131516.QAA19564@styx.bruyeres.cea.fr>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 11:08:23 -0500
Message-Id: <1142266103.8017.1.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.999, required 12,
	autolearn=disabled, AWL 1.00, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 16:16 +0100, Aurelien Degremont wrote:

> IMO, the code will still hang because, the list_for_each_entry_safe() 
> loop will never complete, even with the new scheme. Indeed, the loop 
> call __rpc_wake_up_task() will try to set RPC_TASK_WAKEUP bit, but it is 
> already set by rpc_wake_up_task(), so it hangs...

Look again. There is nothing that loops in __rpc_wake_up_task(). If the
RPC_TASK_WAKEUP is already set, then the function exits.

Cheers,
  Trond

