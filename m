Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTLDScV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTLDScQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:32:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:173 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263787AbTLDScJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:32:09 -0500
Date: Thu, 4 Dec 2003 10:30:41 -0800
From: "David S. Miller" <davem@redhat.com>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: mukansai@emailplus.org, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: Extremely slow network with e1000 & ip_conntrack
Message-Id: <20031204103041.21aefd8d.davem@redhat.com>
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD21@orsmsx402.jf.intel.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD21@orsmsx402.jf.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003 09:37:19 -0800
"Feldman, Scott" <scott.feldman@intel.com> wrote:

> TSO is support on 82540.  Turning off TSO is a workaround, but what's
> behind the dependency of TSO and ip_conntrack?

Netfilter wants to see the _real_ packets that will be sent onto the
wire.  TSO is a template by which to create such packets, not the real
thing.

So when and if we go into netfilter, we must un-TSO the packet so
that netfilter can look at what it really wants to.
