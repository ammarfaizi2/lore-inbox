Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288923AbSAFXUJ>; Sun, 6 Jan 2002 18:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288936AbSAFXT7>; Sun, 6 Jan 2002 18:19:59 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:13914 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S288923AbSAFXTp>; Sun, 6 Jan 2002 18:19:45 -0500
Posted-Date: Sun, 6 Jan 2002 23:19:35 GMT
Date: Sun, 6 Jan 2002 23:19:32 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Steve Wright <stevew@cwazy.co.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/kmsg memory usage ?
In-Reply-To: <02010416152401.00607@box.localdomain>
Message-ID: <Pine.LNX.4.21.0201062312380.7333-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve.

> I am hoping someone here can point me towards the right
> documentation / web page.
> 
> I want to find out what happens to kernel messages in /proc/kmsg if
> they are not read.
> 
> Specifically, 
> Are they cleared after a specified amount of time (eg every 24 hours) ?
> Are they cleared when they occupy a maximum size ?
> If they are not read will the memory they occupy grow indefinately ?

Essentially, they are cleared by default, due to the way they are
implemented.

The implementation consists of a ring buffer X bytes in size (the exact
size depends on whic h architecture you're talking about). When the
kernel is booted, the READ and WRITE pointers both point to the very
first byte of the buffer. As messages are written into the buffer, they
are written to the byte the WRITE pointer points to and that pointer is
incremented for each byte written. Likewise with the read pointer, as
bytes are read, it is incremented for each byte.

The way a ring buffer works is that when the last byte in the buffer is
used, the next byte to be used is the first one in the buffer. When the
write pointer catches up with the read pointer, a buffer full condition
is declared, but in the case of the kmsg buffer, this is dealt with by
incrementing the READ pointer to the next NEWLINE character and freeing
up the space in between.

Best wishes from Riley.

