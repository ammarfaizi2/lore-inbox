Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293057AbSB0XdD>; Wed, 27 Feb 2002 18:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293055AbSB0XcQ>; Wed, 27 Feb 2002 18:32:16 -0500
Received: from r198m97.cybercable.tm.fr ([195.132.198.97]:4612 "EHLO lsinitam")
	by vger.kernel.org with ESMTP id <S292965AbSB0XbV> convert rfc822-to-8bit;
	Wed, 27 Feb 2002 18:31:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Laurent <laurent@augias.org>
To: Val Henson <val@nmt.edu>, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: read_proc issue
Date: Thu, 28 Feb 2002 00:32:34 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16fmE1-0000Mu-00@lsinitam> <Pine.LNX.4.33L2.0202271122040.1463-100000@dragon.pdx.osdl.net> <20020227140432.L20918@boardwalk>
In-Reply-To: <20020227140432.L20918@boardwalk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16gDYp-0000FG-00@lsinitam>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've encountered this problem before, too.  What is the "One True Way"
> to do this cleanly?  In other words, if you want to do a calculation
> once every time someone runs "cat /proc/foo", what is the cleanest way
> to do that?  The solution we came up with was to check the file offset
> and only do the calculation if offset == 0, which seems pretty
> hackish.

I've tried it and... it works ! :)
Many many thanks :)

In the meantime, I've also followed Tommy Reynolds' advice to not modify 
global state variables within read_procmem. I've intercepted a syscall which 
does the calculation (I've used the open syscall since it allowed me to 
increase the counter by just running vi on any file ;) ) and put it into a 
buffer which is dumped when the /proc entry is read. Works great that way too.
By the way, as the final module will intercept syscalls like open, creat, 
close, link, unlink, mkdir, etc. , I'm wondering if there'll be a dramatic 
negative impact on file operations performance. Is there any efficient method 
to measure this ?
In any case, thanks for all the help you gave me :)

Regards, 
Laurent Sinitambirivoutin
laurent@augias.org
