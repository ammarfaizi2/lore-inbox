Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318216AbSHWF6j>; Fri, 23 Aug 2002 01:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318356AbSHWF6j>; Fri, 23 Aug 2002 01:58:39 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:4550 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S318216AbSHWF6h>;
	Fri, 23 Aug 2002 01:58:37 -0400
Message-ID: <3D65D000.60004@candelatech.com>
Date: Thu, 22 Aug 2002 23:02:40 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: spin_unlock hang, and IRC question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

First, anyone know why I get this when trying to log onto #kernel IRC
channel?

  greear sets mode +i greear
--- You have been killed by mid.eu.linuxnet.org (Username))
--- Closing Link: dhcp101-dsl-usw4.w-link.net greear (Killed by mid.eu.linuxnet.org (Bad Username))
--- Disconnected (Remote host closed socket).


Now, for the real question:  I'm making pktgen threaded.  It works great on
a single processor (compiled for single processor).  But, it hangs quickly
when used on an SMP (Athlon 2Ghz-equiv) machine.

I put in print statements (I would love to hear other ideas for how to debug)
and it seems that the system hangs trying to unlock a spin lock.  Specifically,
I see the first printout, but not the second:


inline static void pg_unlock(struct pktgen_thread_info* pg_thread, char* msg) {
         if (debug > 1) {
                 printk("before pg_unlock thread, thread: %x  msg: %s\n",
                        pg_thread, msg);
         }
         spin_unlock(&(pg_thread->pg_threadlock));
         if (debug > 1) {
                 printk("after pg_unlock thread, thread: %x  msg: %s\n",
                        pg_thread, msg);
         }
}


Any ideas for how to go about debugging this will be greatly appreciated!

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


