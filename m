Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbTI3Imx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 04:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbTI3Imw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 04:42:52 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:28622 "EHLO
	executor.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S261224AbTI3Imv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 04:42:51 -0400
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
From: David Woodhouse <dwmw2@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: bunk@fs.tum.de, acme@conectiva.com.br, netdev@oss.sgi.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030930013025.697c786e.davem@redhat.com>
References: <20030928225941.GW15338@fs.tum.de>
	 <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de>
	 <20030929220916.19c9c90d.davem@redhat.com>
	 <1064903562.6154.160.camel@imladris.demon.co.uk>
	 <20030930000302.3e1bf8bb.davem@redhat.com>
	 <1064907572.21551.31.camel@hades.cambridge.redhat.com>
	 <20030930010855.095c2c35.davem@redhat.com>
	 <1064910398.21551.41.camel@hades.cambridge.redhat.com>
	 <20030930013025.697c786e.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1064911360.21551.49.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Tue, 30 Sep 2003 09:42:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-30 at 01:30 -0700, David S. Miller wrote:
> If 'make modules' doesn't check if the config change has hit a
> dependency that requires the core kernel image to be rebuilt, we need
> to fix that.  'make modules' depends upon the kernel image.

'make modules' should make the modules. If for some reason this really
does require the core kernel image to be present and up to date, perhaps
for modversions, then I agree that it should also rebuild the core
kernel.

If there's no actual dependency on the core kernel image, however, then
it should not be rebuilt for 'make modules'. If 'make modules' was
equivalent to 'make all' then it should not exist at all.

Consider the case where you run a distribution kernel but wish to
compile a couple of extra modules for esoteric hardware, file systems or
protocols. Why would you want 'make modules' to rebuild the kernel
image? The one you're already running is just fine.

Besides, the whole question is mostly is orthogonal to the assertion
that a config change from 'n' to 'm' should not effect changes in the
core kernel.

-- 
dwmw2

