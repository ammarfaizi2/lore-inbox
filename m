Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317934AbSFSQne>; Wed, 19 Jun 2002 12:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317936AbSFSQnd>; Wed, 19 Jun 2002 12:43:33 -0400
Received: from netfinity.realnet.co.sz ([196.28.7.2]:47543 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317934AbSFSQnc>; Wed, 19 Jun 2002 12:43:32 -0400
Date: Wed, 19 Jun 2002 18:15:25 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Martin Dalecki <dalecki@evision-ventures.com>
Subject: Oops on 2.5.23 and IDE
Message-ID: <Pine.LNX.4.44.0206191810310.1263-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,
	IDE seems to be doing odd things.

>>EIP; c0117318 <schedule+28/4f0>   <=====
Trace; c0117c6a <wait_for_completion+11a/1d0>
Trace; c0117820 <default_wake_function+0/40>
Trace; c0117820 <default_wake_function+0/40>
Trace; c022e1ae <ide_do_drive_cmd+18e/1b0>
Trace; c01bc082 <vsnprintf+2a2/420>
Trace; c022e439 <ide_raw_taskfile+59/60>
Trace; c02302f4 <do_recalibrate+54/70>
Trace; c022e1d0 <special_intr+0/210>
Trace; c0234e75 <ide_dma_intr+115/120>
Trace; c0231138 <ata_irq_request+148/230>
Trace; c0234d60 <ide_dma_intr+0/120>


int ide_do_drive_cmd()
{
[...]
	if (action == ide_wait) {
                wait_for_completion(&wait);     /* wait for it to be serviced */
                return rq->errors ? -EIO : 0;   /* return -EIO if errors */
        }
[...]
}

Was that function really designed to be called from interrupt context?

Cheers,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

