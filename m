Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264933AbRGNWMR>; Sat, 14 Jul 2001 18:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264937AbRGNWMI>; Sat, 14 Jul 2001 18:12:08 -0400
Received: from james.kalifornia.com ([208.179.59.2]:6185 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S264933AbRGNWLz>; Sat, 14 Jul 2001 18:11:55 -0400
Message-ID: <3B50C391.3050804@blue-labs.org>
Date: Sat, 14 Jul 2001 18:11:29 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010713
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ross Biro <bir7@leland.stanford.edu>
Subject: [found-not fixed] Re: 2.4.5+ hangs on boot
In-Reply-To: <3B50AE0D.80002@blue-labs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, the problem is this.  I have TEQL packet scheduling in my config, 
the kernel runs through this sequence on boot:

net_dev_init()
    pktsched_init()
        teql_init()    [starts a lock with rtnl_lock()]
            register_netdevice()
                net_dev_init()
                    pktsched_init()
                        teql_init() [hangs here...]

Here is the problem.  We enter teql_init() again with a rtnl_lock() 
already being held.  Do any of the authors of these functions want to 
jump in here?

David

David Ford wrote:

> [...]
> I2O LAN OSM (C) 1999 University of Helsinki.
> early initialization of device teql0 is deferred
> loop: loaded (max 8 devices)
> Linux Tulip driver version 0.9.15-pre3 (June 1, 2001)
> PCI: Found IRQ 5 for device 00:10.0
>
> Any comments or suggestions?  2.4.5-ac19 is the last kernel I have 
> that works.



