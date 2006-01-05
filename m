Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWAEBsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWAEBsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWAEBsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:48:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751138AbWAEBsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:48:24 -0500
Date: Wed, 4 Jan 2006 17:48:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: jeff shia <tshxiayu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what is the state of current after an mm_fault occurs?
Message-Id: <20060104174808.7b882af8.akpm@osdl.org>
In-Reply-To: <7cd5d4b40601040240n79b2d654t33424e91059988a9@mail.gmail.com>
References: <7cd5d4b40601040240n79b2d654t33424e91059988a9@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeff shia <tshxiayu@gmail.com> wrote:
>
>        In my opinion, the state of current should be TASK_RUNNING
>  after an mm_fault occurs.But I donot know why the function of
>  handle_mm_fault() set the state of current TASK_RUNNING.

It was a long time ago.. 2.4.early, perhaps.

There was a place (maybe in the select() code) where we were doing
copy_*_user() while in state TASK_INTERRUPTIBLE.  And iirc there was a
place in the pagefault code which did schedule().  So we would occasionally
hit schedule() in state TASK_INTERRUPTIBLE, when we expected to be in state
TASK_RUNNING.

So we made handle_mm_fault() set TASK_RUNNING to prevent any further such
things.

