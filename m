Return-Path: <linux-kernel-owner+w=401wt.eu-S1757574AbWLIDV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574AbWLIDV4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 22:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758219AbWLIDV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 22:21:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56547 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757574AbWLIDV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 22:21:56 -0500
Date: Fri, 8 Dec 2006 19:20:27 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Erik Jacobson <erikj@sgi.com>
Cc: guillaume.thouvenin@bull.net, matthltc@us.ibm.com, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] connector: Some fixes for ia64 unaligned access errors
Message-Id: <20061208192027.18a1e708.zaitcev@redhat.com>
In-Reply-To: <20061207232213.GA29340@sgi.com>
References: <20061207232213.GA29340@sgi.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.6; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006 17:22:13 -0600, Erik Jacobson <erikj@sgi.com> wrote:

> Here, we just adjust how the variables are declared and use memcopy to
> avoid the error messages.
> -	ev->timestamp_ns = timespec_to_ns(&ts);
> +	ev.timestamp_ns = timespec_to_ns(&ts);

Please try to declare u64 timestamp_ns, then copy it into the *ev
instead of copying whole *ev. This ought to fix the problem if
buffer[] ends aligned to 32 bits or better.

Also... Since Linus does not take patches in general off l-k anymore,
you have to find whoever herds the connector and feed the patch through
him/her.

-- Pete
