Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWDRMzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWDRMzO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 08:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWDRMzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 08:55:14 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:20622 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750737AbWDRMzN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 08:55:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KlQ/rGmCFOiw74fgTZ7YzinwKTcLuQXRYKFjJ5KdqIvGrp/TkwkeIpFEw6MEMcZ2uBfMy3YoXkpVfkn5orh7u3qtd6dUTS+oIZSVslHvZPfRoAIHUCDtYvcAgI7INYjT5cl7xAT//7KOJOhoYjrZ4m4OzFLP67J/qD4/1iYWIuI=
Message-ID: <bf3792800604180555n6569a355tc55e850064ea1551@mail.gmail.com>
Date: Tue, 18 Apr 2006 20:55:12 +0800
From: "Liu haixiang" <liu.haixiang@gmail.com>
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Subject: Re: Question on Schedule and Preemption
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060418091724.GA7258@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bf3792800604180023r2a2111b4ude5ef15f9dd855a@mail.gmail.com>
	 <20060418091724.GA7258@rhlx01.fht-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas Mohr,

Thanks for your explanation. And now I am clear on above code.

Please see my problem below. It seemed that there is one code to add
preempt count [<8440de20>], which means that the kernel can not be
preemptied. Then the code call switch_to (which contains the code
__switch_to_end).

And it's problem becuase the code already in the atomic status and can
not be scheduled.

My understanding is correct? And how to know which process or code
call add_preempt_count? Is there any good way to find the clue?

===================================
scheduling while atomic: TUNER0/0x04000001/611

Call trace:
[<846532b4>] __switch_to_end+0x2fe/0x38a
[<8440de20>] add_preempt_count+0x0/0xa0
[<84652c80>] schedule+0x0/0x300
[<8440dd80>] sub_preempt_count+0x0/0xa0
[<84653ef8>] cond_resched+0x38/0x80
[<84405096>] ret_from_irq+0x0/0x12
[<845145e0>] __delay+0x0/0x20
[<84653ef8>] cond_resched+0x38/0x80
[<8440de20>] add_preempt_count+0x0/0xa0
[<84652c80>] schedule+0x0/0x300
[<8440dd80>] sub_preempt_count+0x0/0xa0
[<845d9a16>] bit_xfer+0x256/0x8c0
[<845d6d36>] i2c_transfer+0x56/0xe0
[<c042382e>] STI2C_Read+0x2e/0x80 [sti2c_ioctl]
[<c046af32>] I2C_ReadWrite+0x72/0x1a0 [sttuner_core]
[<c0487d7c>] IOARCH_Handle+0x10/0xffff49a0 [sttuner_core]
[<84653ec0>] cond_resched+0x0/0x80
[<845d9cac>] bit_xfer+0x4ec/0x8c0
[<c046b398>] IOARCH_ReadWrite+0x118/0x180 [sttuner_core]
[<c05cb000>] 0xc05cb000
[<c046b456>] STTUNER_IOARCH_ReadWrite+0x16/0x40 [sttuner_core]
[<c05c300c>] 0xc05c300c
[<c0477482>] STTUNER_IOREG_GetContigousRegisters+0x142/0x1c0 [sttuner_core]
[<c046fd1a>] Drv0299_GetNoiseEstimator+0x1a/0x120 [sttuner_core]
[<c04835f0>] STTUNER_DrvInst+0x0/0xffff911c [sttuner_core]
[<c0483798>] STTUNER_DrvInst+0x1a8/0xffff911c [sttuner_core]
[<c048379c>] STTUNER_DrvInst+0x1ac/0xffff911c [sttuner_core]
[<c048379c>] STTUNER_DrvInst+0x1ac/0xffff911c [sttuner_core]
[<c05c300c>] 0xc05c300c
[<c05c3000>] 0xc05c3000
[<c0470960>] demod_d0299_GetSignalQuality+0x20/0x40 [sttuner_core]
[<c048379c>] STTUNER_DrvInst+0x1ac/0xffff911c [sttuner_core]
[<c0483798>] STTUNER_DrvInst+0x1a8/0xffff911c [sttuner_core]
[<c05c3000>] 0xc05c3000
[<c046c826>] SATTASK_GetTunerInfo+0x46/0xe0 [sttuner_core]
[<c04835f0>] STTUNER_DrvInst+0x0/0xffff911c [sttuner_core]
[<c04837ac>] STTUNER_DrvInst+0x1bc/0xffff911c [sttuner_core]
[<c046c9fa>] SATTASK_ProcessTracking+0x13a/0x1c0 [sttuner_core]
[<c04835f0>] STTUNER_DrvInst+0x0/0xffff911c [sttuner_core]
[<c04835f0>] STTUNER_DrvInst+0x0/0xffff911c [sttuner_core]
[<c046d388>] SATTASK_ScanTask+0x3e8/0x620 [sttuner_core]
[<c046ca80>] SATTASK_ProcessScanExact+0x0/0x340 [sttuner_core]
[<c0483800>] STTUNER_DrvInst+0x210/0xffff911c [sttuner_core]
[<c04835f0>] STTUNER_DrvInst+0x0/0xffff911c [sttuner_core]
[<c048482c>] STTUNER_DrvInst+0x123c/0xffff911c [sttuner_core]
[<c048492c>] STTUNER_DrvInst+0x133c/0xffff911c [sttuner_core]
[<c04835f0>] STTUNER_DrvInst+0x0/0xffff911c [sttuner_core]
[<c04836ec>] STTUNER_DrvInst+0xfc/0xffff911c [sttuner_core]
[<c04836ec>] STTUNER_DrvInst+0xfc/0xffff911c [sttuner_core]
[<c04848ec>] STTUNER_DrvInst+0x12fc/0xffff911c [sttuner_core]
[<c04848ec>] STTUNER_DrvInst+0x12fc/0xffff911c [sttuner_core]
[<c048492c>] STTUNER_DrvInst+0x133c/0xffff911c [sttuner_core]
[<8442b4e4>] kthread+0xe4/0x140
[<c046cfa0>] SATTASK_ScanTask+0x0/0x620 [sttuner_core]
[<c0483800>] STTUNER_DrvInst+0x210/0xffff911c [sttuner_core]
[<8440f4a0>] complete+0x0/0xc0
[<8442b3e0>] kthread_should_stop+0x0/0x20
[<84403004>] kernel_thread_helper+0x4/0x20
