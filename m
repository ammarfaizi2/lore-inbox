Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVCAVHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVCAVHt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 16:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVCAVHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 16:07:44 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:56259 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S261720AbVCAVHd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 16:07:33 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: Andi Kleen <ak@muc.de>
Subject: Re: x86_64: 32bit emulation problems
Date: Tue, 1 Mar 2005 22:07:01 +0100
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de> <20050301202417.GA40466@muc.de>
In-Reply-To: <20050301202417.GA40466@muc.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200503012207.02915.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andi,

sorry, due to some mail sending/refusing problems, I had to resend to the 
nfs-list, which prevented the answers there to be posted to the other CCs.

> It is most likely some kind of user space problem.  I would change
> it to int err = stat(dir, &buf);
> and then go through it with gdb and see what value err gets assigned.
>
> I cannot see any kernel problem.

The err value will become -1 here.

 Trond Myklebust already suggested to look at the results of errno:

On Tuesday 01 March 2005 00:43, Bernd Schubert wrote:
> On Monday 28 February 2005 23:26, you wrote:
> > Given that strace shows that both syscalls (stat64() and stat())
> > succeed, I expect the "problem" is probably just glibc setting an
> > EOVERFLOW error in the 32-bit case. That's what it is supposed to do if
> > a 64 bit value overflows the 32-bit buffers.
>
> Right, thanks.
>
> > Have you tried looking at errno?
>
> bernd@hitchcock tests>./test_stat32 /mnt/test/yp
> stat for /mnt/test/yp failed
> ernno: 75 (Value too large for defined data type)
>
> But why does stat64() on a 64-bit kernel tries to fill in larger data than
> on a 32-bit kernel and larger data also only for nfs-mount points? Hmm, I
> will tomorrow compare the tcp-packges sent by the server.

So I still think thats a kernel bug.


Thanks,
 Bernd

-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
