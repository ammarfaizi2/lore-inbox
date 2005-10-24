Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVJXW2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVJXW2b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 18:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVJXW2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 18:28:31 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:32636 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751118AbVJXW2a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 18:28:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aNchn12xLqiWHOHejFuudhXv+/0oGZzhh3SoL8HbxEHvOWF4wJt57UR49hENS9D55pwZ8nno0kjYnlRd1/3wvxWRErXcDWEJp4dvNaURU4znetvgdvM2ZlgZWbLE9U0b1m3/ZWPgAbUTQ29ytqxGNozJ8P0IMyOf6F8xE5SRpdQ=
Message-ID: <4807377b0510241528m6afc3501w9d98d66658a38973@mail.gmail.com>
Date: Mon, 24 Oct 2005 15:28:29 -0700
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.14-rc5 e1000 and page allocation failures.. still
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>
In-Reply-To: <435C2D66.6030708@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50tDw-1FH-5@gated-at.bofh.it> <435C2D66.6030708@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/05, Robert Hancock <hancockr@shaw.ca> wrote:
> John Bäckstrand wrote:
> > Im seeing a massive amount of page allocation failures with 2.6.14-rc5,
> > and also earlier kernels, see "E1000 - page allocation failure - saga
[snip]
> It looks like you have enough memory free - the problem is that the
> driver is allocating a block of memory with order 3, which is 8 pages.
> Quite likely there are not enough contiguous free pages to satisfy that.
>
> That's an awful big buffer size for a packet - I assume you're using
> jumbo frames or something? Ideally the driver and hardware should be
> able to allocate a buffer for those packets in multiple chunks, but I
> have no idea if this is possible.

the latest e1000 driver (6.2.15) from http://sf.net/projects/e1000
fixes this by using multiple descriptors for jumbo frames, therefore
only doing order 0 (single page) page allocations.

let us know how it goes.

BTW why is this so much more common with recent kernels?
