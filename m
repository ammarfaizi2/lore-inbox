Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWHWNtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWHWNtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 09:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWHWNtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 09:49:21 -0400
Received: from ns2.suse.de ([195.135.220.15]:20629 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932226AbWHWNtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 09:49:19 -0400
From: Andi Kleen <ak@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Subject: Re: [PATCH 2/6] BC: beancounters core (API)
Date: Wed, 23 Aug 2006 15:48:05 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Greg KH <greg@kroah.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
References: <44EC31FB.2050002@sw.ru> <200608231337.48941.ak@suse.de> <44EC57BD.4020807@sw.ru>
In-Reply-To: <44EC57BD.4020807@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608231548.05353.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 August 2006 15:27, Kirill Korotaev wrote:
> Andi Kleen wrote:
> > On Wednesday 23 August 2006 13:03, Kirill Korotaev wrote:
> > 
> > 
> >>+#ifdef CONFIG_BEANCOUNTERS
> >>+extern struct hlist_head bc_hash[];
> >>+extern spinlock_t bc_hash_lock;
> > 
> > 
> > I wonder who pokes into that hash from other files? Looks a bit dangerous.
> it was kernel/ub/proc.c with proc interface :)
> however, we removed it from this patchset version, but forgot extern's...
> 
> will remove

Best remove the EXPORT_SYMBOLs too and make it static.

> >>+void __put_beancounter(struct beancounter *bc);
> >>+static inline void put_beancounter(struct beancounter *bc)
> >>+{
> >>+	__put_beancounter(bc);
> >>+}
> > 
> > 
> > The wrapper seems pointless too.
> yep, almost the same reason :)
> 
> > The file could use a overview comment what the various counter
> > types actually are.
> you mean comment about what resource parameters we introduce?

I meant about what a barrier counter etc. is and what makes
it different from other counters.

The individual resources can be probably described elswhere.

-Andi
