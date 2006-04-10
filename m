Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWDJXyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWDJXyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWDJXyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:54:38 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:26505 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S932196AbWDJXyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:54:37 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] de_thread: Don't confuse users do_each_thread.
Date: Tue, 11 Apr 2006 01:52:37 +0200
User-Agent: KMail/1.9.1
References: <20060406220403.GA205@oleg> <m1y7yddo75.fsf_-_@ebiederm.dsl.xmission.com> <m1u091dnry.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1u091dnry.fsf@ebiederm.dsl.xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604110152.38861.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Tuesday, 11. April 2006 01:16, you wrote:
> I can't seem to send out a correct patch out today with out
> sending it twice.  I accidently grabbed my old version
> that sent to many arguments to detach_pid and so would not
> compile.  Oops.

While you are at it: Could you please avoid calculating current over 
and over again? 

Just calculate it once and use the task_struct pointer.

If I do this for some random occurances of "current" in fs/exec.c I get this
on Linus' latest git tree:

   text    data     bss     dec     hex filename
   9501      84      12    9597    257d old/fs/exec.o
   9386      84      12    9482    250a new/fs/exec.o

Do you see any side effects, except reduced size 
and increased performance here?

Is a patch doing this for the whole file welcome, if you are too busy?


Regards

Ingo Oeser
