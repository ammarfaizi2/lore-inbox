Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBJVam>; Sat, 10 Feb 2001 16:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129027AbRBJVad>; Sat, 10 Feb 2001 16:30:33 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:25353 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129026AbRBJVaY>;
	Sat, 10 Feb 2001 16:30:24 -0500
Message-ID: <3A85B2C9.56F7221D@mandrakesoft.com>
Date: Sat, 10 Feb 2001 16:29:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Leete <tleete@mountain.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon-SMP compiles & runs. inline fns honored.
In-Reply-To: <3A8554FA.AB33BE05@mountain.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Leete wrote:
> 
> Hi Alan
> 
> I found one way to break the circularity. The association of type and struct
> definitions with interlocking inline functions caused the problem. This
> extracts task_struct from linux/sched.h to its own header,
> linux/task_struct.h. There are a few modifications elsewhere to support
> this. I'm not sure all the changes were necessary, but they are working as I
> write:
[long patch snipped]

Ouch.  What about un-inlining in_interrupt() for all SMP cases?  Reduces
code size just a bit, and function calls aren't very expensive on SMP
machines IMHO...  (and as a side effect solves this problem...)

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
