Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbUKVHwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbUKVHwc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 02:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUKVHwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 02:52:31 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:4604
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S261970AbUKVHw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 02:52:29 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problem
Date: Mon, 22 Nov 2004 07:52:28 +0000
User-Agent: KMail/1.7.1
Cc: Jens Axboe <axboe@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk> <200411211025.11629.alan@chandlerfamily.org.uk> <200411211613.54713.alan@chandlerfamily.org.uk>
In-Reply-To: <200411211613.54713.alan@chandlerfamily.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411220752.28264.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 November 2004 16:13, Alan Chandler wrote:
...
>
> This seems to be some combination of frequently occuring timing problem,
> and the difference treatment in cdrom_newpc_intr to cdrom_pc_intr

I put a ndelay(400) at the head of cdrom_newpc_intr and the problem of DRQ 
being set when there was no data to transfer disappeared.  It appears that my 
hardware is too slow.

I have been reading the ATA/ATAPI - 6 spec, and it implies that the state of 
DRQ line need one pio cycle before being correct and that you should read the 
alternative status register to achieve this.  I tried a simple

HWIF(drive)->INB( IDE_ALTSTATUS_REG);

But that made no difference.



-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
