Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277670AbRJLNS0>; Fri, 12 Oct 2001 09:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277668AbRJLNSQ>; Fri, 12 Oct 2001 09:18:16 -0400
Received: from fe090.worldonline.dk ([212.54.64.152]:7183 "HELO
	fe090.worldonline.dk") by vger.kernel.org with SMTP
	id <S277670AbRJLNSE>; Fri, 12 Oct 2001 09:18:04 -0400
Message-ID: <3BC6EBFE.2050408@eisenstein.dk>
Date: Fri, 12 Oct 2001 15:11:26 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
Organization: Eisenstein
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16 i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Martin <ecprod@bellsouth.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: IEEE1284 parport code won't build in 2.4.12
In-Reply-To: <3BC6E89A.BA8F98B6@bellsouth.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Steve Martin wrote:

> This has already been passed on to Tim Waugh, but here's
> a heads-up:
> 
> drivers/parport/ieee1284_ops.c  -- invokes an undefined
> enum entry from parport.h  -- as a result the code
> won't build.


I believe that is the problem that Linus posted this fix for (try it out):

--- linux/drivers/parport/ieee1284_ops.c.origThu Oct 11 09:40:39 2001
+++ linux/drivers/parport/ieee1284_ops.cThu Oct 11 09:40:42 2001
@@ -362,7 +362,7 @@
} else {
DPRINTK (KERN_DEBUG "%s: ECP direction: failed to reverse\n",
  port->name);
-port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
}  return retval;
@@ -394,7 +394,7 @@
DPRINTK (KERN_DEBUG
  "%s: ECP direction: failed to switch forward\n",
  port->name);
-port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
}



Regards,
Jesper Juhl

