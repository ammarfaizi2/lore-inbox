Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUJOWnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUJOWnJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 18:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUJOWnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 18:43:09 -0400
Received: from mail.inter-page.com ([12.5.23.93]:45574 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S265331AbUJOWnF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 18:43:05 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Willy Tarreau'" <willy@w.ods.org>,
       "'David S. Miller'" <davem@davemloft.net>
Cc: "'Olivier Galibert'" <galibert@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Fri, 15 Oct 2004 15:42:55 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAf9vmEwEK20KyGtJj9HtARQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20041008064104.GF19761@alpha.home.local>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
On Behalf Of Willy Tarreau

> As I asked in a previous mail in this overly long thread, why not returning
> zero bytes at all. It is perfectly valid to receive an UDP packet with 0


Zero bytes is "end of file".  Don't go trying to co-opt end of file.  That way lies
madness and despair.

You would *then* need a flag on each file descriptor to determine if the most
previous call before the read op was a select that returned the file as readable so
you knew whether to block or return the not-really-end-of-file.  Your *app* would
then also need a flag/context to determine whether the end of file just read was
contextually an aborted read after select.


Nope, very very very very very bad idea... 8-)

[On the larger issues, I am surprised that select() doesn't guarantee available data
and one subsequent non-blocking read, but again in the case of a UDP discard after
the select but before the read, that is the only thing that makes sense.  I would
vote (were this a democracy 8-) to put a CAVEAT in the manual that listed the _rare_
cases, as examples, where the warrant of available data may prove false; give a nod
to real life, and _firmly suggest_ that if you are using select, you *probably* want
nonblocking file descriptors too.]

