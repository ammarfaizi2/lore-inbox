Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284793AbRLDAU5>; Mon, 3 Dec 2001 19:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284563AbRLDARF>; Mon, 3 Dec 2001 19:17:05 -0500
Received: from egghead.curl.com ([216.230.83.4]:54538 "HELO egghead.curl.com")
	by vger.kernel.org with SMTP id <S285280AbRLCWgW>;
	Mon, 3 Dec 2001 17:36:22 -0500
To: linux-kernel@vger.kernel.org
Subject: ETIMEDOUT for connect() to local machine?
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 03 Dec 2001 17:36:20 -0500
Message-ID: <s5g667oj5i3.fsf@egghead.curl.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is with stock 2.2.19.

We are having a strange problem.  We run complex builds and tests
under Xvfb (a virtual X server) to avoid cluttering a real screen with
windows.  On two of our systems, a call to XOpenDisplay() occasionally
fails with Xlib printing this message to stderr:

    _X11TransSocketINETConnect: Can't connect: errno = 110

As you might guess, Xlib prints this message when its call to
connect() returns -1.

What makes this so strange is that errno 110 is ETIMEDOUT.  But these
connection attempts are to a socket on the *local* machine.  I am
certain about this because we include the DISPLAY in the debugging
logs.

It strikes me as odd for a connect() to the local machine to time out,
as opposed to being simply refused (errno 111).

I figured perhaps the machine was being flooded with connections,
exceeding the SYN backlog.  So I enabled SYN cookies on both of the
offending systems and watched the syslog.  But SYN cookies are never
being sent, even when this problem bites us, so I do not think that is
the problem.

Maybe we have bad hardware?  I doubt that, since this is happening on
two systems, both of which have otherwise been completely reliable.
The two systems also happen to be the only Dell PowerEdge 2550s
(ServerWorks HE chipset) in our pool of thirty or so machines.  So if
it is a hardware problem, it occurs in a whole line of systems.

It seems plausible to me that this is a subtle timing-related kernel
bug...

Anyway, I have two questions.

  1) When SYN cookies are enabled, how could a connect() to a local IP
     address ever result in ETIMEDOUT?  Is there anything that
     usermode programs could do to make this happen, or is it
     definitely a problem with the kernel and/or the hardware?

  2) What might I do to debug this further?  The problem is hard to
     reproduce, but it does hit our automated builds about once a
     week.

Thanks in advance for any ideas.

 - Pat
