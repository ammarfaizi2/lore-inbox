Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTGKQxe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264447AbTGKQxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:53:34 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18616
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264398AbTGKQx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:53:29 -0400
Subject: Sound updating, security of strlcpy and a question on pci v unload
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057943137.20637.27.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 18:05:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm currently updating the prehistoric OSS audio code in 2.5 to include
all the new 2.4 drivers and 2.4 work. While some of them overlap ALSA
drivers others are not in ALSA yet either.

Firstly someone turned half the kernel into using strlcpy. Every single
change I looked at bar two in the sound layer introduced a security
hole. It looks like whoever did it just fired up a perl macro without
realising the strncpy properties matter for data copied to user space.
Looks like the rest wants auditing

Secondly a question. pci_driver structures seem to lack an owner: field.
What stops a 2.5 module unload occuring while pci is calling the probe
function having seen a new device ? 


-- 
Alan Cox <alan@lxorguk.ukuu.org.uk>
