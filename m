Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263202AbVFXTK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbVFXTK4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 15:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbVFXTK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 15:10:56 -0400
Received: from palrel12.hp.com ([156.153.255.237]:12491 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263135AbVFXTKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 15:10:40 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17084.23214.237084.224128@napali.hpl.hp.com>
Date: Fri, 24 Jun 2005 12:10:38 -0700
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: davidm@hpl.hp.com, akpm@osdl.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux IA64 <linux-ia64@vger.kernel.org>
Subject: Re: [patch][ia64]Refuse kprobe on ivt code
In-Reply-To: <20050624114545.A4826@unix-os.sc.intel.com>
References: <20050623172832.B26121@unix-os.sc.intel.com>
	<17083.25625.991516.736507@napali.hpl.hp.com>
	<20050624114545.A4826@unix-os.sc.intel.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 24 Jun 2005 11:45:46 -0700, Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> said:

  Anil> On Thu, Jun 23, 2005 at 06:38:33PM -0700, David Mosberger wrote:
  >> Please do the checking based on the .text.ivt section instead (and add
  >> the necessary labels to vmlinux.S and asm-ia64/sections.h).

  Anil> Subject: Refuse kprobe insert on IVT code

  Anil> Not safe to insert kprobes on IVT code.

  Anil> This patch checks to see if the address on which Kprobes is being
  Anil> inserted is  in ivt code and if it is in ivt code then
  Anil> refuse to register kprobe.

  Anil> Take 1: This patch is based on review comments from David Mosberger,
  Anil> now checking based on .text.ivt

  Anil> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

Looks fine, except:

  Anil> +/* Returns non-zero if the addr is in the Interrupt Vector Table */
  Anil> +static inline int in_ivt_functions(unsigned long addr)
  Anil> +{
  Anil> +	extern char __start_ivt_text[], __end_ivt_text[];
		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  Anil> +	return (addr >= (unsigned long)__start_ivt_text
  Anil> +		&& addr < (unsigned long)__end_ivt_text);
  Anil> +}

Surely you meant to use the declaration from sections.h instead?

Thanks,

	--david
