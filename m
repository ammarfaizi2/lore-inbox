Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVATC6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVATC6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 21:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVATC6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 21:58:15 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:57524 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261953AbVATC5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 21:57:04 -0500
Message-ID: <41EF1DFB.6090103@yahoo.co.uk>
Date: Thu, 20 Jan 2005 02:56:59 +0000
From: Paul Marrons <pmarrons@yahoo.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mj@ucw.cz, linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: Backport of pci cardbus number enumeration from 2.6 to 2.4.29
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

To overcome a problem with my laptop cardbus not being assigned the 
correct bus number in 2.4.29 (I originally did this change for 2.4.27) I 
backported a portion of the code in the 2.6 kernel drivers/pci/pci.c 
file. I did this because I noticed that only 2.6 assigned the correct 
bus number and I specifically need to run 2.4.X because of a driver I 
need that is not 2.6 compatible. Basically without this change on my 
laptop (Thinkpad 240) both the main PCI bus and cardbus bridge both get 
assigned bus#0 and as a result any cardbus devices present are not 
correctly detected and allocated any resources, in addition the 
/proc/bus/pci contains two '0' entries and tools such as lspci fail to 
work.

I am aware of people overcoming this problem (with my model of laptop) 
by setting defining pcibios_assign_all_busses() as 1. But this backport 
is a superior solution to the problem.

The few small changes are isolated to pci_add_new_bus and 
pci_scan_bridge. I hope you will be able to incorporate them into the 
next 2.4 kernel release.

If there is anything else I need to do please let me know.

Regards,

Paul Marrons.

