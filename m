Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVBPRGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVBPRGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 12:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVBPRGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 12:06:09 -0500
Received: from pat.uio.no ([129.240.130.16]:43658 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262081AbVBPRGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 12:06:01 -0500
Subject: Re: [patch 10/13] Solaris nfsacl workaround
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1108570666.30082.118.camel@winden.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203619.889966000@blunzn.suse.de>
	 <1108488547.10073.39.camel@lade.trondhjem.org>
	 <1108570666.30082.118.camel@winden.suse.de>
Content-Type: text/plain
Date: Wed, 16 Feb 2005 12:05:47 -0500
Message-Id: <1108573547.10161.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.12, required 12,
	autolearn=disabled, AWL 1.88, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 16.02.2005 Klokka 17:17 (+0100) skreiv Andreas Gruenbacher:
> On Tue, 2005-02-15 at 18:29, Trond Myklebust wrote:
> > lau den 22.01.2005 Klokka 21:34 (+0100) skreiv Andreas Gruenbacher:
> > > Solaris nfsacl workaround
> > 
> > NACK. No hacks.
> 
> Well, I'm not in the position to fix Solaris. It would be possible to
> implement NFSACL for NFSv2 (Solaris has it), but I doubt that we need
> it. Your NACK probably means we'll have to carry it around as a vendor
> patch.

See the thread between Olivier Galibert & I. There are ways of doing
this which do not involve putting nfsacl code in the generic sunrpc
layer.
Either a callback or a flag in the "struct svc_program" to override the
standard RPC server reply (instead of checking the ACL program number)
would be fine as far as I'm concerned. I can't speak for Neil's
preferences, though.

I am, however, surprised when you say that Solaris has problems with
this. The PROG_MISMATCH error does also tell the client the minimum and
maximum supported version, so if all is working well, then it recognize
that we support version 3 only. It seems wierd that they should then
choose to treat that as an mount failure.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

