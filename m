Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263161AbVCXSkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbVCXSkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 13:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVCXSid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 13:38:33 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50923 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263154AbVCXSgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 13:36:51 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: dri-devel@lists.sourceforge.net
Subject: Re: drm bugs hopefully fixed but there might still be one..
Date: Thu, 24 Mar 2005 10:35:05 -0800
User-Agent: KMail/1.7.2
Cc: Dave Jones <davej@redhat.com>, Dave Airlie <airlied@linux.ie>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503241015190.7647@skynet> <200503240902.03808.jbarnes@engr.sgi.com> <20050324181806.GA23567@redhat.com>
In-Reply-To: <20050324181806.GA23567@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503241035.05826.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 24, 2005 10:18 am, Dave Jones wrote:
>  > I'm trying to get ahold of one--so hopefully I'll be able to test and
>  > fix this stuff up when I do.
>
> Aparently backing out the changes to via's tlb_flush routine fixed it
> for one VIA user. I've not had a chance to look into it just yet.
> Worse case we can just drop those changes for 2.6.12

You mean these changes?

--- a/drivers/char/agp/via-agp.c        2005-03-24 10:33:45 -08:00
+++ b/drivers/char/agp/via-agp.c        2005-03-24 10:33:45 -08:00
@@ -83,8 +83,10 @@
 
        pci_read_config_dword(agp_bridge->dev, VIA_GARTCTRL, &temp);
        temp |= (1<<7);
+       temp &= ~0x7f;
        pci_write_config_dword(agp_bridge->dev, VIA_GARTCTRL, temp);
        temp &= ~(1<<7);
+       temp &= ~0x7f;
        pci_write_config_dword(agp_bridge->dev, VIA_GARTCTRL, temp);
 }


I'll ask Markus to try reverting this since I still don't have a machine 
setup.  It sounds like a possibility given what he's seeing.

Jesse
