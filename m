Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbTGAGOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 02:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266007AbTGAGON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 02:14:13 -0400
Received: from imf20aec.mail.bellsouth.net ([205.152.59.68]:30886 "EHLO
	imf20aec.bellsouth.net") by vger.kernel.org with ESMTP
	id S266005AbTGAGOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 02:14:08 -0400
Message-ID: <3F010229.4020201@bellsouth.net>
Date: Mon, 30 Jun 2003 23:38:17 -0400
From: CarlosRomero <caberome@bellsouth.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.3) Gecko/20030322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: simple pnp bios io resources bug makes  system unusable
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cat /sys/devices/pnp0/00\:0c/name
Reserved Motherboard Resources

cat /sys/devices/pnp0/00\:0c/resources
state = active
io 0x4d0-0x4d1
io 0xcf8-0xcff
io 0x3f7-0x3f7
io 0x401-0x407
io 0x298-0x298
io 0x00000000-0xffffffff
mem 0xfffe0000-0xffffffff
mem 0x100000-0x7ffffff

fixup: check for null io base, other devices are now able to initialize.

static void current_ioresource(struct pnp_resource_table * res, int io, 
int len)
{
        int i = 0;
 
+      if (!io) return;
        while ((res->port_resource[i].flags & IORESOURCE_IO) && i < 
PNP_MAX_PORT) i++;
        if (i < PNP_MAX_PORT) {
                res->port_resource[i].start = (unsigned long) io;
                res->port_resource[i].end = (unsigned long)(io + len - 1);
                res->port_resource[i].flags = IORESOURCE_IO;  // Also 
clears _UNSET flag
        }
}



