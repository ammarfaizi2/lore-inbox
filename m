Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263149AbUEGLC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbUEGLC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 07:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUEGLC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 07:02:27 -0400
Received: from verein.lst.de ([212.34.189.10]:9679 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263149AbUEGLC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 07:02:26 -0400
Date: Fri, 7 May 2004 13:02:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: rth@twiddle.net, ink@jurassic.park.msu.ru
Cc: linux-kernel@vger.kernel.org
Subject: alpha fp-emu vs module refcounting
Message-ID: <20040507110217.GA11366@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, rth@twiddle.net,
	ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/alpha/math-emu/math.c still uses MOD_{INC,DEC}_USE_COUNT to protect
from unloading which is

 a) unsafe
 b) in the way of nuking them as soon as 2.7 is out

any chance we could either do a try_module_get on a struct module
*fp_emul_module in alpha core code before or completely disallow module
unloading for it (by removing the cleanup_module() callback)?
