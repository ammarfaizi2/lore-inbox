Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031218AbWK3TMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031218AbWK3TMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 14:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967892AbWK3TMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 14:12:40 -0500
Received: from mtai01.charter.net ([209.225.8.181]:6570 "EHLO
	mtai01.charter.net") by vger.kernel.org with ESMTP id S967891AbWK3TMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 14:12:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17775.11557.674203.172383@smtp.charter.net>
Date: Thu, 30 Nov 2006 14:12:37 -0500
From: "John Stoffel" <john@stoffel.org>
To: "Matt Garman" <matthew.garman@gmail.com>
Cc: "Phillip Susi" <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: What happened to CONFIG_TCP_NAGLE_OFF?
In-Reply-To: <bdd6985b0611300921u1a88f410vdaf9051c220719e1@mail.gmail.com>
References: <bdd6985b0611281405j3e731e3xc7973c0365428663@mail.gmail.com>
	<456DE85F.50806@cfl.rr.com>
	<bdd6985b0611300921u1a88f410vdaf9051c220719e1@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-Chzlrs: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matt" == Matt Garman <matthew.garman@gmail.com> writes:

Matt> On 11/29/06, Phillip Susi <psusi@cfl.rr.com> wrote:
>> > How might I achieve having TCP_NODELAY effectively set for all sockets
>> > (by default)?  Is there a new/different kernel config option, a patch,
>> > a sysctl or proc setting?  Or can I "fake" this behavior by, e.g.
>> > setting a send buffer sufficiently small?
>> 
>> This is a bad idea and breaks api compatibility.  Nagle is very
>> important for sockets being used for things like telnet.  Other
>> applications, like ftp, should already disable nagle themselves.

Matt> I don't want to change the API at all.  I'm using a
Matt> closed-source, 3rd party library.  Using strace, I can see that
Matt> the library does *not* do a setsockopt(...TCP_NODELAY...) on
Matt> opened sockets.  Since I can't change the library, I would like
Matt> to patch and/or configure my kernel so that all TCP/IP sockets
Matt> default to TCP_NODELAY.

Can't you use the LD_PRELOAD trick to force your own custom library to
override the closed library, so that you can change the socket options
to be how you want them?

Wouldn't that be easier, and be less likely to screw up the whole
system?  

You could override the socket() call, so that you just pass through
all the parameters your library sets, and then you just put in your
own setsockopt() call on the socket, and return it as normal to the
library?  Hacky, but should do the trick if you're careful.

John
