Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbTGCPP4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 11:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTGCPP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 11:15:56 -0400
Received: from web41111.mail.yahoo.com ([66.218.93.27]:10013 "HELO
	web41111.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264235AbTGCPPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 11:15:55 -0400
Message-ID: <20030703153021.7491.qmail@web41111.mail.yahoo.com>
Date: Thu, 3 Jul 2003 08:30:21 -0700 (PDT)
From: Benjamin Stuhl <tiriath@yahoo.com>
Subject: Re: Yet another SDET hang (73-mm3) ... yawn
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> 2.5.73-mm3 + feral + highpte (ext2)
>
> Seems to be all wedged up on io_schedule. Not sure if it
was
> highpte that caused this or not, but I'd done one run on
ext2
> and one on ext3 without it, and they worked fine. 

I have been wrestling myself with D state hangs (ext3/ 
reiserfs) in 2.5.7X-mmY for a while now, but haven't been 
able to capture a sysrq-T. I have a question, though 
(inspired by the trace you got): who does a finish_wait() 
for a !is_sync_wait() process after
blk_congestion_wait_wq() 
or __wait_on_buffer_wq()? Both of these functions can 
return after a prepare_to_wait() without a matching 
finish_wait(). 

So perhaps you could try backing out the aio-* patches?
Just 
a thought.

Please CC: me; I only read the archives.

-- BKS

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
