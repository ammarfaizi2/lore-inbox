Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261602AbSJJN1P>; Thu, 10 Oct 2002 09:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261603AbSJJN1P>; Thu, 10 Oct 2002 09:27:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31163 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261602AbSJJN1O>;
	Thu, 10 Oct 2002 09:27:14 -0400
Date: Thu, 10 Oct 2002 06:25:41 -0700 (PDT)
Message-Id: <20021010.062541.03157158.davem@redhat.com>
To: paulus@samba.org
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: drivers/block/rd.c compile error
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15781.7200.98489.515226@nanango.paulus.ozlabs.org>
References: <15781.7200.98489.515226@nanango.paulus.ozlabs.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Paul Mackerras <paulus@samba.org>
   Date: Thu, 10 Oct 2002 16:20:16 +1000 (EST)
   
   What was the change trying to achieve?  What was wrong with
   flush_dcache_page(page)?

The wrong page was being passed to flush_dcache_page().  'page'
is not what is being written to with kernel cpu stores.

The real problem is that Alan stuck the raw 2.4.x version of
the fix into 2.5, it compiled on x86 because the argument
doesn't get evaluated, so we just need to fix it up :-)

And as Andrew stated, there are many other problems with the
ramdisk driver in 2.5.x
