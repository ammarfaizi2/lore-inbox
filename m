Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbTLENZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 08:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264110AbTLENZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 08:25:57 -0500
Received: from rcpt-expgw.biglobe.ne.jp ([202.225.89.197]:51639 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id S264108AbTLENZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 08:25:56 -0500
X-Biglobe-Sender: <slee@muf.biglobe.ne.jp>
Date: Fri, 05 Dec 2003 22:25:53 +0900
From: Stephen Lee <mukansai@emailplus.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Extremely slow network with e1000 & ip_conntrack
Cc: Stephen Lee <mukansai@emailplus.org>,
       "Feldman, Scott" <scott.feldman@intel.com>,
       Harald Welte <laforge@netfilter.org>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>
In-Reply-To: <3FCF9497.3030708@pobox.com>
References: <20031205045020.4C0E.MUKANSAI@emailplus.org> <3FCF9497.3030708@pobox.com>
Message-Id: <20031205222541.3427.MUKANSAI@emailplus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Okay, I reproduced it with tg3 on 2.6.0-test11 as well, by turning on
TSO with ethtool.  So it does seem to be an incompatibility between TSO
& conntrack.

"David S. Miller" <davem@redhat.com> wrote:
> This workaround explains everything.  The TSO packets have to be
> "un-TSO'd" in order for netfilter to look at the packet and parse
> the contents.  This means copying all the data around, allocating
> several networking buffers, etc.

But, if netfilter needs to see all the contents in order to function,
shouldn't TSO break other parts of netfilter as well?  Why is only
conntrack affected?

Jeff Garzik <jgarzik@pobox.com> wrote:
> Regardless, the problem is identified -- when TSO+conntrack is present,
> we "TSO" net traffic then "un-TSO" it.

This "un-TSO"ing more or less defeats the purpose of TSO, right?  

> It's simply better to not use TSO at all, for this case.

If that is the case, I suppose so.

Thanks,
Stephen

