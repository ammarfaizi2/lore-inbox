Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWGaJBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWGaJBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 05:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWGaJBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 05:01:09 -0400
Received: from ns.suse.de ([195.135.220.2]:26325 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932110AbWGaJBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 05:01:08 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86_64: fix is_at_popf() for compat tasks
Date: Mon, 31 Jul 2006 10:54:38 +0200
User-Agent: KMail/1.9.3
Cc: Albert Cahalan <acahalan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200607310325_MC3-1-C691-D76B@compuserve.com>
In-Reply-To: <200607310325_MC3-1-C691-D76B@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607311054.38585.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 July 2006 09:22, Chuck Ebbert wrote:
> When testing for the REX instruction prefix, first check
> for a 32-bit task because in compat mode the REX prefix is an
> increment instruction.

is_compat_task doesn't actually say that a task is in compat mode
(it refers to the Linux compat layer, not x86-64 compat mode)

A better test would be regs->cs == __USER32_CS, but in theory
there could be other code segments in LDT. I guess that can 
be ignored though.

-Andi
