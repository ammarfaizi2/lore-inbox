Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVEZSSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVEZSSl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 14:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVEZSSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 14:18:41 -0400
Received: from palrel12.hp.com ([156.153.255.237]:52415 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261681AbVEZSSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 14:18:24 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17046.4833.536323.191838@napali.hpl.hp.com>
Date: Thu, 26 May 2005 11:18:09 -0700
To: Rusty Lynch <rusty.lynch@intel.com>
Cc: akpm@osdl.org, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch] Kprobes ia64 qp fix
In-Reply-To: <200505261751.j4QHpjei009076@linux.jf.intel.com>
References: <200505261751.j4QHpjei009076@linux.jf.intel.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 26 May 2005 10:51:45 -0700, Rusty Lynch <rusty.lynch@intel.com> said:

  Rusty> The following patch is for the 2.6.12-rc5-mm1 + my previous
  Rusty> "Kprobes ia64 cleanup" patch that fixes a bug where a kprobe still 
  Rusty> fires when the instruction is predicated off.  So given the p6=0, 
  Rusty> and we have an instruction like:

  Rusty> (p6) move loc1=0

  Rusty> we should not be triggering the kprobe.  This is handled by
  Rusty> carrying over the qp section of the original instruction into
  Rusty> the break instruction.

What about:

	(p6) cmp.eq.unc p9,p10=rX,rY

would the code handle that right?  Similary, you may want to check for
the correct handling of instructions that cannot be predicated (such
as "cover").

	--david
