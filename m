Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbTLDSZo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTLDSZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:25:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60844 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263472AbTLDSZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:25:38 -0500
Date: Thu, 4 Dec 2003 10:24:20 -0800
From: "David S. Miller" <davem@redhat.com>
To: Stephen Lee <mukansai@emailplus.org>, torvalds@osdl.org
Cc: scott.feldman@intel.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: Extremely slow network with e1000 & ip_conntrack
Message-Id: <20031204102420.2aa43b43.davem@redhat.com>
In-Reply-To: <20031204213030.2B75.MUKANSAI@emailplus.org>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD1F@orsmsx402.jf.intel.com>
	<20031204213030.2B75.MUKANSAI@emailplus.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Dec 2003 21:36:09 +0900
Stephen Lee <mukansai@emailplus.org> wrote:

> "Feldman, Scott" <scott.feldman@intel.com> wrote:
> > 
> > Try turning off TSO by disabling this code or by using "ethtool -K tso
> > off" (need version 1.8).
> 
> Yes, turning off TSO with ethtool fixed it (tested on 2.6.0-test11).  At
> least we have a workaround now.
> 
> Thanks Scott, Harald and Dave.
> 
> Is it not supported by the hardware?  Seems TSO could improve
> performance a bit since the 1000/MT Desktop is starved for PCI bandwidth
> at 32-bit/33MHz.

This workaround explains everything.  The TSO packets have to be
"un-TSO'd" in order for netfilter to look at the packet and parse
the contents.  This means copying all the data around, allocating
several networking buffers, etc.
