Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTKMPat (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 10:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbTKMP3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 10:29:34 -0500
Received: from pat.uio.no ([129.240.130.16]:23457 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264326AbTKMP2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 10:28:32 -0500
To: root@chaos.analogic.com
Cc: "martin.knoblauch " <"martin.knoblauch "@mscsoftware.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs_statfs: statfs error = 116
References: <3FB391FC.2090406@mscsoftware.com>
	<Pine.LNX.4.53.0311130927280.30784@chaos>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 Nov 2003 10:27:47 -0500
In-Reply-To: <Pine.LNX.4.53.0311130927280.30784@chaos>
Message-ID: <shssmks70gc.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Richard B Johnson <root@chaos.analogic.com> writes:

     > ESTALE happens when a mounted file-system is on a server that
     > went down or re-booted. The file-handles are then "stale".

Sort of. It means that the server is unable to find the file that
corresponds to the filehandle that the client sent it. If the server
strictly follows the NFS specs, then this is only supposed to happen
if somebody else has deleted the file (and this is why designing a
scheme for generating filehandles is such a difficult job).

Some broken servers do, however, "lose" the file in other interesting
and unpredictable ways.

     > ERESTARTSYS is the error returned by a server that has
     > re-booted that is supposed to tell the client-side software to
     > get a new file-handle because of an attempt to access with a
     > stale file-handle. When getting this error, the client should
     > have reopened the file(s) to obtain a new handle.

ERESTARTSYS actually just means that a signal was received while
inside a system call. If this results in a interruption of that
syscall, the kernel is supposed to translate ERESTARTSYS into the user
error EINTR.

Userland should therefore never have to handle ERESTARTSYS errors.

Cheers,
  Trond
