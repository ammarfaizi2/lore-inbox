Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318230AbSHIKdn>; Fri, 9 Aug 2002 06:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318231AbSHIKdn>; Fri, 9 Aug 2002 06:33:43 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:1192 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S318230AbSHIKdn>;
	Fri, 9 Aug 2002 06:33:43 -0400
Date: Fri, 9 Aug 2002 12:37:25 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
Message-ID: <20020809103725.GA1017@win.tue.nl>
References: <200208090704.g7974Td55043@saturn.cs.uml.edu> <3D5381F7.1BCE0118@aitel.hist.no> <1028889153.28883.186.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028889153.28883.186.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 11:32:33AM +0100, Alan Cox wrote:

> Its much simpler to put max_pid into /proc/sys/kernel. That way we can
> boot with 32000 process ids, which will ensure ancient stuff which has
> 16bit pid_t (old old libc) and also any old kernel interfaces which
> expose it - does ipc ? 

I don't think it is a good idea to add lots of almost meaningless knobs.
This is not something one would like to adapt dynamically.
Someone who needs 16bit pid_t can compile her own kernel with a
suitable value of PID_MAX.

There is no old old libc with 16bit pid_t, I think.
I have libc 4.4.1 here with
	typedef int pid_t;
I have Linux 0.01 here with
	typedef int pid_t;

Yes, ipc exposed pid in a 16-bit field, namely in the fields
msg_lspid, msg_lrpid, shm_cpid, shm_lpid.
Two years ago I found all occurrences in all Linux sources,
but I forgot the details of the result; I do not recall
significant occurrences. Maybe someone will repeat this big grep.

Andries
