Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbULPLBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbULPLBE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 06:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbULPLBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 06:01:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:129 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262409AbULPLA5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 06:00:57 -0500
Date: Tue, 14 Dec 2004 19:58:55 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Question about memcpy_fromio prototype
Message-ID: <20041214195855.GU27199@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus.  On x86 and ia64, memcpy_fromio is protoyped as:

static inline void memcpy_fromio(void *dst, volatile void __iomem *src, int count)

ALSA does this (except on x86 and sparc32, so you don't see it):

int copy_to_user_fromio(void __user *dst, const void __iomem *src, size_t count)
[...]
                memcpy_fromio(buf, src, c);

which provokes a warning from gcc that we're discarding a qualifier (the
'const') from src.  Is ALSA just wrong?  Or is the 'volatile' wrong?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
