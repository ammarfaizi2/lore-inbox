Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUJTAmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUJTAmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUJTAkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:40:45 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:13276 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S263962AbUJTARp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:17:45 -0400
From: Alistair John Strachan <alistair@devzero.co.uk>
Reply-To: alistair@devzero.co.uk
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.9: performance issues on Via Epia
Date: Wed, 20 Oct 2004 01:17:29 +0100
User-Agent: KMail/1.7.1
References: <200410191604.22747.alistair@devzero.co.uk> <200410192346.14695.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410192346.14695.vda@port.imtp.ilyichevsk.odessa.ua>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410200117.29871.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 Oct 2004 21:46, you wrote:
> On Tuesday 19 October 2004 18:04, Alistair John Strachan wrote:
> > Hi,
> >
> > I recently upgraded from 2.6.8.1 to 2.6.9 (the release, not -final) on my
> > Via Epia 5000 router. Now when I transfer files from the machine's HD
> > vsftpd can only achieve 3MB/s.
> >
> > I believe this is some performance problem specifically related to XFS,
> > or something specific to the local VM, because if I transfer from an NFS
> > mounted directory on the same machine, vsftpd easily achieves the 10MB/s
> > I'm used to.
>
> Sound like 'DMA off' problem.

Could be, not changed anything since 2.6.8.1 though and dmesg claims dma is 
enabled on hda, which is the only connected drive

>
> > Top shows something typical to this during transfers from the machine's
> > local HD;
> >
> > Cpu(s):  0.7% us,  9.2% sy,  0.0% ni,  0.3% id, 84.5% wa,  5.3% hi,  0.0%
> > si
> >
> > Which seems like an awful lot of wait time. Anybody got any suggestions
> > of where to start reverting patches? The amount of difference between
> > 2.6.8.1 and 2.6.9 is quite daunting.
>
> Binary search is converging quickly.

That's still a lot of work, but thanks.. I'll probably just work through the 
bk snapshots until it breaks, then binary search on the remaining patches. 
It'll still take a couple of hours, especially on such a slow machine.

>
> > By the way, copying a file locally on the system from the same partition
> > to another directory is far more efficient.
> >
> > [root] 16:02 [~] time cp /var/cache/swapfile here
> > `/var/cache/swapfile' -> `here'
> >
> > real    0m37.904s
> > user    0m0.115s
> > sys     0m13.033s
>
> size of this file?

512MB, sorry about that..

By the way Jeff, I already said in my original post that copying from a local 
NFS mount gives me to get the full 10MB/s i.e.

NFS server X -> problem case machine's NFS mount -> some client machine = fine
problem case machine's local mount -> some client machine = slow.

My email was just an attempt to stir up any obvious changes that might've 
taken place. Since the problem seems obscure, I'll probably have to do it 
properly and manually search through the patches until I find the problem 
one.

Thanks for your prompt replies.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
