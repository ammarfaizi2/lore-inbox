Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWG0LWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWG0LWR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 07:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWG0LWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 07:22:16 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:37021 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751263AbWG0LWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 07:22:16 -0400
Date: Thu, 27 Jul 2006 13:22:15 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [WARNING -mm] 2.6.18-rc2-mm1 build kills /dev/null!?
Message-ID: <20060727112215.GA25569@rhlx01.fht-esslingen.de>
References: <20060727101128.GA31920@rhlx01.fht-esslingen.de> <20060727101709.GB31920@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727101709.GB31920@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 12:17:09PM +0200, Andreas Mohr wrote:
> Hi,
> 
> On Thu, Jul 27, 2006 at 12:11:28PM +0200, Andreas Mohr wrote:
> > Hello all,
> > 
> > for some reason a 2.6.18-rc2-mm1 build seems to kill my /dev/null device!
> 
> Replying to myself, this could easily be due to:

Yup, seems it is, see newly posted:

"Re: [PATCH] vDSO hash-style fix"
http://lkml.org/lkml/2006/7/27/83

| > +# ld-option
| > +# Usage: ldflags += $(call ld-option, -Wl$(comma)--hash-style=both)
| > +ld-option = $(shell if $(CC) $(1) \
| > +			     -nostdlib -o /dev/null -xc /dev/null \
| > +             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
| 
| This is not good. When I introduced something similar for lxdialog I
| received lots of reports about /dev/null becoming a regular file.
| ld does something strange with the output file when it fails.
| 
| When re-done ld-option shall be accompanied by documentation in
| Documentation/makefiles.txt like cc-option.

Could we have a -mm hot-fix here?

Andreas Mohr
