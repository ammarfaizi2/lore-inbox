Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281307AbRKLH7o>; Mon, 12 Nov 2001 02:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281308AbRKLH7f>; Mon, 12 Nov 2001 02:59:35 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38543 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281307AbRKLH7V>;
	Mon, 12 Nov 2001 02:59:21 -0500
Date: Sun, 11 Nov 2001 23:59:05 -0800 (PST)
Message-Id: <20011111.235905.28785376.davem@redhat.com>
To: mathijs@knoware.nl
Cc: andrea@suse.de, jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] fix loop with disabled tasklets
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.BSI.4.05L.10111120819290.9564-100000@utopia.knoware.nl>
In-Reply-To: <20011112021142.O1381@athlon.random>
	<Pine.BSI.4.05L.10111120819290.9564-100000@utopia.knoware.nl>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mathijs Mohlmann <mathijs@knoware.nl>
   Date: Mon, 12 Nov 2001 08:42:27 +0100 (CET)
   
   Even if the timer irq is working fine, the sun should not enable the 
   keyboard irq without the tasklet being enabled. Initializing the keyboard
   tasklet enabled got the sun to boot just fine for me.

They come from the serial port, not from a normal "IRQ".
This is why events arrive so early.

Linus's proposed solution will work just fine and frankly
that's what I'm going to check into my tree. :-)  For
reference this is:

1) Kill DECLARE_TASKLET_DISABLED use DECLARE_TASKLET for
   keyboard_tasklet. 

2) In keyboard tasklet handler check a "keyboard_init_done"
   boolean and just return immediately if it is clear.

3) Where we currently do "tasklet_enable(&keyboard_tasklet);"
   simply kill that line and check it to
   "keyboard_init_done = 1;"

Franks a lot,
David S. Miller
davem@redhat.com
