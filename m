Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbTIKXJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 19:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbTIKXJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 19:09:44 -0400
Received: from zero.aec.at ([193.170.194.10]:14343 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261597AbTIKXJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 19:09:42 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Breno <brenosp@brasilsec.com.br>, Stan Bubrouski <stan@ccs.neu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: Size of Tasks during ddos
From: Andi Kleen <ak@muc.de>
Date: Fri, 12 Sep 2003 01:08:49 +0200
In-Reply-To: <uHuj.7yv.9@gated-at.bofh.it> (Alan Cox's message of "Thu, 11
 Sep 2003 23:50:11 +0200")
Message-ID: <m3r82mkjni.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <um6w.4VI.5@gated-at.bofh.it> <unFh.7rt.7@gated-at.bofh.it>
	<upe3.1uM.3@gated-at.bofh.it> <uyU4.7Sz.9@gated-at.bofh.it>
	<uACA.2fO.3@gated-at.bofh.it> <uDTR.7A2.35@gated-at.bofh.it>
	<uEGe.uJ.21@gated-at.bofh.it> <uHb2.76X.15@gated-at.bofh.it>
	<uHb6.76X.29@gated-at.bofh.it> <uHkC.7kf.7@gated-at.bofh.it>
	<uHuj.7yv.9@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Syn cookies accept the SYN frame and encode sufficient information into
> the reply that they can avoid storing any data until the next packet
> arrives from the other end completing the connection.
>
> That means squashing all the information we track (mss, window, etc)
> into very few bits. A modern TCP will offer large windows, selective ack
> and other features which we can't fit into a syn cookie so with this off
> a burst of traffic will cause pauses while the socket queue clears and
> negotiate fully featured TCP,  with syncookies enabled many of the
> connections on the burst will not have the extra features so many not
> perform as well.

Another side effect of syncookies is that flow control for new
connections breaks: when you have a client that is connecting to a
overloaded server it will only notice this after a long timeout. With
syncookies off you get actually useful errnos back on connect().

(overloaded here doesn't necessarily mean DoS, just e.g. a single threaded
service that is taking a long time to do some job and expresses this
with a small argument to listen())

-Andi
