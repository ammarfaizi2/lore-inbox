Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266836AbUHXG2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266836AbUHXG2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 02:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266849AbUHXG2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 02:28:17 -0400
Received: from jack.feedbackplusinc.com ([64.25.11.70]:44773 "EHLO
	jack.feedbackplusinc.com") by vger.kernel.org with ESMTP
	id S266836AbUHXG2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 02:28:03 -0400
Subject: Re: setpeuid(pid_t, uid_t) proposal
From: Jerry Haltom <wasabi@larvalstage.net>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200408240558.i7O5wFuP031966@turing-police.cc.vt.edu>
References: <1093323005.1248.21.camel@localhost>
	 <200408240558.i7O5wFuP031966@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Tue, 24 Aug 2004 01:27:50 -0500
Message-Id: <1093328870.1248.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What does this buy you that having the separate daemon just do
> a fork/seteuid/exec to do the work, and passing the results back via a
> Unix socket or shared mem or what-have-you?

To do a seteuid the daemon would need to be root. This means it would be
processing remote information of a sensitive nature, such as Kerberos
ticket acquisition, SASL stuff, etc, as root. Something I'm trying to
avoid. It has to first determine what uid before it can call setuid and
the process of determining this uid is very sensitive in many
situations.

> Alternatively, what would this give you that isn't already done by
> the SELinux support for cron, or Apache suexec, which already allow
> "run the following in another context" functionality?

I don't know about this SELinux thing you speak of yet, I'll look into
it. Apache suexec spawns a seperate process for each individual request.
It cannot function properly with in process modules, such as mod_webdav,
mod_php, and... all the others. Being able to function in process is the
main idea behind this.


Jerry Haltom <wasabi@larvalstage.net>

