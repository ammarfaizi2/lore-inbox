Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWEMLTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWEMLTY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 07:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWEMLTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 07:19:24 -0400
Received: from [4.21.254.118] ([4.21.254.118]:3288 "EHLO suzuka.mcnaught.org")
	by vger.kernel.org with ESMTP id S932355AbWEMLTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 07:19:23 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mark Rosenstand <mark@borkware.net>, linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
References: <20060513103841.B6683146AF@hunin.borkware.net>
	<1147517786.3217.0.camel@laptopd505.fenrus.org>
	<20060513110324.10A38146AF@hunin.borkware.net>
	<1147518432.3217.2.camel@laptopd505.fenrus.org>
From: Douglas McNaught <doug@mcnaught.org>
Date: Sat, 13 May 2006 07:19:21 -0400
In-Reply-To: <1147518432.3217.2.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Sat, 13 May 2006 13:07:12 +0200")
Message-ID: <87r72yi346.fsf@suzuka.mcnaught.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Sat, 2006-05-13 at 13:03 +0200, Mark Rosenstand wrote:

>> bash-3.00$ cat << EOF > test
>> > #!/bin/sh
>> > echo "yay, I'm executing!"
>> > EOF
>> bash-3.00$ chmod 111 test
>> bash-3.00$ ./test
>> /bin/sh: ./test: Permission denied
>
> is your script readable as well? 111 is just weird/odd.

It needs to be readable as well.  What ends up happening is that the
kernel sees the execute bit, looks at the shebang line and then does:

/bin/sh test

Since read permission is off, the shell's open() call fails.  It will
work fine if you use 755 as the permissions.

Every Unix I've ever seen works this way.  It'd be nice to have
unreadable executable scripts, but no one's ever done it.

-Doug
