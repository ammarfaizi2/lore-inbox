Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbUFFFZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUFFFZN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 01:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUFFFZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 01:25:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:2504 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262902AbUFFFZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 01:25:08 -0400
Date: Sun, 6 Jun 2004 07:26:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mike McCormack <mike@codeweavers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040606052615.GA14988@elte.hu>
References: <40C2B51C.9030203@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C2B51C.9030203@codeweavers.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike McCormack <mike@codeweavers.com> wrote:

> Fedore Code 1's exec-shield patch broke Wine badly, as there was no
> way for an application to turn it off from user space, and Wine
> depended upon certain areas of virtual memory being free.

there are multiple methods in FC1 to turn this off:

- FC1 has PT_GNU_STACK support and all binaries that have no
  PT_GNU_STACK program header will have the stock Linux VM layout. 
  (including executable stack/heap) So by stripping the PT_GNU_STACK 
  header from the wine binary you get this effect.

- you get the same effect by setting the personality to PER_LINUX32 via:

	personality(PER_LINUX32);

  this is a NOP on stock x86 Linux, and turns off exec-shield on FC1.

all these methods were present in FC1 from day 1 on. In fact we
specifically targetted Wine (and similar applications) with these
methods to make it easy for them to be built under FC1. (of course
existing binaries of Wine worked and work fine because they dont have
PT_GNU_STACK.)

> We developed a hack to work around this problem by creating a staticly
> linked binary to reserve memory then load ld-linux.so.2 and a
> dynamically executable into memory manually and run start them.

while this should work too - why not one of the methods above?

	Ingo
