Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275053AbTHGBAY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 21:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275054AbTHGBAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 21:00:24 -0400
Received: from ns.suse.de ([213.95.15.193]:11268 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S275053AbTHGBAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 21:00:20 -0400
To: Dave Jones <davej@redhat.com>
Cc: richard.brunner@amd.com, linux-kernel@vger.kernel.org, kwijibo@zianet.com
Subject: Re: Machine check expection panic
References: <3F3182B5.3040301@zianet.com.suse.lists.linux.kernel>
	<20030807002722.GA3579@suse.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Aug 2003 03:00:14 +0200
In-Reply-To: <20030807002722.GA3579@suse.de.suse.lists.linux.kernel>
Message-ID: <p73ekzynuxt.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:
> #
> diff -Nru a/arch/i386/kernel/cpu/mcheck/k7.c b/arch/i386/kernel/cpu/mcheck/k7.c
> --- a/arch/i386/kernel/cpu/mcheck/k7.c	Wed Aug  6 23:33:40 2003
> +++ b/arch/i386/kernel/cpu/mcheck/k7.c	Wed Aug  6 23:33:40 2003
> @@ -81,7 +81,7 @@
>  		wrmsr (MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
>  	nr_mce_banks = l & 0xff;
>  
> -	for (i=0; i<nr_mce_banks; i++) {
> +	for (i=1; i<nr_mce_banks; i++) {

The change looks rather suspicious to me.

Bank 0 is the data cache unit (DC)

Do you have an errata that says that the DC bank is bad on all Athlons?

Normally BIOS or microcode are supposed to turn off bad MCEs by 
masking them in another register. Maybe the person's CPU has a 
real problem that is just masked now, e.g. it could be overclocked
and stress the cache too much.

The original MCE was:

Status: (4) Machine Check in progress.
Restart IP invalid.
parsebank(0): f606200000000833 @ 4040
        External tag parity error
        Uncorrectable ECC error
        CPU state corrupt. Restart not possible
        Address in addr register valid
        Error enabled in control register
        Error not corrected.
        Error overflow
        Bus and interconnect error
        Participation: Local processor originated request
        Timeout: Request did not timeout
        Request: Generic error
        Transaction type : Instruction
        Memory/IO : Other

Tyan 2466 motherboard
2 Athon MP 1200 processors  (1200?) 

-Andi
