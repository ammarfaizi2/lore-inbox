Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVLMP6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVLMP6O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVLMP6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:58:14 -0500
Received: from [81.2.110.250] ([81.2.110.250]:24810 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932336AbVLMP6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:58:13 -0500
Subject: Re: [patch] SMP alternatives for i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerd Knorr <kraxel@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Xen merge mainline list <xen-merge@lists.xensource.com>
In-Reply-To: <439EE742.5040909@suse.de>
References: <439EE742.5040909@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Dec 2005 15:58:02 +0000
Message-Id: <1134489482.11732.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SMP problems with self modifying code are very real but the hotplug
architecture for CPU already deals with these synchronizations and you
can use the SMP cross calls to 'capture' the other processors. The x86
case of processors with differing feature sets is extremely common on
PII/PIII systems and can also occur on other platforms where features
like SSE3 were introduced in later steppings. Clean alternatives support
for such platforms automatically would be good.

Other than that it looks sane to me (well the CPU hotplug case is silly
but the rest makes sense). The various CPU errata come out ok that I can
see as well because they use rmb/wmb/etc and those don't change
behaviour so still maintain store order against the bus.

