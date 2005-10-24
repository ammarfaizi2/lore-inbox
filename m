Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVJXHqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVJXHqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 03:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVJXHqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 03:46:08 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:57517 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750745AbVJXHqH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 03:46:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=om4UchmYWUAV7M8yuwnJPWGws3IeiPPyjcAcE1xmoM5hRcl77JY2EMUK/9hCKwcjscxk41rDxf4Nnq28SFOZOQpg9lilpxSb3XfdO/zca/0IyUA+5UyFFmY6s0JtyF1l+8c7fvnvX6oqearzYYMOHeSJtl8bjpxyVSQUWLH4pM8=
Message-ID: <d4f1333a0510240046s18021c3exe61ad783ddff0778@mail.gmail.com>
Date: Mon, 24 Oct 2005 02:46:07 -0500
From: "Travis H." <solinym@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: terminal handling: collecting inter-keystroke timings
In-Reply-To: <d4f1333a0510232356v1778fb10s186af3979aa323db@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d4f1333a0510232356v1778fb10s186af3979aa323db@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Supposing I was interested in collecting inter-keystroke timings on
Unix for the purposes of biometric authentication, what would be a
clean way of doing so?

Would I have to hack up the terminal code, add some data structures,
some ioctls to query and reset them, etc. or is there some more elegant way
of going about it?  Perhaps I could write something that sits between
the terminal driver and the process which normally receives user input
first, and pipes it to that process instead of letting it inherit a fd
to the tty?

I'd like to be able to do it with (ttys attached to?) network sockets
as well, so that I could test out the applicability of it to remote
users.

Ideally any mechanism would be flexible enough that I could have it
deliver me timings between key-down, key-up-to-key-down, or up/down to
up/down timings.  And it should be efficient enough that it can
deliver most of them unprocessed to some userland collector daemon
which does the filtering of outliers and whatnot.

A secondary use of this would be to characterize/quantify the amount
of entropy available from keystroke timings, given that they are
quantized and enqueued (in hardware) several times on their way to the
kernel.

Since I'm on the subject, a related project I had in mind would be
hacking the keyboard to do its raster-scan in a pseudo-random order
that was synchronized with the terminal driver such that the signal on
the wire was, if not encrypted, at least scrambled enough to be
difficult to convert back into plaintext.  What would this involve on
the kernel side?

Any thoughts on the matter would be much appreciated.  I apologize in
advance if these questions convey an ignorance of terminal handling,
or if the right answer is "do it in userspace"; I couldn't immediately
think of a transparent way of doing so (and scheduling delays could
impact the timings in very significant ways).
--
http://www.lightconsulting.com/~travis/  -><-
"We already have enough fast, insecure systems." -- Schneier & Ferguson
GPG fingerprint: 50A1 15C5 A9DE 23B9 ED98 C93E 38E9 204A 94C2 641B
