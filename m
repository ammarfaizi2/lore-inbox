Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUAPLak (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 06:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265399AbUAPLai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 06:30:38 -0500
Received: from erebor.somesite.de ([213.133.110.75]:50650 "EHLO
	erebor.somesite.de") by vger.kernel.org with ESMTP id S265398AbUAPLaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 06:30:35 -0500
Date: Fri, 16 Jan 2004 12:30:32 +0100
From: Florian Hinzmann <f.hinzmann@hamburg.de>
To: linux-kernel@vger.kernel.org
Cc: Gerard Roudier <groudier@free.fr>
Subject: linux2.6.1 - sym53c8xx: wide:0 documented, but not supported?
Message-Id: <20040116123032.32b03e30.f.hinzmann@hamburg.de>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


I do own an SCSI host controller from Dawicontrol 
( http://www.dawicontrol.com/ ). Model name is "DC-2975 U". 

This host controller has a problem wich is covered within
the documentation inside kernel 2.6.1 in the file
"Documentation/scsi/sym53c8xx_2.txt":

> 10.2.9 Max wide
>         wide:1      wide scsi enabled
>         wide:0      wide scsi disabled
>   Some scsi boards use a 875 (ultra wide) and only supply narrow connectors.
>   If you have connected a wide device with a 50 pins to 68 pins cable 
>   converter, any accepted wide negotiation will break further data transfers.
>   In such a case, using "wide:0" in the bootup command will be helpfull. 


The controller works fine with linux 2.4.x when "wide:0" is set. But
it looks like this option is not supported with linux 2.6.x. I do think so
because of two reasons:

1) Setting it seems to have no effect.
2) From looking at the source:
File drivers/scsi/sym53c8xx_2/sym_glue.c defines this:

>static char setup_token[] __initdata =
>         "tags:"         "burst:"
>         "led:"          "diff:"
>         "irqm:"         "buschk:"
>         "hostid:"       "revprob:"
>         "verb:"         "debug:"
>         "settle:"       "nvram:"
>         "excl:"         "safe:"
>         ;

"wide:0" is missing.  I am not good with C and I might be wrong here. 
But reason no. 1 remains true still.


Can anyone confirm if my controller is not supported by linux2.6.x?
If yes, does anyone know if there is a patch or some other help 
available? Is anyone working on this?


  Regards
     Florian


-- 
  Florian Hinzmann                         private: f.hinzmann@hamburg.de
                                            Debian: fh@debian.org
PGP Key / ID: 1024D/B4071A65
Fingerprint : F9AB 00C1 3E3A 8125 DD3F  DF1C DF79 A374 B407 1A65
