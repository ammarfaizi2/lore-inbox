Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129666AbQLWOk1>; Sat, 23 Dec 2000 09:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130076AbQLWOkR>; Sat, 23 Dec 2000 09:40:17 -0500
Received: from colorfullife.com ([216.156.138.34]:21261 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129666AbQLWOkM>;
	Sat, 23 Dec 2000 09:40:12 -0500
Message-ID: <3A44B324.1E1E9AF1@colorfullife.com>
Date: Sat, 23 Dec 2000 15:13:56 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Q: netdevice interface change
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I have 2 questions about your netdevice2.txt:
   http://www.uow.edu.au/~andrewm/linux/netdevice2.txt 

* is withdraw_netdevice() really required, can't unregister_netdev
check "hidden", and notify the protocols/hotplug based on that value?

* I don't like the backward compatibility section:

<<<<<<<<
Other things:

     #define HAVE_PUBLISH_NETDEV

          This is for 2.2-compatible drivers.  They can do this:

          #ifdef HAVE_PUBLISH_NETDEV
          #define init_etherdev prepare_etherdev
          #define publish_netdev(dev) do {} while (0)
          #define withdraw_netdev unregister_netdev
          #endif
>>>>>>>>

As far as I know Linus prefers backward compatibility the other way
around:

<<<<<<
A 2.4 driver that must remain compatible with 2.2 should use
the new interface and add these lines to their source file:

       #ifndef HAVE_PUBLISH_NETDEV
       #define prepare_etherdev init_etherdev
       #define publish_netdev(dev) do {} while (0)
       #define withdraw_netdev unregister_netdev
       #endif
>>>>>>

--
  Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
