Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264017AbRFEPMG>; Tue, 5 Jun 2001 11:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264016AbRFEPLq>; Tue, 5 Jun 2001 11:11:46 -0400
Received: from [64.64.109.142] ([64.64.109.142]:43270 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S264012AbRFEPLp>; Tue, 5 Jun 2001 11:11:45 -0400
Message-ID: <3B1CF68A.65AB5108@didntduck.org>
Date: Tue, 05 Jun 2001 11:11:06 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Bjorn Wesen <bjorn@sparta.lu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: meaning of vmalloc shortcut comment in fault.c
In-Reply-To: <Pine.LNX.3.96.1010605145320.9033B-100000@medusa.sparta.lu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Wesen wrote:
> 
> Can someone elaborate on why it's bad to refer to tsk directly below (this
> is a 2.4.5 change in x86) and why it's needed on x86 and not other archs..
> 
> What should I do for an arch that does not have a "cr3" machine register
> to check with ?

%cr3 is the page table pointer on the x86.  Changing the page table
pointer and changing the stack pointer (from which tsk is derived) is
not done atomically during a task switch.  If an interrupt happens in
between and causes a page fault on a vmalloced area, using tsk may refer
to the wrong page tables.  %cr3 by definition always has the current
page table pointer.

--

				Brian Gerst
