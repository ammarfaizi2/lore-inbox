Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbULUVJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbULUVJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 16:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbULUVJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 16:09:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42194 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261630AbULUVJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 16:09:19 -0500
Date: Tue, 21 Dec 2004 13:09:17 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>, zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Basic UB q
Message-ID: <20041221130917.692d07e3@lembas.zaitcev.lan>
In-Reply-To: <mailman.1103578621.31042.linux-kernel2news@redhat.com>
References: <Pine.LNX.4.61.0412202226100.8722@yvahk01.tjqt.qr>
	<mailman.1103578621.31042.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004 16:30:57 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2004-12-20 at 22:26 +0100, Jan Engelhardt wrote:

> > what is the "ub" driver good for? Doesnot USB over SCSI work well enough?

> Because that requires the SCSI layer which is overkill for very simple
> devices.

This is not quite what I had in mind. Memory is not that expensive,
and ub has to carry a miniature SCSI stack in it anyway. But getting
rid of a few oopses and lockups would be nice. James does a very good job
trying to contain the complexity of the SCSI stack, however I still see
some problems. Perhaps not even him, not Doug Ledford, not anyone is capable
of making a SCSI stack which does not crash. The 2.6.9 was especially painful
and hurt us quite a bit, I'm going to be sore for a while. I cannot be sure
that this sort of thing is not going to happen when we try to ship RHEL 5.

But even if nothing else, I think ub is prompting some positive changes
in usb-storage. There is some talk of better debuggability already, for
example.

The biggest problem with ub right now is that it's pissing Matt Dharm off
by flooding him with retarded bug reports from users who: a) override default
(which is set to ub off), b) ignore warnings in the help, c) cannot figure
out what they just broke. If we had a way to make users like Jan to send
reports to me instead, it would be great progress. Most are well-intentioned.
The approach most seem to advocate is to create a better safety net for
users by instilling palliatives such as making CONFIG_BLK_DEV_UB to depend
on CONFIG_EXPERIMENTAL. Unfortunately, it's not likely to do much. If they
override default settings, they are not likely to be deterred so simply.
I'm considering printing some warnings into syslog, although it's terribly
lame (remember the infamous "Data integrity not assured for USB storage").
This needs some thinking.

Cheers,
-- Pete
