Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265179AbTLIL7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 06:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265483AbTLIL7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 06:59:31 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:21131 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S265179AbTLIL73 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 06:59:29 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: const versus __attribute__((const))
Date: Tue, 9 Dec 2003 12:56:47 +0100
User-Agent: KMail/1.5.3
Cc: Jamie Lokier <jamie@shareable.org>, Nikita Danilov <Nikita@Namesys.COM>,
       linux-kernel@vger.kernel.org
References: <200312081646.42191.arnd@arndb.de> <Pine.LNX.4.58.0312082321470.18255@home.osdl.org> <3FD57C77.4000403@zytor.com>
In-Reply-To: <3FD57C77.4000403@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200312091256.47414.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 December 2003 08:40, H. Peter Anvin wrote:
> Well, I get no warning from the following code, with gcc 3.2.2 and -W
> -Wall:
>
> int foo(int x)
> {
>    int y, z, w;
>
>    asm("movl %1,%0" : "=r" (y) : "r" (x));
>    asm("movl %1,%0" : "=r" (z) : "m" (y+1));
>    asm("movl %1,%0" : "=r" (w) : "m" (33));
>
>    return z+w;
> }

For reference, both gcc-3.3 and gcc-3.4 (snapshot) give produce the same assembly 
as gcc-3.2 for your code, but give this warning:

test.c:6: warning: use of memory input without lvalue in asm operand 1 is deprecated
test.c:7: warning: use of memory input without lvalue in asm operand 1 is deprecated

	Arnd <><

