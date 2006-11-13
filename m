Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754520AbWKMMSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbWKMMSE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754523AbWKMMSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:18:04 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:7049 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1754520AbWKMMSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:18:01 -0500
Message-ID: <45586175.4090007@openvz.org>
Date: Mon, 13 Nov 2006 15:13:41 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, xemul@openvz.org, devel@openvz.org,
       oleg@tv-sign.ru, hch@infradead.org, matthltc@us.ibm.com,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH 6/13] BC: kmemsize accounting (core)
References: <45535C18.4040000@sw.ru> <45535EA3.10300@sw.ru> <84144f020611101446o3a1c05d0i592ea0ca853b73c@mail.gmail.com>
In-Reply-To: <84144f020611101446o3a1c05d0i592ea0ca853b73c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> Hi,
> 
> On 11/9/06, Kirill Korotaev <dev@sw.ru> wrote:
>> +#ifdef CONFIG_BEANCOUNTERS
>> +#define BC_EXTRASIZE   sizeof(struct beancounter *)
>> +static inline size_t slab_mgmt_size_noalign(int flags, size_t nr_objs)
>> +{
>> +       size_t size;
>> +
>> +       size = slab_mgmt_size_raw(nr_objs);
>> +       if (flags & SLAB_BC)
>> +               size = ALIGN(size, BC_EXTRASIZE) + nr_objs *
>> BC_EXTRASIZE;
>> +       return size;
> 
> Why do we want to track each allocated _object_ in the slab? Isn't
> tracking pages enough?

No. One page may contain objects allocated in different beancounters.
