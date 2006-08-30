Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWH3TYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWH3TYc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWH3TYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:24:32 -0400
Received: from 1wt.eu ([62.212.114.60]:44049 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751364AbWH3TYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:24:31 -0400
Date: Wed, 30 Aug 2006 21:01:25 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andi Kleen <ak@suse.de>
Cc: pageexec@freemail.hu, davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] exception processing in early boot
Message-ID: <20060830190125.GA21041@1wt.eu>
References: <20060830063932.GB289@1wt.eu> <200608301952.54180.ak@suse.de> <44F5F348.1251.5C4EBCCB@pageexec.freemail.hu> <200608302026.05968.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608302026.05968.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 08:26:05PM +0200, Andi Kleen wrote:
> On Wednesday 30 August 2006 20:21, pageexec@freemail.hu wrote:
> > On 30 Aug 2006 at 19:52, Andi Kleen wrote:
> > > On Wednesday 30 August 2006 19:33, pageexec@freemail.hu wrote:
> > 
> > > > > But I went with the simpler patch with some changes now 
> > > > > (added PANIC to the message etc.) 
> > > > 
> > > > can you post it please?
> > > 
> > > ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/i386-early-exception
> > 
> > thanks, although i suggest you put back the hlt as Dick Johnson explained it.
> 
> Unless someone can confirm there were not other problems on those 386s/486s
> in HLT no.

Andi, if you remove the HLT here, some CPUs will spin at full speed. This
is nasty during boot because some of them might not have enabled their
fans yet for instance and could fry if nobody's looking (eg: live reset
caused by hardware problem). Even if HLT does not work on some CPUs,
the JMP after it will spin around it and the initial goal will be achieved.

Regards,
Willy

