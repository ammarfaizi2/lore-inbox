Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267756AbUHEXJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267756AbUHEXJq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 19:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267790AbUHEXJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 19:09:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:5339 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267756AbUHEXJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 19:09:43 -0400
Date: Thu, 5 Aug 2004 15:48:26 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: BUG: SCSI SYNCHRONIZE_CACHE on driver unload
Message-Id: <20040805154826.633ff4cd.rddunlap@osdl.org>
In-Reply-To: <4112BC7A.1040102@rtr.ca>
References: <4112BC7A.1040102@rtr.ca>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2004 19:02:18 -0400 Mark Lord wrote:

| On module removal of a SCSI Low-Level Driver (LLD),
| the mid-layer tries to do a SYNCHRONIZE_CACHE
| command to each device on each host of that driver.
| 
| But the command is issued *after* setting SHOST_CANCEL,
| which means that scsi_dispatch_cmd() will *always*
| fail the command inline, without passing to the LLD.
| 
| This bug shows up only for hosts/drives which support
| a write-back caching scheme.  For the more common
| write-thru scheme, the SYNCHRONIZE_CACHE command is
| never issued, so the bug never manifests.

Like this, when I unmount a zip drive (?):

Synchronizing SCSI cache for disk sde: <4>FAILED
  status = 0, message = 00, host = 1, driver = 00

--
~Randy
