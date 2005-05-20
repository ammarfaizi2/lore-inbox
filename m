Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVETPCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVETPCV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 11:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVETPCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 11:02:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18097 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261423AbVETPCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 11:02:07 -0400
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context
	at mm/slab.c:2502
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200505201430.j4KEUFD0012985@turing-police.cc.vt.edu>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
	 <1116502449.23972.207.camel@hades.cambridge.redhat.com>
	 <200505191845.j4JIjVtq006262@turing-police.cc.vt.edu>
	 <200505201430.j4KEUFD0012985@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Fri, 20 May 2005 15:59:54 +0100
Message-Id: <1116601195.29037.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 10:30 -0400, Valdis.Kletnieks@vt.edu wrote:
> Looks like we either only swatted half the bug, or the patch moved it
> around. Slightly different trace this time:

OK. Steve's audit_log_d_path() change, which I pulled in because it had
the side-effect of NUL-terminating the buffer, is now using GFP_KERNEL
where previously it was not. 

We could make it use GFP_ATOMIC, but I suspect the better answer if at
all possible would be to make sure that avc_audit doesn't call it with
spinlocks held. Or maybe to make avc_audit() pass a gfp_mask to it, but
I don't like that much.

-- 
dwmw2

