Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272542AbTHEPo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 11:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272530AbTHEPoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 11:44:55 -0400
Received: from pat.uio.no ([129.240.130.16]:28587 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S272542AbTHEPoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 11:44:54 -0400
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, root@chaos.analogic.com,
       helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<Pine.LNX.4.53.0308050916140.5994@chaos>
	<20030805160435.7b151b0e.skraw@ithnet.com>
	<03080510020503.05972@tabby>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 05 Aug 2003 17:44:06 +0200
In-Reply-To: <03080510020503.05972@tabby>
Message-ID: <shsk79s6reh.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jesse Pollard <jesse@cats-chateau.net> writes:

     > You do have to remember that any NFS export gives IMPLICIT
     > access to the entire filesystem (it is the device number that
     > is actually exported). If the attacker can generate
     > device:inode number, then that file reference can be opened. I
     > haven't read/seen anything yet that has said different.

Not entirely true. The default under Linux is to enable subtree
checks. This means that knfsd must establish that the file being
accessed lies within a subtree the head of which is the export point.
This wreaks havoc with cross-directory renames etc, so a lot of people
disable it, however it is a slightly safer default...

Of course if you start playing with the idea of hard linked
directories then subtree checks are no longer an option as the path
connecting an export point and the file is no longer guaranteed to be
unique (and some paths may not even be finite).

Cheers,
  Trond
