Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129980AbRBSLzI>; Mon, 19 Feb 2001 06:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129384AbRBSLy7>; Mon, 19 Feb 2001 06:54:59 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:39435 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129170AbRBSLyt>;
	Mon, 19 Feb 2001 06:54:49 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: prumpf@mandrakesoft.com (Philipp Rumpf), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac15 
In-Reply-To: Your message of "Mon, 19 Feb 2001 11:35:08 -0000."
             <E14Uob0-0003Cs-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 19 Feb 2001 22:54:39 +1100
Message-ID: <30069.982583679@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001 11:35:08 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>The problem isnt running module code. What happens in this case
>
>        mod->next = module_list;
>        module_list = mod;      /* link it in */
>
>Note no write barrier.

<humour>It works on ix86 so the code must be right</humour>

>Delete is even worse
>
>We unlink the module
>We free the memory
>
>At the same time another cpu may be walking the exception table that we free.

Another good reason why locking modules via use counts from external
code is not the right fix.  We definitely need a quiesce model for
module removal.

