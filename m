Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314417AbSEPQzA>; Thu, 16 May 2002 12:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314446AbSEPQy7>; Thu, 16 May 2002 12:54:59 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:19984 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S314417AbSEPQy6>;
	Thu, 16 May 2002 12:54:58 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200205161635.RAA26824@gw.chygwyn.com>
Subject: Re: Kernel deadlock using nbd over acenic driver.
To: ptb@it.uc3m.es
Date: Thu, 16 May 2002 17:35:43 +0100 (BST)
Cc: oxymoron@waste.org (Oliver Xymoron),
        chen_xiangping@emc.com (chen xiangping),
        jes@wildopensource.com ('Jes Sorensen'), linux-kernel@vger.kernel.org
In-Reply-To: <200205161645.g4GGjTu29201@oboe.it.uc3m.es> from "Peter T. Breuer" at May 16, 2002 06:45:29 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> "Oliver Xymoron wrote:"
> > On Thu, 16 May 2002, Peter T. Breuer wrote:
> > > Any way of making sure that send_msg on the socket can always get the
> > > (known a priori) buffers it needs?
> > 
> > Not at present. Note that we also need reservations on the receive side
> > for ACK handling which is "interesting".
> 
> One thing at a time.  What if there is a zone "ceiling" that we keep
> lowered exactly until it is time for the process that does the send_msg
> to run, when we raise the ceiling.  (I don't know how this VM stuff
> works in detail inside - this is an invitation to list the objections).
> The scheduler could presumably be trained to muck with the ceilings
> according to flags on the process (task?) structs.
> 
> Peter
> 
Thats effectively what PF_MEMALLOC does. The code in question is in
page_alloc.c:__alloc_pages just before and after the rebalance: label.
The z->pages_min gives a per zone minimum for "other processes" that are
not PF_MEMALLOC,

Steve.

