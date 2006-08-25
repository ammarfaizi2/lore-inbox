Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWHYJwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWHYJwr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 05:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWHYJwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 05:52:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41671 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932322AbWHYJwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 05:52:46 -0400
Subject: Re: [PATCH 3/4] Add __global tag where needed.
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060824213047.GR19810@stusta.de>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433212.3012.120.camel@pmac.infradead.org>
	 <20060824213047.GR19810@stusta.de>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 10:52:26 +0100
Message-Id: <1156499546.2984.43.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 23:30 +0200, Adrian Bunk wrote:
> Applying this doesn't seem to make much sense until it's clear whether a
> "build everything except for assembler files at once" approach (that 
> needs less globals) or your current "compile only multi-obj at once" 
> approach (that requires more globals). 

For the kernel itself, I think that building a directory at once is the
way forward. For modules, obviously the scope is more limited.

Either way, I'd like to prevent the unnecessary proliferation of
__global by instrument the link process somehow so that we get a
_warning_ during the final link if there are any global symbols which
aren't actually used. Having said that, --gc-sections will happily drop
them from the vmlinux anyway so I'm not _overly_ concerned by it.

In fact, I think binutils got patched recently so that it can _tell_ us
what sections got dropped by --gc-sections, which would do the job
nicely.

-- 
dwmw2

