Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbTLHEOz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 23:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbTLHEOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 23:14:55 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46084 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265325AbTLHEOy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 23:14:54 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Date: 8 Dec 2003 04:03:37 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <br0t6p$c8o$1@gatekeeper.tmr.com>
References: <200312041432.23907.rob@landley.net> <16335.47878.628726.26978@wombat.chubb.wattle.id.au> <873cc0nkgf.fsf@ceramic.fifi.org>
X-Trace: gatekeeper.tmr.com 1070856217 12568 192.168.12.62 (8 Dec 2003 04:03:37 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <873cc0nkgf.fsf@ceramic.fifi.org>,
Philippe Troin  <phil@fifi.org> wrote:
| Peter Chubb <peter@chubb.wattle.id.au> writes:
| 
| > >>>>> "Rob" == Rob Landley <rob@landley.net> writes:
| > 
| > Rob> You can make a file with a hole by seeking past it and never
| > Rob> writing to that bit, but is there any way to punch a hole in a
| > Rob> file after the fact?  (I mean other with lseek and write.  Having
| > Rob> a sparse file as the result....)
| > 
| > SVr4 has fcntl(fd, F_FREESP, flock) that frees the space covered by
| > the struct flock in the file.  Linux doesn't have this, at least in
| > the baseline kernels.
| 
| However most SVr4 (at least Solaris and HP-UX) only implement FREESP
| when the freed space is at the file's tail. In other words, FREESP can
| only be used to implement ftruncate().

Actually, I would thinmk that you *don't* want to do this at end of
file, turning zeros into holes is not the same as truncate, since it
will change the value of the file size, and that may not be what you
want at all.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
