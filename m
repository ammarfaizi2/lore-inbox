Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSJCPKx>; Thu, 3 Oct 2002 11:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbSJCPKx>; Thu, 3 Oct 2002 11:10:53 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:2033 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261292AbSJCPKr>; Thu, 3 Oct 2002 11:10:47 -0400
Subject: Re: [PATCH] Start of cleaning up socket ioctls
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021003155241.G28586@parcelfarce.linux.theplanet.co.uk>
References: <20021003155241.G28586@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 16:23:19 +0100
Message-Id: <1033658599.28850.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 15:52, Matthew Wilcox wrote:
> 
> All the ioctls are passed to the socket's ioctl methods, even when they're
> utterly generic.  Here's a patch which starts to move the really generic
> ones up to the top level.  As you can see, this eliminates a huge amount
> of code duplication.
  

Nice but one request - can you call the protocol handlers first and if
they return -ENOTTY then call the default ones provided by the upper
layer. That will let you remove even more common code to most versions,
make it work like the serial and other layers do, and still let people
override defaults

