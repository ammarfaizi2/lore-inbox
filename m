Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUGLBA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUGLBA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 21:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUGLBA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 21:00:28 -0400
Received: from smtp808.mail.ukl.yahoo.com ([217.12.12.198]:12176 "HELO
	smtp808.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266679AbUGLBA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 21:00:26 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
To: sboyce@blueyonder.co.uk
Subject: Re: 2.6.x Scheduler, preemption and responsiveness - puzzlement
Date: Mon, 12 Jul 2004 02:00:32 +0100
User-Agent: KMail/1.6.82
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
References: <40F1BA46.9000207@blueyonder.co.uk> <20040711221818.GA30704@outpost.ds9a.nl> <40F1C568.2070503@blueyonder.co.uk>
In-Reply-To: <40F1C568.2070503@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407120200.32938.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 July 2004 23:55, Sid Boyce wrote:
[snip]
>
> I've been wondering why this is, I can't remember what the BIOS says
> about the hard drives, from memory it looked OK, I think it was set to
> AUTO, haven't tried LBA.
> # hdparm -d1 /dev/hda
>
> /dev/hda:
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  using_dma    =  0 (off)
> # hdparm -d1 /dev/hdc
>
> /dev/hdc:
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  using_dma    =  0 (off)
>

Your BIOS geometry settings are irrelevant. You've just forgotten to enable 
the correct busmaster DMA driver in your kernel. It looks as though this is 
an nForce 2 system, so you need to enable "Generic PCI bus-master DMA 
support", then further down "AMD and nVidia IDE support", in menuconfig. 
You'll then be able to set DMA on, and this will likely resolve the 
performance issue.

In .config, the relevant options are

CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AMD74XX=y

Hope this helps!

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
