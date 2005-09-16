Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161081AbVIPM7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbVIPM7c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 08:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbVIPM7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 08:59:32 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:5381 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1161081AbVIPM7b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 08:59:31 -0400
To: fawadlateef@gmail.com
Cc: ivan.korzakow@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: best way to access device driver functions
References: <a5986103050915004846d05841@mail.gmail.com>
	<1e62d137050915010361d10139@mail.gmail.com>
	<a598610305091505184a8aa8fd@mail.gmail.com>
	<1e62d13705091508391832f897@mail.gmail.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: if it payed rent for disk space, you'd be rich.
Date: Fri, 16 Sep 2005 13:59:22 +0100
In-Reply-To: <1e62d13705091508391832f897@mail.gmail.com> (Fawad Lateef's
 message of "15 Sep 2005 16:39:51 +0100")
Message-ID: <87mzmduq1h.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Sep 2005, Fawad Lateef stated:
> On 9/15/05, Ivan Korzakow <ivan.korzakow@gmail.com> wrote:
>> Could you explain me why ioctl should be avoided ? Is it going to be
>> deprecated in future kernel ?
> 
> No ioctl are not deprecated, but they are just avoided b/c its not
> good to mess kernel with new system-calls as there is a different way
> for that !!!!

Well, not really; ioctl() is only one system call. They're actually
avoided because ioctl() has a horrible non-typesafe non-transparent
interface. (Quick! What parameters does the CCISS_PASSTHRU32 ioctl()
expect?)

sysfs fixes all of these problems, and adds easy scriptability
and interrogation from the command-line and a nice hierarchy
as well.


New *system calls* are generally avoided (especially if they might be
useful to non-privileged code) because they come with a *very* high
backward compatibility burden: it's pretty much the case that syscalls
that normal programs rely on should never go away. (Syscalls used only
by programs that you expect to change with the kernel, like modutils/
module-init-tools, are a special case.)

-- 
`One cannot, after all, be expected to read every single word
 of a book whose author one wishes to insult.' --- Richard Dawkins
