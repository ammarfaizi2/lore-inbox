Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274895AbRIVM0m>; Sat, 22 Sep 2001 08:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274896AbRIVM0c>; Sat, 22 Sep 2001 08:26:32 -0400
Received: from colorfullife.com ([216.156.138.34]:28425 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S274895AbRIVM0T>;
	Sat, 22 Sep 2001 08:26:19 -0400
Message-ID: <3BAC8385.BFA35D19@colorfullife.com>
Date: Sat, 22 Sep 2001 14:26:45 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Christian Vogel <chris@obelix.hedonism.cx>
CC: linux-kernel@vger.kernel.org
Subject: [Newbie] Interrupt Handling and sleep/wake_up 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> void bdDoSomething(){
>         setup_buffers_for_interrupt_routing();
>         tell_board_to_start_reading_or_writing();
>         /***** BOARD THROWS ITS INTERRUPTS HERE!!! *****/
>         interruptible_sleep_on_timeout(&irq_wqueue,PCIIA_SLEEP_TIMEOUT);
> }
> 
Just do not use sleep_on, use wait_event or a manual wait loop.

check the mouse driver sample from Alan Cox:
	linux/Documentation/DocBook/mousedriver.tmpl

The document is slightly outdated:

* do not access current->state directly, use set_current_state.
* do not use MOD_INC_USE_COUNT, set module->owner to THIS_MODULE
instead.

--
	Manfred
