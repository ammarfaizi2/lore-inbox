Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757275AbWKWJb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757275AbWKWJb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757279AbWKWJb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:31:58 -0500
Received: from smtp-out.google.com ([216.239.33.17]:50915 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1757275AbWKWJb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:31:57 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=DZS8y/wvhEEss0ctf1teB4Rhn5875suYAT1I/gar9jmqcDksquEUUpoPPqLroG9hc
	VfuJMEGNPIV2c9S06GdgQ==
Message-ID: <6599ad830611230131w1bf63dc1m1998b55b61579509@mail.gmail.com>
Date: Thu, 23 Nov 2006 01:31:47 -0800
From: "Paul Menage" <menage@google.com>
To: "Pavel Emelianov" <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH 4/13] BC: context handling
Cc: "Kirill Korotaev" <dev@sw.ru>, "Andrew Morton" <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       matthltc@us.ibm.com, hch@infradead.org,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, oleg@tv-sign.ru,
       devel@openvz.org
In-Reply-To: <456567DD.6090703@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45535C18.4040000@sw.ru> <45535E11.20207@sw.ru>
	 <6599ad830611222348o1203357tea64fff91edca4f3@mail.gmail.com>
	 <45655D3E.5020702@openvz.org>
	 <6599ad830611230053m7182698cu897abe5d19471aff@mail.gmail.com>
	 <456567DD.6090703@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/06, Pavel Emelianov <xemul@openvz.org> wrote:
> You mean moving is like this:
>
> old_bc = task->real_bc;
> task->real_bc = new_bc;
> cmpxchg(&tsk->exec_bc, old_bc, new_bc);
>
> ? Then this won't work:
>
> Initialisation:
> current->exec_bc = init_bc;
> current->real_bc = init_bc;
> ...
> IRQ:
> current->exec_bc = init_bc;
> ...
>                              old_bc = tsk->real_bc; /* init_bc */
>                              tsk->real_bc = bc1;
>                              cx(tsk->exec_bc, init_bc, bc1); /* ok */
> ...
> Here at the middle of an interrupt
> we have bc1 set as exec_bc on task
> which IS wrong!

You could get round that by having a separate "irq_bc" that's never
valid for a task not in an interrupt.

Paul
