Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266004AbUFIV7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUFIV7b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 17:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266008AbUFIV7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 17:59:31 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:8648 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S266004AbUFIV71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 17:59:27 -0400
Date: Wed, 09 Jun 2004 16:58:36 -0500
From: Fernando Paredes <Fernando.Paredes@Sun.COM>
Subject: Re: Toshiba keyboard lockups
In-reply-to: <200405121149.37334.rjwysocki@sisk.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <40C7880C.4000401@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-2; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040130
References: <40A162BA.90407@sun.com> <200405121149.37334.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case anyone's interested...

Applied these patches. Nothing while tail'ing /var/log/messages. Nothing 
in the root console that I can see either.

Patched the source to 2.6.6. Still get the same lockups, totally random.

Any more ideas?

- Fernando

R. J. Wysocki wrote:

>On Wednesday 12 of May 2004 01:33, Fernando Paredes wrote:
>  
>
>>There was a previous thread on this, last month.
>>
>>I updated to 2.6.6 and I still get these random lockups. Nothing in
>>dmesg or /var/log/messages. Too annoying as I have to reboot the machine
>>constantly. Does anyone know the status on this? Is t a toshiba hardware
>>bug (is that possible?) or a bug in serio.c or keybd.c?
>>    
>>
>
>It's most probably Toshiba-related, because it does not happen on other 
>hardware, it seems.
>
>I've got a simple patch from Grzegorz Kulewski to help trace the problem, but 
>I haven't got a lockup since.  The patch is as follows:
>
>--- /usr/src/linux-2.6.5/drivers/input/serio/serio.c.orig	2004-04-04 
>05:36:15.000000000 +0200
>+++ /usr/src/linux-2.6.5/drivers/input/serio/serio.c	2004-04-09 
>18:28:50.268521936 +0200
>@@ -166,6 +166,11 @@ static int serio_thread(void *nothing)
> static void serio_queue_event(struct serio *serio, int event_type)
> {
> 	struct serio_event *event;
>+	
>+	if (event_type == SERIO_RESCAN || event_type == SERIO_RECONNECT) {
>+		printk(KERN_WARNING "serio: RESCAN || RECONNECT requested: %d!\n", 
>event_type);
>+		dump_stack();
>+	}
> 
> 	if ((event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
> 		event->type = event_type;
>
>Please try to apply it and you should get something in the logs when a lockup 
>occurs (ie. kernel warning + call trace).
>
>RJW
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

-- 

<http://www.sun.com/software>                      <http://java.sun.com>
*Fernando Paredes
Identity & Collaboration
Sun Microsystems de México
Prol. Reforma #600-110, Col. Santa Fe, México D.F. 01210
Tel Dir: 52 + (55) 5258 6152
Fax: 52 + (55) 5258 6199*

