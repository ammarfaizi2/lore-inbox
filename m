Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUIEBkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUIEBkH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 21:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUIEBkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 21:40:06 -0400
Received: from pat.uio.no ([129.240.130.16]:12704 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265900AbUIEBjw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 21:39:52 -0400
Subject: Re: why do i get "Stale NFS file handle" for hours?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Sven =?ISO-8859-1?Q?K=F6hler?= <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <chdp06$e56$1@sea.gmane.org>
References: <chdp06$e56$1@sea.gmane.org>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1094348385.13791.119.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 04 Sep 2004 21:39:45 -0400
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På lau , 04/09/2004 klokka 21:06, skreiv Sven Köhler:
> Hi,
> 
> i think i know what's going an, and why i get the "stale nfs handle" 
> error-message when the NFS server is restartet (real reboot, or a simply 
> /etc/init.d/nfs restart) but what i don't understand is, why the NFS 
> client doesn't "remount" the filesystem autmatically. In case of NFS 
> over tcp, the NFS client could easily detect a restart of the NFS server 
> (the tcp-connection was aborted) or are there other factors that keep 
> the NFS client from recognizing such stuff?

Sigh. This question keeps coming up again and again and again. Why can't
you people search the archives?

Of course we could "fix" things for the user so that we just look up all
those filehandles again transparently.

  The real question is: how do we know that is the right thing to do?

The NFS client wouldn't know the difference between your /etc/passwd
file and a javascript pop-up ad. If it gets an ESTALE error, then that
tells it that the original filehandle is invalid, but it does not know
WHY that is the case. The file may have been deleted and replaced by a
new one. It may be that your server is broken, and is actually losing
filehandles on reboot (as appears to be the case in your setup),...

Reopening the file, and then continuing to write from the same position
may be the right thing to do, but then again it may cause you to
overwrite a bunch of freshly written password entries.

So we bounce the error up to userland where these issues can actually be
resolved.

Cheers,
  Trond

