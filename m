Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLAN0O>; Fri, 1 Dec 2000 08:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLAN0E>; Fri, 1 Dec 2000 08:26:04 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:12553 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129183AbQLANZ4>; Fri, 1 Dec 2000 08:25:56 -0500
Message-ID: <3A279FBD.60EC5ADB@Hell.WH8.TU-Dresden.De>
Date: Fri, 01 Dec 2000 13:55:25 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Andrey Savochkin <saw@saw.sw.com.sg>
CC: linux-kernel@vger.kernel.org
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <20001117172336.B27444@saw.sw.com.sg> <3A269F47.17336A69@Hell.WH8.TU-Dresden.De> <20001201175109.A4209@saw.sw.com.sg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin wrote:
> 
> > eth0: card reports no RX buffers.
> > eth0: card reports no resources.

> It's a known issue.
> I've been promised that this issue would be looked up in Intel's errata by
> people who had the access to it, but I haven't got the results yet.

I just figured out something interesting. Apparently there's a small timing
problem with setting up the NIC: If I put in a sleep 1 between setting up
the interface and setting up the gateway route, everything works pretty well.

So things now look like this:

/sbin/ifconfig lo 127.0.0.1
/sbin/route add -net 127.0.0.0 netmask 255.0.0.0 lo
 
/sbin/ifconfig eth0   a.b.c.d broadcast x.y.225.255    netmask 255.255.255.0
/sbin/ifconfig eth0:0 a.b.c.d broadcast 172.16.255.255 netmask 255.255.0.0
 
sleep 1 # This does the trick
 
/sbin/route add default gw a.b.c.d netmask 0.0.0.0 metric 1 


> The card itself doesn't report its revision in details.
> It can be checked by `lspci'.
> Rev 8 is 82559, if I remember, and rev 9 is 82559ER.

http://support.intel.com/support/network/adapter/pro100/21397.htm
has a list of Board-Assembly IDs and the corresponding chip revisions.

Regards,
Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
