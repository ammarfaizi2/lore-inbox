Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317589AbSGTX6k>; Sat, 20 Jul 2002 19:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317593AbSGTX6k>; Sat, 20 Jul 2002 19:58:40 -0400
Received: from mail.storm.ca ([209.87.239.66]:30601 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S317589AbSGTX6j>;
	Sat, 20 Jul 2002 19:58:39 -0400
Message-ID: <3D39ED09.90F8E1AA@storm.ca>
Date: Sat, 20 Jul 2002 19:06:49 -0400
From: Sandy Harris <pashley@storm.ca>
Organization: Flashman's Dragoons
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: close return value
References: <200207182347.g6INlcl47289@saturn.cs.uml.edu> <s5gsn2fr922.fsf@egghead.curl.com> <015401c22f40$c4471380$da5b903f@starbak.net> <s5gvg7bmu43.fsf@egghead.curl.com> <20020719192524.GY12420@marowsky-bree.de> <20020719193059.GD2718@conectiva.com.br> <000e01c22f5c$dce9c600$da5b903f@starbak.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Malicki wrote:
> 
> It's an issue when it MIGHT be important.  Such as, fprintf to an important
> data file should be checked, fprintf to stderr is usually cool not to check.

That's an application issue. From the kernel point of view, we cannot
tell
which errors matter to the application, so we just return error on any
we
can detect and let the app worry about it.

> People are going on the assumption that ignoring an error to a system call
> will interfere with program operation or corrupt data - which is NOT
> necessarily true.  Sure many people write programs that way.  But it is
> quite often that if something fails, you don't particularly care, and you
> know, with certainty, that it does not materially affect the operation of
> your program.  For instance, should shutdown fail just because it couldn't
> write a message to everyone's console?

Again, that's an application issue; shutdown should succeed no matter
what
files or devices become inaccessible, so it should be written to
continue
despite error codes, likely with a console message about the error.

>From the kernel point of view, the only question is whether to return an
error when it cannot write where it is asked to. Of course it must.

I don't see why anyone is bothering to argue on the kernel list about
what applications should do with error returns. That's not our problem.

All we need to worry about is:

	what errors are possible,
	whether they can be detected
	whether any merit a panic or kernel logging
	what to return to the application in each case

If the kernel gets those right, it has done its part.
