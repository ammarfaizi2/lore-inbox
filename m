Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130878AbRAOUe0>; Mon, 15 Jan 2001 15:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131229AbRAOUeF>; Mon, 15 Jan 2001 15:34:05 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:30212 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130878AbRAOUeB>;
	Mon, 15 Jan 2001 15:34:01 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101152033.f0FKXpv250839@saturn.cs.uml.edu>
Subject: Re: Is sendfile all that sexy?
To: mingo@elte.hu
Date: Mon, 15 Jan 2001 15:33:51 -0500 (EST)
Cc: jthackray@zeus.com (Jonathan Thackray),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <Pine.LNX.4.30.0101152035090.5713-100000@elte.hu> from "Ingo Molnar" at Jan 15, 2001 08:41:01 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
> On Mon, 15 Jan 2001, Jonathan Thackray wrote:

>> It's a very useful system call and makes file serving much more
>> scalable, and I'm glad that most Un*xes now have support for it
>> (Linux, FreeBSD, HP-UX, AIX, Tru64). The next cool feature to add to
>> Linux is sendpath(), which does the open() before the sendfile() all
>> combined into one system call.

Ingo Molnar's data in a nice table:

open/close  7.5756 microseconds
stat        5.4864 microseconds
write       0.9614 microseconds
read        1.1420 microseconds
syscall     0.6349 microseconds

Rather than combining open() with sendfile(), it could be combined
with stat(). Since the syscall would be new anyway, it could skip
the normal requirement about returning the next free file descriptor
in favor of returning whatever can be most quickly found.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
