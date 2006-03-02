Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWCBEPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWCBEPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 23:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWCBEPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 23:15:15 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:45603 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750870AbWCBEPN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 23:15:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EucXKG+SoWsWBzZqNGY4/FNdCSyYBt18wYD/+VjthzXr3by7ktGgx0IoROTS9Zu71G1mqFQEc5Hpab5v+k4IVpG3fStgeDupi+Pv7GiUhynhGuOS+56lgdhb8Y5YIyYbDQ2zWk0jQYZMd9dGOGmzwV+m92hOmpe4KOmgnmc1wS0=
Message-ID: <12c511ca0603012015g7a5bfa8dw4295c59f5dace4f9@mail.gmail.com>
Date: Wed, 1 Mar 2006 20:15:12 -0800
From: "Tony Luck" <tony.luck@intel.com>
To: "Zou Nan hai" <nanhai.zou@intel.com>
Subject: Re: [Patch] Move swiotlb_init early on X86_64
Cc: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Andi Kleen" <ak@suse.de>,
       "Venkatesh Pallipadi" <venkatesh.pallipadi@intel.com>
In-Reply-To: <1141175458.2642.78.camel@linux-znh>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1141175458.2642.78.camel@linux-znh>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Mar 2006 09:10:58 +0800, Zou Nan hai <nanhai.zou@intel.com> wrote:
> on X86_64, swiotlb buffer is allocated in mem_init, after memmap and vfs cache allocation.
>
> On platforms with huge physical memory,
> large memmap and vfs cache may eat up all usable system memory
> under 4G.
>
> Move swiotlb_init early before memmap is allocated can
> solve this issue.

Shouldn't memmap be allocated from memory above 4G (if available)? Using
up lots of <4G memory on something that doesn't need to be below 4G
sounds like a poor use of resources.

-Tony
