Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272628AbTHEKNS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 06:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272625AbTHEKNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 06:13:18 -0400
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:32265 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S272611AbTHEKNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 06:13:14 -0400
Posted-Date: Tue, 5 Aug 2003 05:13:01 -0500
Message-ID: <3F2F84D2.8000202@nospam.com>
Date: Tue, 05 Aug 2003 05:20:02 -0500
From: wb <dead_email@nospam.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Paul Blazejowski <paulb@blazebox.homeip.net>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Patrick Mansfield <patmans@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Badness in device_release at drivers/base/core.c:84
References: <20030801182207.GA3759@blazebox.homeip.net>	    <20030801144455.450d8e52.akpm@osdl.org>	    <20030803015510.GB4696@blazebox.homeip.net>	    <20030802190737.3c41d4d8.akpm@osdl.org>	    <20030803214755.GA1010@blazebox.homeip.net>	    <20030803145211.29eb5e7c.akpm@osdl.org>	    <20030803222313.GA1090@blazebox.homeip.net>	    <20030803223115.GA1132@blazebox.homeip.net>	    <20030804093035.A24860@beaverton.ibm.com>    <1060021614.889.6.camel@blaze.homeip.net>    <1352160000.1060025773@aslan.btc.adaptec.com> <5793.199.181.174.146.1060050091.squirrel@www.blazebox.homeip.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Aug 2003 10:13:12.0998 (UTC) FILETIME=[2DBB3460:01C35B3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I'll look into serial console and try to set it up.Do i need extra
> hardware or cables to run serial console? any poniters or setup
> suggestions would be welcome as i never used serial consoles before.
> Regards,
> 
> Paul
> -

  Your need a NULL modem serial cable available
  from any computer store.

Install uucp - I use on the HOST :

uucp-1.06.1-33.7.2.

Also , LILO is broken on some machines and ignores
serial input so make sure you use at least

lilo-21.6-71

On the TARGET

1. Connect the serial ports together ( COM1->COM1 ) with
    the serial cable .

2. Modify LILO to use serial line on the TARGET
    add to lilo.conf:
       append="console=ttyS0,9600n8  console=tty0 "
       serial=0,9600N8

    Run lilo

3. Add to /etc/inittab on the HOST

       S0:s12345:respawn:/sbin/agetty 9600 ttyS0

4. To see ALL THE CONSOLE MESSAGES during boot on the TARGET

    mv /dev/console /dev/console.org
    ln  /dev/ttyS0 /dev/console

5. Start uucp on the HOST:

     cu -l /dev/ttyS0 -s 9600

6. Boot your target

///

John Donnelly AT HP DOT com














