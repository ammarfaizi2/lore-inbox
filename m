Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315784AbSFCXXa>; Mon, 3 Jun 2002 19:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315785AbSFCXXa>; Mon, 3 Jun 2002 19:23:30 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:54772 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315784AbSFCXX2>; Mon, 3 Jun 2002 19:23:28 -0400
Subject: Re: Serverworks OSB4 in impossible state.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steven Timm <timm@fnal.gov>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0206031234370.12103-100000@boxer.fnal.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jun 2002 01:29:08 +0100
Message-Id: <1023150548.23874.99.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-03 at 18:40, Steven Timm wrote:
> Serverworks OSB4 in impossible state.
> Disable UDMA or if you are using Seagate then try switching disk types
> on this controller. Please report this event to osb4-bug@ide.cabal.tm
> OSB4: continuing might cause disk corruption.
> 
> This is the only one of 60 machines thus configured that has
> had the error thus far.
> 
> Two points:
> 1) The E-mail address in that kernel debug message doesn't exist.
> E-mail bounces back from it.

Oops I'll go fix that small detail. It should have been forwarded to me.

> 2) What is causing the hang and are there any hopes to
> fix it in software this time?  Last year when I came to the kernel
> list with problems very similar, the consensus was that this
> is actually broken hardware in the OSB4 chipset...but obviously
> it is possible for at least some kernels to run quasi-normally
> on this hardware... what changed between 2.4.9 and 2.4.18 so
> it doesn't anymore?

The code traps out when it sees the I/O complete and it turns out that
the DMA engine flags say the engine is still running. In this state we
kill the box because we know the next I/O will be written 4 bytes skewed
with the last 4 bytes of the previous I/O apparently repeated at the
start.

I took it up with the Serverworks guys at the time, but they were not
able to duplicate the problem and provide advice. Since we could verify
this across an entire rendering farm it was clearly not a weird one off
bug. It also doesn't appear to be a Linux bug (but maybe one day I'll be
proved wrong).

If you drop the drives to MWDMA2 you'll see only slightly lower
performance and solid behaviour

Alan

