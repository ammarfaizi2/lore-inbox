Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285032AbRLFHc1>; Thu, 6 Dec 2001 02:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285033AbRLFHcR>; Thu, 6 Dec 2001 02:32:17 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:51668 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S285032AbRLFHcG>; Thu, 6 Dec 2001 02:32:06 -0500
Message-ID: <3C0F1F32.C235F9CC@kegel.com>
Date: Wed, 05 Dec 2001 23:33:06 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Carlo Wood <carlo@alinoe.com>
Subject: re: kqueue, kevent - kernel event notification mechanism
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlo Wood <carlo@alinoe.com> wrote:
> are there any plans to implement the kqueue, kevent system calls
> in the linux kernel?
> 
> There is no substitute for them currently; select() and poll()
> both suffer from dramatic cpu usage when a daemon is loaded with
> a few thousand clients.

There is already an efficient mechanism - although with a very
different interface - in the 2.4.x kernel: edge triggered readiness
notification via realtime signals.  This matches one style of
kqueue()/kevent() usage.  For those who prefer level-triggered
readiness notification (more like what poll() gives you),
I have written a wrapper class that papers over the difference
efficiently, at the cost of making the app tell my class about
all the EWOULDBLOCKs it gets.
See http://www.kegel.com/c10k.html#nb.sigio for details.
I don't particularly like signals for this, as they're a
bit heavyweight, and the global signal queue is a bit precious,
but it does benchmark well, even for thousands of clients.

(That page also describes kqueue etc. and the experimental
/dev/poll drivers.)
- Dan
