Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVCAXTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVCAXTp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 18:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVCAXTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 18:19:45 -0500
Received: from smtp07.web.de ([217.72.192.225]:22230 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S262113AbVCAXTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 18:19:43 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: x86_64: 32bit emulation problems
Date: Wed, 2 Mar 2005 00:19:19 +0100
User-Agent: KMail/1.7.2
Cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de> <200503012207.02915.bernd-schubert@web.de> <jewtsruie9.fsf@sykes.suse.de>
In-Reply-To: <jewtsruie9.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503020019.20256.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 March 2005 23:10, Andreas Schwab wrote:
> Bernd Schubert <bernd-schubert@web.de> writes:
> >> It is most likely some kind of user space problem.  I would change
> >> it to int err = stat(dir, &buf);
> >> and then go through it with gdb and see what value err gets assigned.
> >>
> >> I cannot see any kernel problem.
> >
> > The err value will become -1 here.
>
> That's because there are some values in the stat64 buffer delivered by the
> kernel which cannot be packed into the stat buffer that you pass to stat.
> Use stat64 or _FILE_OFFSET_BITS=64.

Hmm, after compiling with -D_FILE_OFFSET_BITS=64 it works fine. But why does 
it work without this option on a 32bit kernel, but not on a 64bit kernel?

32bit kernel, 32bit binary: always works
64bit kernel, 64bit binary: always works

64bit kernel, 32bit binary:
 - always works on knfsd mount points
 - always works with -D_FILE_OFFSET_BITS=64
 - only works on unfs3 mount points with _FILE_OFFSET_BITS=64 


Do I really have to write a bug report for every single debian package that 
access /etc  and /var to make the maintainers recompile it with 
-D_FILE_OFFSET_BITS=64? 
Btw, whats about Suse, are there all packages compiled with this option? ;)


Cheers, 
(a completely confused) Bernd
