Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269961AbTGPG0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 02:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270009AbTGPG0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 02:26:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20697 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S269961AbTGPG0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 02:26:11 -0400
Date: Tue, 15 Jul 2003 23:30:34 -0700
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch] e1000 TSO parameter
Message-Id: <20030715233034.31bf0709.davem@redhat.com>
In-Reply-To: <16148.61840.663255.863176@napali.hpl.hp.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229169@orsmsx402.jf.intel.com>
	<20030714214510.17e02a9f.davem@redhat.com>
	<16147.37268.946613.965075@napali.hpl.hp.com>
	<20030714223822.23b78f9b.davem@redhat.com>
	<16148.34787.633496.949441@napali.hpl.hp.com>
	<20030715183911.1c18cc15.davem@redhat.com>
	<16148.61840.663255.863176@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003 23:32:48 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

>   DaveM> No, I mean "bypass L2 cache on miss" for stores.  Don't tell
>   DaveM> me IA64 doesn't have that? 8) I certainly didn't mean "always
>   DaveM> bypass L2 cache" for stores :-)
> 
> What I'm saying is that I almost always want copy_user() to put the
> destination data in the cache, even if it isn't cached yet.

No you don't :-)

If you miss, you do a bypass to main memory.  Then when the
app asks for the data (if it even does at all, consider that)
it get's a clean copy in it's L2 cache.

Overall it's more efficient this way.

> Many copy_user() calls are for for data structures that
> easily fit in the cache and the data is usually used quickly afterwards.

Absolutely correct.  We can't use the cache bypass-on-miss stores on
sparc64 unless the copy is at least a couple of cachelines in size.

It all works out, don't worry :-)
