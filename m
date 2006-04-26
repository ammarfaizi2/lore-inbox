Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWDZUsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWDZUsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWDZUsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:48:25 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:25792 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932322AbWDZUsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:48:24 -0400
Date: Wed, 26 Apr 2006 22:48:09 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: Andrew Morton <akpm@osdl.org>
Cc: NeilBrown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages.
Message-ID: <20060426204809.GA15462@uio.no>
References: <20060420160549.7637.patches@notabene> <1060420062955.7727@suse.de> <20060420003839.1a41c36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060420003839.1a41c36f.akpm@osdl.org>
X-Operating-System: Linux 2.6.14.3 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 12:38:39AM -0700, Andrew Morton wrote:
> In practice, I think it's OK - there's no _reason_ why anyone would want to
> trash the ->index of a just-truncated page.  However I think it'd be saner
> to a) only look at ->index after we've tried to lock the page and b) make
> sure that ->index is really "to the right" of where we're currently at.
> 
> How's this look?
> 
> --- devel/mm/truncate.c~remove-softlockup-from-invalidate_mapping_pages	2006-04-20 00:20:49.000000000 -0700
> +++ devel-akpm/mm/truncate.c	2006-04-20 00:28:18.000000000 -0700

I tried this patch against 2.6.17-rc2 (I hoped that it might be fixing my
kswapd oopses too, as they seem related; see
http://lkml.org/lkml/2006/4/26/124 and followups), and it simply makes my
machine hang on bootup -- it seems to make modprobe hang forever on some lock
or something right after it loads raid6.ko (pulled in by evms_activate) in
initramfs. Without the patch, the machine boots just fine.

Since it's on serial console, I've got a SysRq+T log if it helps you.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
