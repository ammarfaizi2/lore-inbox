Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263524AbTKKOLd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 09:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTKKOLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 09:11:33 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:6870 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263524AbTKKOL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 09:11:28 -0500
Message-ID: <3FB0EE0E.6090103@softhome.net>
Date: Tue, 11 Nov 2003 15:11:26 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
References: <Qvw7.5Qf.9@gated-at.bofh.it> <QH4e.eV.3@gated-at.bofh.it>
In-Reply-To: <QH4e.eV.3@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> On Mon, Nov 10, 2003 at 08:05:11PM -0500, Albert Cahalan wrote:
> 
> 	long copy_fd_to_fd (int src, int dst, int len)
> 
> The kernel then becomes something
> 
> 	if (islocalfile (src) && issocket (dst)) 
> 		/* Call the old sendfile */ 
> 		return sendfile (....);
> 
> 	if (isCIFS (src), isCIFS(dst))
> 		/* Tell remote host to copy the file. */
> 		return CIFS_copy_file (....); 
> 

   B.S.

> 
> But alas, last time Linus didn't agree with me and decided we should
> do something like "sendfile", which is IMHO just a special case of
> this one.
> 

   I will reply on behalf of Linus: "Send patch!"

   I beleive you are not developer - so you even cannot estimate what 
you are proposing.

   This kind of patch will never be accepted.

   Just try to imagine: 20 file systems, so 20*20 == 400 ifs?

   So I beleive you will get more more positive responses, If you will 
start improveing vfs, e.g. adding generic routines for optimized move of 
file from one file system to another, with API which allow it to 
extrapolate nicely to networked file systems.
   Since right now there is no way to pass file from one fs to another - 
so basicly this thread is already, well, over ;-)

> 
> If we implement this in kernel (at first just the copy_fd_fd and the
> default implementation), then we can get "cp" to use this, and then
> suddenly whenever we upgrade the kernel, cp can use the newly
> optimized copying mechanism. (e.g. whenever we manage to specify a
> socket as the destination, cp would suddenly start to use
> "sendfile"!!)
> 

    Silly. cp is least frequent application I use.
    And cvs I beleive already uses sendfile().
    So all your /arguments/ go directly into /dev/null, since if file is 
not in cvs - you know - it just doesn't exist ;-)))

> 
> 		Roger. 
> 


-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|

