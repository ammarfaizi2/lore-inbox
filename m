Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262853AbUJ1Jhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbUJ1Jhn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbUJ1JfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:35:20 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2012 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262853AbUJ1Jed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:34:33 -0400
Date: Thu, 28 Oct 2004 11:34:26 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: "Theodore Ts'o" <tytso@mit.edu>, Timo Sirainen <tss@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: readdir loses renamed files
Message-ID: <20041028093426.GB15050@merlin.emma.line.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Timo Sirainen <tss@iki.fi>, linux-kernel@vger.kernel.org
References: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi> <20041025123722.GA5107@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025123722.GA5107@thunk.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, Theodore Ts'o wrote:

> And that's because there's no good way to do this without trashing the
> performance of the system, especially when most applications don't
> care.  (Do you really want your entire system running significantly
> slower, penalizing all other applications on your system, just because
> of one stupid/badly-written application?)

Please - is it really necessary that application writers are offended in
this way? Timo is investing enormous time and effort in writing a *good*
application, and he's effectively seeking a way to *robustly* deal with
Maildir format mail storage. Please leave it at "readdir/getdents don't
work the way you expect and cannot for this and that reason."

Timo tries to implement a *robust* Maildir reader and has just bumped
into the flaws of DJB's "no-locking" store.

Yes, it's a mail server again that poses file system questions on this
list; only it's IMAP this time rather than SMTP and directory
synchronous I/O...

> In order to do this, the
> kernel would have to atomically snapshot the directory --- even one
> which might be several megabytes in length, and store a copy of it in
> memory, while the application calls readdir().  Several processes
> could perform a denial-of-service attack by starting to call
> readdir(), and then stopping.  This would end up locking up huge
> amounts of non-pageable system memory, and cause the system to come
> down in a hurry.

I'd like to question that.

Just some rough thoughts:

1. the number of open file handles (including directories seen as files
   for a moment at least) is limited per process, and I'd think the
   number of directories open can be lower

2. versioned information might provide what the application wants
   without locking up the system

3. the application could be offered an interface for atomic directory
   reads that requires the application to provide sufficient memory in a
   single contiguous buffer (making it thread-safe in the same go).

-- 
Matthias Andree
