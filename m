Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313862AbSDIMCe>; Tue, 9 Apr 2002 08:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313863AbSDIMCd>; Tue, 9 Apr 2002 08:02:33 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:59819 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313862AbSDIMCb>; Tue, 9 Apr 2002 08:02:31 -0400
Date: Tue, 9 Apr 2002 13:47:53 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Rob Radez <rob@osinvestor.com>
Cc: Corey Minyard <minyard@acm.org>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Further WatchDog Updates
In-Reply-To: <Pine.LNX.4.33.0204090645240.17511-100000@pita.lan>
Message-ID: <Pine.LNX.4.44.0204091344420.32054-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-/* This returns the status of the WDO signal, inactive high.
- * returns WDO_ENABLED or WDO_DISABLED
- */
-static inline int sc1200wdt_status(void)
+static int sc1200wdt_start(void);
 {
-	unsigned char ret;
+	sc1200wdt_read_data(WDCF, &reg);
+	/* assert WDO when any of the following interrupts are triggered 
too */
+	reg |= (KBC_IRQ | MSE_IRQ | UART1_IRQ | UART2_IRQ);
+	sc1200wdt_write_data(WDCF, reg);
+	/* set the timeout and get the ball rolling */
+	sc1200wdt_write_data(WDTO, timeout);
+}
 
-	sc1200wdt_read_data(WDST, &ret);
-	return (ret & 0x01);		/* bits 1 - 7 are undefined */
+
+static int sc1200wdt_stop(void)
+{
+	sc1200wdt_write_data(WDTO, 0);
 }

Did you forget return values? Or perhaps just redeclare those...
Also i don't quite understand the new status reporting you're doing, mind 
just explaining it to me a bit? The previous code would tell you wether 
the watchdog is enabled/disabled so you can tell wether the timeout period 
has passed.

Regards,
	Zwane

-- 
http://function.linuxpower.ca
		

