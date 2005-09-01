Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbVIAUZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbVIAUZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbVIAUZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:25:46 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:3694 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030364AbVIAUZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:25:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=mW0bSRswTSbKglLJ/ah415bUxBOMUzlfWLCTHTh+qtb8H4KoLC37txjNrbVmLbnCcNSNibhDT/mEyFIZ8OQSQ5KFXzjPa0xGRJA4cnelKYQl+iO9LazGvepmbqiqZv7OwgbZ+CAfXQpjTZpPskWKTDwHuFPiBYwk0YJNWNQHq+k=
Message-ID: <43177223.8030403@gmail.com>
Date: Fri, 02 Sep 2005 00:26:59 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Serial driver (serial_core.c) status messages should be set to KERN_INFO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


When upgrading to 2.6.13 I've noticed that serial driver reports it 
status with unknown severity, causing the boot-splash to be overridden.


Please consider this modification.


Best Regards,

Alon Bar-Lev.


At drivers/serial/serial_core.c


 static inline void

 uart_report_port(struct uart_driver *drv, struct uart_port *port)
 {
-        printk("%s%d", drv->dev_name, port->line);
+      printk(KERN_INFO + "%s%d", drv->dev_name, port->line);

         printk(" at ");
         switch (port->iotype) {
         case UPIO_PORT:
                 printk("I/O 0x%x", port->iobase);
                 break;
         case UPIO_HUB6:
                 printk("I/O 0x%x offset 0x%x", port->iobase, port->hub6);
                 break;
         case UPIO_MEM:
         case UPIO_MEM32:
                 printk("MMIO 0x%lx", port->mapbase);
                 break;
         }
         printk(" (irq = %d) is a %s\n", port->irq, uart_type(port));
 }

