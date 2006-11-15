Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030648AbWKOQVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030648AbWKOQVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030647AbWKOQV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:21:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57492 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030648AbWKOQV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:21:28 -0500
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
From: Arjan van de Ven <arjan@infradead.org>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Tejun Heo <htejun@gmail.com>, Mathieu Fluhr <mfluhr@nero.com>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <455B3D99.8040705@cfl.rr.com>
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
	 <4558BE57.4020700@cfl.rr.com>
	 <1163444160.27291.2.camel@de-c-l-110.nero-de.internal>
	 <1163446372.15249.190.camel@laptopd505.fenrus.org>
	 <1163519125.2998.8.camel@de-c-l-110.nero-de.internal>
	 <455 <455B3A78.7010503@gmail.com>  <455B3D99.8040705@cfl.rr.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 15 Nov 2006 17:20:52 +0100
Message-Id: <1163607653.31358.128.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 11:17 -0500, Phillip Susi wrote:
> Tejun Heo wrote:
> >> The patch _seems_ to solve my problem. I am just really astonished when
> >> I read the diff file :D. Can I expect that it will be merged to the
> >> official kernel sources ?
> > 
> > It seems that some devices choke when the bytes after CDB contain 
> > garbage.  I seem to recall that I read somewhere ATAPI device require 
> > left command bytes cleared to zero but I can't find it anywhere now. 
> > Maybe I'm just imagining.  Anyways, yeah, I'll push it to upstream.
> > 
> 
> The original patch memsets the entire buffer only to copy over most of 
> it right after.  Could you amend the patch so that it memcpys first, 
> then memsets only the remainder of the buffer?  No sense wasting cpu 
> cycles.

due to the funnies of how cpu caches work it might not actually be
faster though... Write Allocate and things like that are.. well fun.



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

