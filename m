Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWCMDEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWCMDEz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 22:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWCMDEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 22:04:55 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:24218 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750840AbWCMDEy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 22:04:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LDHhF4GwZml9wbvP/Jga0yjLtMj/vJI9mSeXhBBkzABZPwHVtGVtIGa8oTZF7iu2jh4FAepSR0M7TxLA/m2bD3BQENjk4gWDXPOU4BRFRTCaoGLsT2zEhNic88zy0oHE5mVu1/L0f4LGqs31zRefjUXI4TMxdr+yAfXeDUcl96U=
Message-ID: <661de9470603121904h7e83579boe3b26013f771c0f2@mail.gmail.com>
Date: Mon, 13 Mar 2006 08:34:53 +0530
From: "Balbir Singh" <bsingharora@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [patch 1/3] radix tree: RCU lockless read-side
Cc: "Nick Piggin" <npiggin@suse.de>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
In-Reply-To: <44128EDA.6010105@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060207021822.10002.30448.sendpatchset@linux.site>
	 <20060207021831.10002.84268.sendpatchset@linux.site>
	 <661de9470603110022i25baba63w4a79eb543c5db626@mail.gmail.com>
	 <44128EDA.6010105@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Balbir Singh wrote:
> > <snip>
> >
> >>                if (slot->slots[i]) {
> >>-                       results[nr_found++] = slot->slots[i];
> >>+                       results[nr_found++] = &slot->slots[i];
> >>                        if (nr_found == max_items)
> >>                                goto out;
> >>                }
> >
> >
> > A quick clarification - Shouldn't accesses to slot->slots[i] above be
> > protected using rcu_derefence()?
> >
>
> I think we're safe here -- this is the _address_ of the pointer.
> However, when dereferencing this address in _gang_lookup,
> I think we do need rcu_dereference indeed.
>

Yes, I saw the address operator, but we still derefence "slots" to get
the address.

> Note that _gang_lookup_slot doesn't do this for us, however --
> the caller must do that when dereferencing the pointer to the
> item (eg. see page_cache_get_speculative in 2/3).

Oh! I did not get that far. Will look at the rest of the series

>
> That said, I'm not 100% sure I have the rcu memory barriers in
> the right places (well I'm sure I don't, given the _gang_lookup
> bug you exposed!).

Hmm... Let me look at rcu_torture module and see if I can figure it
out or read the documentation again.

>
> Thanks,
> Nick
>

Warm Regards,
Balbir
