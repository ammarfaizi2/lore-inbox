Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264638AbSIQVxV>; Tue, 17 Sep 2002 17:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264640AbSIQVxV>; Tue, 17 Sep 2002 17:53:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54403 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264638AbSIQVxU>;
	Tue, 17 Sep 2002 17:53:20 -0400
Date: Tue, 17 Sep 2002 14:49:11 -0700 (PDT)
Message-Id: <20020917.144911.43656989.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: akpm@digeo.com, manfred@colorfullife.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Info: NAPI performance at "low" loads
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D87A4A2.6050403@mandrakesoft.com>
References: <3D87A264.8D5F3AD2@digeo.com>
	<20020917.143947.07361352.davem@redhat.com>
	<3D87A4A2.6050403@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Tue, 17 Sep 2002 17:54:42 -0400

   David S. Miller wrote:
   > Any driver should be able to get the NAPI overhead to max out at
   > 2 PIOs per packet.
   
   Just to pick nits... my example went from 2 or 3 IOs [depending on the 
   presence/absence of a work loop] to 6 IOs.
   
I mean "2 extra PIOs" not "2 total PIOs".

I think it's doable for just about every driver, even tg3 with it's
weird semaphore scheme takes 2 extra PIOs worst case with NAPI.

The semaphore I have to ACK anyways at hw IRQ time anyways, and since
I keep a software copy of the IRQ masking register, mask and unmask
are each one PIO.
