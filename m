Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVCOGmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVCOGmp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 01:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVCOGmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 01:42:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:731 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262284AbVCOGmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 01:42:36 -0500
Date: Mon, 14 Mar 2005 22:42:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce __deprecated spew
Message-Id: <20050314224221.442570a8.akpm@osdl.org>
In-Reply-To: <20050315063436.GN32638@waste.org>
References: <20050315063436.GN32638@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
>  This patch changes a couple of the noisier deprecations to only warn
>  on the primary entrypoint (in these cases, the _register functions).
>  This approach makes it obvious that an interface is going away while
>  only warning once per user. I suggest we adopt this approach for
>  future deprecation campaigns.

But that's going to warn when the deprecated function itself is compiled,
isn't it?

If so, that's backwards.  We want to warn when the deprecated function is
_used_, so people go fix up their code, and we can then remove the
deprecated function.

(The intermodule_register and pm_register stuff has been hanging around for
so long that one wonders if we need sterner stimuli, not lesser).
