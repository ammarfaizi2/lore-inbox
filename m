Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbUEFUWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUEFUWi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 16:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbUEFUWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 16:22:38 -0400
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:57607
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S262909AbUEFUWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 16:22:36 -0400
Date: Thu, 6 May 2004 13:22:33 -0700
From: Brad Boyer <flar@allandria.com>
To: Zhenmin Li <zli4@cs.uiuc.edu>
Cc: "'Geert Uytterhoeven'" <geert@linux-m68k.org>,
       "'Linux/m68k'" <linux-m68k@lists.linux-m68k.org>,
       "'Linux/m68k on Mac'" <linux-mac68k@mac.linux-m68k.org>,
       "'Linux Kernel Development'" <linux-kernel@vger.kernel.org>
Subject: Re: [OPERA] Potential bugs detected by static analysis tool in 2.6.4
Message-ID: <20040506202233.GA2003@pants.nu>
References: <Pine.GSO.4.58.0405061141290.12096@waterleaf.sonytel.be> <002d01c43389$6bbbea70$76f6ae80@Turandot>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002d01c43389$6bbbea70$76f6ae80@Turandot>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 11:44:37AM -0500, Zhenmin Li wrote:
> Sorry for the typo. The line number should be 264, and the context is:
> 
> if (macintosh_config->adb_type == MAC_ADB_IOP) {
> 	if (macintosh_config->ident == MAC_MODEL_IIFX) {
> 		iop_base[IOP_NUM_ISM] = (struct mac_iop *)
> ISM_IOP_BASE_IIFX;
> 	} else {
> 		iop_base[IOP_NUM_ISM] = (struct mac_iop *)
> ISM_IOP_BASE_QUADRA;
> 	}
> 	iop_base[IOP_NUM_SCC]->status_ctrl = 0;
> 	iop_ism_present = 1;
> }

That's what I suspected. Yes, this code is broken, and line 264
should have IOP_NUM_ISM, just like the other two lines. The
current IOP driver is a bit of a hack, and I guess it just slipped
through the cracks. We rely on the chips to be mostly initialized
before we touch them as it is.

This line should be fixed as suggested, and if it breaks anything,
it's because the code was broken before, and we just didn't notice.
This driver only gets used on 3 Macintosh models, all of which are
relatively obscure.

	Brad Boyer
	flar@allandria.com

