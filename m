Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbUCJViX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbUCJVgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:36:37 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:54467 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262859AbUCJVf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:35:58 -0500
Date: Wed, 10 Mar 2004 16:35:55 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Urban Widmark <urban@teststation.com>
Cc: Adam Sampson <azz@us-lot.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smbfs Oops with Linux 2.6.3
In-Reply-To: <Pine.LNX.4.44.0403102145460.12892-100000@cola.local>
Message-ID: <Pine.LNX.4.58.0403101627410.29087@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0403102145460.12892-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Urban Widmark wrote:

> Shouldn't "wq" be accessible to both smb_newconn and smb_proc_ops_wait?
> I'd put it in the "server" struct and then have smb_newconn() do this
> when it is done:
> 	wake_up_interruptible_all(&server->ops_wq);

Oops, yes my code was horribly broken, the previous patch will only avoid
the oops since readdir won't be NULL, but is still fundamentally wrong.

> I don't know enough about wait_queue's to understand why it would work
> otherwise. The only thing I can think of is that the condition is true
> before it actually waits on anything.
>
> Since install_ops isn't the last thing done in smb_newconn perhaps a
> different variable should be used to signal that a new connection is
> there. I would suggest using "server->state == CONN_VALID" and then move
> that assignment to the end of smb_newconn.
>
> If you are in cleanup mode the following changes should probably be made:
>
> server->rcls	replaced by	req->rq_rcls
> server->err	replaced by	req->rq_err

Sure thing, i'll fix it up.

Thanks,
	Zwane

