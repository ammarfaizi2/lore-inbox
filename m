Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317716AbSGKCSH>; Wed, 10 Jul 2002 22:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317717AbSGKCSG>; Wed, 10 Jul 2002 22:18:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56729 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317716AbSGKCSG>;
	Wed, 10 Jul 2002 22:18:06 -0400
Date: Wed, 10 Jul 2002 19:12:12 -0700 (PDT)
Message-Id: <20020710.191212.08323174.davem@redhat.com>
To: matti.aarnio@zmailer.org
Cc: hurwitz@lanl.gov, linux-kernel@vger.kernel.org
Subject: Re: How many copies to get from NIC RX to user read()?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020710112916.R28720@mea-ext.zmailer.org>
References: <Pine.LNX.4.44.0207091625460.2905-100000@alvie-mail.lanl.gov>
	<20020710112916.R28720@mea-ext.zmailer.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matti Aarnio <matti.aarnio@zmailer.org>
   Date: Wed, 10 Jul 2002 11:29:16 +0300

     I suspect that in many cases there is third copy right in the network
     card driver to realign data so that TCP frame begins at a 32-bit boundary.
     Perhaps that is only for RISC CPU systems (e.g. Alpha, primarily.)
   
     Can the GigE cards do ethernet-frame reception pre-alignment so that
     after the 14 byte ethernet header, the TCP frame begins at 32-bit 
     boundary ?

All gigabit chips allow to start the receive DMA buffer on a 2-byte
aligned boundary.  The exception is the ns83820.  Andi Kleen had some
ideas of how to deal with even the ns83820 type chips without copying
anything more than the headers (ie. not the data portion).
