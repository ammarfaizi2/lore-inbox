Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWIHT4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWIHT4T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 15:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWIHT4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 15:56:18 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:2055 "EHLO mms1.broadcom.com")
	by vger.kernel.org with ESMTP id S1751122AbWIHT4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 15:56:17 -0400
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Subject: Re: TG3 data corruption (TSO ?)
From: "Michael Chan" <mchan@broadcom.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <9EAEC3B2-260E-444E-BCA1-3C9806340F65@kernel.crashing.org>
References: <1551EAE59135BE47B544934E30FC4FC093FB19@NT-IRVA-0751.brcm.ad.broadcom.com>
 <9EAEC3B2-260E-444E-BCA1-3C9806340F65@kernel.crashing.org>
Date: Fri, 08 Sep 2006 12:54:16 -0700
Message-ID: <1157745256.5344.8.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006090807; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230332E34353031433934422E303034442D412D;
 ENG=IBF; TS=20060908195610; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006090807_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 691F155F3CC5747514-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 21:29 +0200, Segher Boessenkool wrote:

> I've got a patch that seems so solve the problem, it needs more testing
> though (maybe Ben can do this :-) ).  The problem is that there should
> be quite a few wmb()'s in the code that are just not there; adding some
> to tg3_set_txd() seems to fix the immediate problem but more is needed
> (and I don't see why those should be needed, unless tg3_set_txd() is
> updating a life ring entry in place or something like that).
> 
> More testing is needed, but the problem is definitely the lack of memory
> ordering.
> 
Oh, we know about this.  The powerpc writel() used to have memory
barriers in 2.4 kernels but not any more in 2.6 kernels.  Red Hat's
version of tg3 has extra wmb()'s to fix this problem.  David doesn't
think that the upstream version of tg3 should have these wmb()'s, and
the problem should instead be fixed in powerpc's writel().

