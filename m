Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbUCaRAf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 12:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbUCaRAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 12:00:35 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:52232 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262088AbUCaRA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 12:00:26 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: ulrich.windl@rz.uni-regensburg.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 on Itanium2: floating-point assist fault at ip 400000000062ada1, isr 0000020000000008
Date: Wed, 31 Mar 2004 19:00:17 +0200
User-Agent: KMail/1.5.4
References: <406AE0D5.10359.1930261@localhost>
In-Reply-To: <406AE0D5.10359.1930261@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403311900.17293.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 March 2004 15:16, Ulrich Windl wrote:
> Hello,
>
> I did try to find an answer is SuSE's support database, not in SAP's
> support database, and also did search Google, but could not find an answer:
>
> We run SuSE Linux Enterprise Server 8 (SLES8) on a HP rx4640 Itanium2
> server with 2 CPUs (family: Itanium 2, model: 1, revision: 5, archrev: 0).
>
> In syslog is do see periodic kernel messages (with no implicit priority)
> that read:
>
> dw.sapC11_DVS02(14393): floating-point assist fault at ip 400000000062ada1,
> isr 0000020000000008
>
> ("dw.sapC11_DVS02" is a SAP R/3 work process (46D_EXT, patch 1754, for
> those who care)
>
> Can anybody explain what this message means? Is it an application problem,
> or is it a kernel problem?

        static int fpu_swa_count = 0;
        static unsigned long last_time;
...
        if (jiffies - last_time > 5*HZ)
                fpu_swa_count = 0;
        if ((fpu_swa_count < 4) && !(current->thread.flags & IA64_THREAD_FPEMU_NOPRINT)) {
                last_time = jiffies;
                ++fpu_swa_count;
                printk(KERN_WARNING "%s(%d): floating-point assist fault at ip %016lx, isr %016lx\n",
                       current->comm, current->pid, regs->cr_iip + ia64_psr(regs)->ri, isr);
        }

kernel says that you have them too frequently, which probably
impairs efficiency. It's a hint to programmer.
--
vda

