Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVBGDZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVBGDZb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 22:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVBGDZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 22:25:31 -0500
Received: from mail.joq.us ([67.65.12.105]:47058 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261338AbVBGDZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 22:25:25 -0500
To: Werner Almesberger <wa@almesberger.net>
Cc: Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       abiss-general@lists.sourceforge.net
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>
	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>
	<87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>
	<87oefkd7ew.fsf@sulphur.joq.us> <41EF48BA.50709@kolivas.org>
	<20050207000922.B25338@almesberger.net>
From: "Jack O'Quin" <joq@io.com>
Date: Sun, 06 Feb 2005 21:27:34 -0600
In-Reply-To: <20050207000922.B25338@almesberger.net> (Werner Almesberger's
 message of "Mon, 7 Feb 2005 00:09:22 -0300")
Message-ID: <87acqhnj6h.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> [ Cc:s trimmed, added abiss-general ]
>
> Con Kolivas wrote:
>> Possibly reiserfs journal related. That has larger non-preemptible code 
>> sections.
>
> If I understand your workload right, it should consist mainly of
> computation, networking (?), and disk reads.

The jack_test3.2 is basically a multiprocess realtime audio test.  A
fair amount of computation, signifcant task switch overhead, but
most I/O is to the sound card.

There's some disk activity starting clients and probably some other
system activity in the background.

> I don't know much about ReiserFS, but in some experiments with ext3,
> using ABISS, we found that a reader application competing with best
> effort readers would experience worst-case delays of dozens of
> milliseconds.
>
> They were caused by journaled atime updates. Mounting the file
> system with "noatime" reduced delays to a few hundred microseconds
> (still worst-case).

Interesting. Worth a try to verify.  Con was seeing a 6msec delay
every 20 seconds.  This was devastating to the test, which tries to
run a full realtime audio cycle every 1.45msec.
-- 
  joq
