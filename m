Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263853AbTH1GNv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 02:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263934AbTH1GNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 02:13:51 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:56710 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263853AbTH1GNu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 02:13:50 -0400
Date: Thu, 28 Aug 2003 07:13:33 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Timo Sirainen <tss@iki.fi>
Cc: root@chaos.analogic.com, Martin Konold <martin.konold@erfrakon.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030828061333.GA5822@mail.jlokier.co.uk>
References: <20030828015027.GA4715@mail.jlokier.co.uk> <3217CEE6-D906-11D7-A165-000393CC2E90@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3217CEE6-D906-11D7-A165-000393CC2E90@iki.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timo Sirainen wrote:
> I'm sure someone has figured out a way to make a checksum of data that 
> can detect if there's even a single bit wrong, if the checksum is 
> allowed to take as much space as the data itself. I should read more 
> about algorithms..

You said that MD5 wasn't strong enough, and you would like a guarantee.

You won't find a guarantee unless you are prepared to use memory
barriers in your code.  _Any_ checksum is going to have a chance of
false validation if you are doing out-of-order reads which can observe
parts of the old and new data, and parts of the old and new checksum.

> How about checksum[n] = data[n-1] ^ data[n]? That looks like it would 
> work.

Consider when the data {1,0,1,0} is replaced by {2,0,2,0}.

-- Jamie

