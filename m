Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755202AbWKMQVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202AbWKMQVI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755209AbWKMQVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:21:07 -0500
Received: from s1.mailresponder.info ([193.24.237.10]:15375 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S1755202AbWKMQVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:21:06 -0500
Subject: READ SCSI cmd seems to fail on SATA optical devices...
From: Mathieu Fluhr <mfluhr@nero.com>
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Nero AG
Date: Mon, 13 Nov 2006 17:19:36 +0100
Message-Id: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently tried to burn some datas on CDs and DVD using a SATA burner
and the latest 2.6.18.2 kernel... using NeroLINUX. (It is controlling
the device by sending SCSI commands over the 'sg' driver)

The burn process works like a charm, no problems at all. But it seems
that there are some slight problems with the READ scsi cmd:
Inside our software, we have a verification routine that will make a
sector-by-sector verification to check that everything that has been
written is OK.

The problem is that, on SATA devices controlled by libata, on some big
files (like for example a 600 MB file) the READ command seems to fail
and outputs garbage (not 1 or 2 bytes diff, but the whole buffer).
 -> This problem does not come out everytime, and each time on    
    different sectors.

Please note that:
- it is not chipset dependant (tested on nforce4 and sii3114)
- it is not medium or device dependant


I debugged a little bit and found out the following:

- Our software tries to guess the bus type for each device by using
INQUIRY SCSI cmds. For SATA devices, it always returns SCSI. 
(which according to the source code is normal -> libata-scsi.c:2396)

- When I force the bus type to be IDE, our software will then send ATA
commands. In this case, everything works like a charm. No errors at all.
 

I tried to debug a little bit more inside the source code of the Linux
kernel, but I must admit that I am really not so familiar with the
code... but it would be no problem to help anyone on this issue. :)

Best Regards,
Mathieu


-- 
*********************************************************
Mathieu Fluhr
Linux Software Engineer

Nero AG
Im Stoeckmaedle 18
76307 Karlsbad
Germany

E-mail: mfluhr@nero.com

NERO - BECAUSE TECHNOLOGY COUNTS
www.nero.com

*********************************************************
This e-mail may contain confidential and/or
privileged information. If you are not the intended
recipient (or have received this e-mail in error)
please notify the sender immediately and destroy
this e-mail. Any unauthorised copying, disclosure
or distribution of the material in this e-mail is
strictly forbidden.
********************************************************* 

