Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbWHIIJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbWHIIJj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbWHIIJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:09:39 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:16344 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S965098AbWHIIJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:09:38 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: How to lock current->signal->tty
References: <1155050242.5729.88.camel@localhost.localdomain>
	<44D8A97B.30607@linux.intel.com>
	<1155051876.5729.93.camel@localhost.localdomain>
	<20060808164127.GA11392@intel.com>
	<1155059405.5729.103.camel@localhost.localdomain>
From: Jes Sorensen <jes@sgi.com>
Date: 09 Aug 2006 04:09:37 -0400
In-Reply-To: <1155059405.5729.103.camel@localhost.localdomain>
Message-ID: <yq0u04mtjni.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Alan> Ar Maw, 2006-08-08 am 09:41 -0700, ysgrifennodd Luck, Tony:
>> unaligned accesses at all is rather controversial.  So its a 50-50
>> shot whether I'll fix it by adding the mutex_lock/mutex_unlock
>> around the use of current->signal->tty, or just rip this out and
>> just leave the printk().

Alan> Personally I'd just rip it out full stop. Its trivial to use
Alan> kprobes and friends to audit such things if there is a
Alan> performance concern.

Personally I don't like the current approach. However, I believe the
philosophy behind it is that users rarely look in dmesg and they
should be notified (and beaten with a stick) when their badly written
app spawns unaligned accesses which end up being emulated by the
kernel.

These messages are normally caused by userland code, so kprobes
probably wont do much good :)

Cheers,
Jes
