Return-Path: <linux-kernel-owner+w=401wt.eu-S932783AbXASAwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932783AbXASAwz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932801AbXASAwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:52:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:36507 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932783AbXASAwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:52:54 -0500
X-Authenticated: #5039886
Date: Fri, 19 Jan 2007 01:52:51 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org, Larry Walton <lwalton@real.com>,
       jeff@garzik.org, htejun@gmail.com, jens.axboe@oracle.com
Subject: Re: SATA exceptions with 2.6.20-rc5
Message-ID: <20070119005251.GA32669@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
	Larry Walton <lwalton@real.com>, jeff@garzik.org, htejun@gmail.com,
	jens.axboe@oracle.com
References: <fa.U/G88R1fWKOeQK3EBPHKK4MeRsQ@ifi.uio.no> <fa.2D0TIXbVTOgZmGg9ZJU+R7te70k@ifi.uio.no> <fa.hMhdefkReYJ4idUyqqEWJFnWUBE@ifi.uio.no> <fa.8TPWeOrcwkkHutPX5NOcJsTBO8Y@ifi.uio.no> <fa.b92BqwV090pDj7q0iBG6BChksbI@ifi.uio.no> <fa.O3RzvckSjB73Y0uL8P1nTXDRd6U@ifi.uio.no> <45B00C4E.4040803@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45B00C4E.4040803@shaw.ca>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2007.01.18 18:09:50 -0600, Robert Hancock wrote:
> I heard from Larry Walton who was apparently seeing this problem as 
> well. He tried my recent "sata_nv: cleanup ADMA error handling v2" patch 
> and originally thought it fixed the problem, but it turned out to only 
> make it happen less often.
> 
> I wouldn't expect that patch to have an effect on this problem. If it 
> seems to reduce the frequency that would tend to be further evidence of 
>  some kind of timing-related issue where the code change just happens 
> to make a difference.
> 
> I'll see if I can come up with a debug patch for people having this 
> problem to try, which prints out when a flush command is issued and what 
> interrupts happen when a flush is pending.
> 
> There is one important difference between ADMA and non-ADMA mode for 
> non-DMA commands like flushes, which didn't come to mind before: ADMA 
> mode uses MMIO registers on the controller whereas non-ADMA mode uses 
> legacy IO registers. Posted write flushing is a concern with MMIO 
> registers but not with PIO, the libata core is supposed to handle this 
> but maybe it doesn't in some case(s). In fact, just looking at 
> libata-sff.c there's this comment on the ata_exec_command_mmio function:
> 
>  *      FIXME: missing write posting for 400nS delay enforcement
> 
> That seems a bit suspicious..

That would imply that disabling adma via a module parameter should make
the issue go away, right? I'll try to have a test run with adma disabled
over night then.

Thanks,
Björn
