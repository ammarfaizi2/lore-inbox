Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSFNEqQ>; Fri, 14 Jun 2002 00:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317414AbSFNEqP>; Fri, 14 Jun 2002 00:46:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46820 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314381AbSFNEqP>;
	Fri, 14 Jun 2002 00:46:15 -0400
Date: Thu, 13 Jun 2002 21:41:40 -0700 (PDT)
Message-Id: <20020613.214140.26438858.davem@redhat.com>
To: oliver@neukum.name
Cc: wjhun@ayrnetworks.com, paulus@samba.org, roland@topspin.com,
        linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206121408.26897.oliver@neukum.name>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Oliver Neukum <oliver@neukum.name>
   Date: Wed, 12 Jun 2002 14:08:26 +0200
   
   That means that all buffers must be allocated seperately.
   Is it worth that ? How about skbuffs ?

skbuffs are fine, they are already minimally aligned to
SMP_CACHE_BYTES and also have the same minimum length.

The only problematic case are as in the eepro100.c driver where it
tries to use part of the skbuff data area for the receive descriptor.
