Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132148AbRCVSth>; Thu, 22 Mar 2001 13:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132150AbRCVSt1>; Thu, 22 Mar 2001 13:49:27 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:22925 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S132148AbRCVStV>; Thu, 22 Mar 2001 13:49:21 -0500
Message-ID: <3ABA4833.C169783@mvista.com>
Date: Thu, 22 Mar 2001 10:45:07 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Parity Error <bootup@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: current->need_reshed, can it be a global flag ?
In-Reply-To: <E14g4XZ-0009hb-00@f5.mail.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parity Error wrote:
> 
> instead of need_reshed being a per-task flag, could it be
> as a global flag ?, since every time current->need_reshed
> is checked, schedule() is just called to pick another
> process.
> 
> ---
But for which cpu?  Really this is a short cut to provide a per cpu area
that I think works very well, thank you.

Putting it in a real cpu data area would make access slower.  The
"current" pointer is either very quickly computed or pre loaded in a
register (depends on the platform) so it is about as fast as it can get
as it is.

Also, the flag is often checked by selective preemption code in the
kernel.  Even more often by the full preemption patch.

Nuf said
George
