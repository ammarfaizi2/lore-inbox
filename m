Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbTBXK66>; Mon, 24 Feb 2003 05:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266443AbTBXK65>; Mon, 24 Feb 2003 05:58:57 -0500
Received: from packet.digeo.com ([12.110.80.53]:57007 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266434AbTBXK65>;
	Mon, 24 Feb 2003 05:58:57 -0500
Date: Mon, 24 Feb 2003 03:09:16 -0800
From: Andrew Morton <akpm@digeo.com>
To: James Harper <james.harper@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH to fix irq sharing and SA_INTERRUPT on x86. please review
Message-Id: <20030224030916.632dd876.akpm@digeo.com>
In-Reply-To: <3E59F611.3020206@bigpond.com>
References: <3E59F611.3020206@bigpond.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Feb 2003 11:09:03.0162 (UTC) FILETIME=[23AA29A0:01C2DBF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Harper <james.harper@bigpond.com> wrote:
>
> further to my email yesterday (to which i've had no response :) i 
> propose the attached patch to arch/i386/kernel/irq.c. it corrects what i 
> see as a bug in interrupt handling.
> 
> currently if a driver requests SA_INTERRUPT in an interrupt handler, it 
> is only called with interrupts disabled if it is the first handler in 
> the list.

ewww..

> my patch modifies setup_irq to put any interrupt with SA_INTERRUPT in 
> the front of the handler queue (eg before any handlers without the flag).
> 
> and also modifies handle_IRQ_event to only enable interrupts when it 
> hits the first handler with SA_INTERRUPT not set.
> 

Yes, that's a nice fix, thanks.

Other architectures appear to have inherited this bug.
