Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWAVV5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWAVV5M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 16:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWAVV5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 16:57:12 -0500
Received: from mx1.suse.de ([195.135.220.2]:62379 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751369AbWAVV5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 16:57:11 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs / Novell Inc.
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] kbuild: support building individual files for external modules
Date: Sun, 22 Jan 2006 22:58:20 +0100
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20060122212814.GA14113@mars.ravnborg.org>
In-Reply-To: <20060122212814.GA14113@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601222258.20424.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 January 2006 22:28, Sam Ravnborg wrote:
> Following patch implement support for building individual files when
> dealing with separate modules.

Lightly tested with a separate O= and M= directory and a copy of the entire 
fs/ tree; all seems to work for me. The only issue I had was with 
fs/xfs/Kbuild, which reads:

[] include $(srctree)/$(obj)/Makefile-linux-2.6

This should get changed as below to work equally well in and out of the tree:

[] include $(src)/Makefile-linux-2.6

> make -C $KERNELSRC M=`pwd` bar.lst

That's what triggered the bug report for me: people expect those targets to 
work also for external modules, and the patch fixes them. Thank you very 
much, Sam!

Andreas
