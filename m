Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276759AbRJPV7R>; Tue, 16 Oct 2001 17:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276763AbRJPV7A>; Tue, 16 Oct 2001 17:59:00 -0400
Received: from zero.aec.at ([195.3.98.22]:55052 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S276759AbRJPV6i>;
	Tue, 16 Oct 2001 17:58:38 -0400
To: oliver.kowalke@t-online.de
cc: linux-kernel@vger.kernel.org
Subject: Re: close() sends an RST
In-Reply-To: <1003222233.3bcbf4d957274@webmail.t-online.de>
From: Andi Kleen <ak@muc.de>
Date: 16 Oct 2001 23:59:09 +0200
In-Reply-To: oliver.kowalke@t-online.de's message of "Tue, 16 Oct 2001 10:57:29 +0200 (MEST)"
Message-ID: <k2r8s3i6vm.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1003222233.3bcbf4d957274@webmail.t-online.de>,
oliver.kowalke@t-online.de writes:
> Hi,
> I've following programmed: an tcp-server waits on select() for readable 
> and writeable socket-handles. The client writes something to the server 
> and reads its response and then calls close() for its connected socket. 
> On the server site select() returns and indicates the socket as 
> readable. The function read() returns with error ECONNRESET which 
> indicates an RST send from the client. Because the client terminated as 
> excpected (write()->read()->close()) I assume close() has send an RST 
> instead of an FIN?! Is this correct or what happend? 

close will send an RST if there is still unread data on the local side.
This is to signal the other end that there has been data lost.
You probably need to fix your server to read all data upto eof.

-Andi

p.s.: this is kind of a FAQ; it's probably already documented somewhere.
