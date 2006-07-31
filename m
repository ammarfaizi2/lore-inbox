Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWGaELh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWGaELh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWGaELh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:11:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35726 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751441AbWGaELg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:11:36 -0400
Date: Sun, 30 Jul 2006 21:11:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 008 of 11] knfsd: add svc_set_num_threads
Message-Id: <20060730211130.be44c1d0.akpm@osdl.org>
In-Reply-To: <1060731004223.29267@suse.de>
References: <20060731103458.29040.patches@notabene>
	<1060731004223.29267@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 10:42:23 +1000
NeilBrown <neilb@suse.de> wrote:

> +	/* destroy old threads */
> +	while (nrservs < 0 &&
> +	       (victim = choose_victim(serv, pool, &state)) != NULL) {
> +		send_sig(serv->sv_kill_signal, victim, 1);
> +		nrservs++;

Using signals to communicate with kernel threads is rather baroque - we
have a range of less klunky ways of controlling kernel threads in-kernel.

The containers guys are going through converting lots of these things over
to the kthread API - I believe it's a requirement for containerisation.

nfsd/rpc is going to be one of the hard ones to convert, but it's going to
happen.
