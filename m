Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUAYCNO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 21:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUAYCNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 21:13:14 -0500
Received: from colo.lackof.org ([198.49.126.79]:65509 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S263472AbUAYCNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 21:13:09 -0500
Date: Sat, 24 Jan 2004 19:13:06 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: "David S. Miller" <davem@redhat.com>
Cc: grundler@parisc-linux.org, jgarzik@redhat.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] 2.6.1 tg3 DMA engine test failure
Message-ID: <20040125021306.GE16272@colo.lackof.org>
References: <20040124013614.GB1310@colo.lackof.org> <20040123.210023.74723544.davem@redhat.com> <20040124073032.GA7265@colo.lackof.org> <20040123.233241.59493446.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123.233241.59493446.davem@redhat.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 11:32:41PM -0800, David S. Miller wrote:
>    From: Grant Grundler <grundler@parisc-linux.org>
>    Date: Sat, 24 Jan 2004 00:30:32 -0700
> 
>    My gut feeling is if linux aligns or pads things nicely for any reason,
>    then the bye enables don't get used or clobber padding.
>    
> If the packet data length is an odd number of bytes, there is nothing
> we can do about this, and the newer tigon3 chips are going to use a
> cacheline burst for the end of the packet with the trailing byte
> enables turned off.  I've seen this myself and sparc64 PCI controllers
> generate a streaming byte hole error interrupt when it occurs and I
> get messages logged in dmesg :)

Ugh. Ok.

I was concerned about about the buffer not ending on a well aligned
boundary and someone elses data getting clobbered. But RX buffers are
managed by the OS and I expect them to be well aligned.

>    Maybe keep a shorter note about the bit changed meaning in later models
>    just to document the issues.
>    
> We can "document it" by having the setting of this bit be protected by
> chip version numbers.  I'd happily accept such a patch.

Well, you pointed out it needs to be set on bcm5700/01 for it's 
intended purpose.  And it needs to be set on 5703/04 to enable
PCI-X bug workaround.  BE bit "always" needs to be set.
Did you intend to alias the BE constant to another name?
(and then use respective chip version for each constant)

BTW, I don't know what the story is with bcm5705.

thanks,
grant
