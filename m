Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129073AbQKCGm5>; Fri, 3 Nov 2000 01:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129129AbQKCGms>; Fri, 3 Nov 2000 01:42:48 -0500
Received: from hermes.mixx.net ([212.84.196.2]:31760 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129073AbQKCGmh>;
	Fri, 3 Nov 2000 01:42:37 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Date: Fri, 03 Nov 2000 07:42:26 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-3A025E52.440DF378@innominate.de>
In-Reply-To: <Pine.LNX.4.21.0010312231490.15159-100000@elte.hu> <39FF3F0B.81A1EE13@timpanogas.org> <20001031230538.A9048@gruyere.muc.suse.de> <39FF465F.4EEB811A@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 973233746 5394 10.0.0.90 (3 Nov 2000 06:42:26 GMT)
X-Complaints-To: news@innominate.de
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test8 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> A "context" is usually assued to be a "stack".  The simplest of all
> context switches is:
> 
>    mov    x, esp
>    mov    esp, y

Is that your two instruction context switch?  The problem is, it doesn't
transfer control anywhere.  Maybe it doesn't need to.  I guess you could
break your tasks up into lots of little chunks and compile each chunk
inline and use actual calls to take you off the fast path.  The stack
changes are actually doing some useful work here: you might for instance
be processing a network packet whose address is on the stack.  But
somehow I don't think this is your two-instruction context switch.  The
only halfway flexible two-instruction context switch I can think of is:

    mov esp, y
    ret

where you already know the stack depth where you are so you don't have
to store it, and the task execution order is predetermined.  This
switches the *two* essential ingredients of a context: control+data. 
But there's a big fat AGI there and all the overhead of a jump so it
doesn't get your superscalar performance.

Now my stupid question: why on earth do you need a billion context
switches a second?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
