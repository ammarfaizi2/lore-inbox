Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUHQI6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUHQI6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUHQI6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:58:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:14984 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264502AbUHQI6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:58:50 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, kai@germaschewski.name, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] 2.6.8-rc4-mm1 - Fix UML build
References: <200408120414.i7C4EtJd010481@ccure.user-mode-linux.org>
	<20040815150635.5ac4f5df.akpm@osdl.org>
	<200408170602.i7H62LNj019126@ccure.user-mode-linux.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Am I SHOPLIFTING?
Date: Tue, 17 Aug 2004 10:55:51 +0200
In-Reply-To: <200408170602.i7H62LNj019126@ccure.user-mode-linux.org> (Jeff
 Dike's message of "Tue, 17 Aug 2004 02:02:21 -0400")
Message-ID: <jellge9m94.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> writes:

> @@ -84,7 +88,10 @@
>  
>  prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS)
>  
> -LDFLAGS_vmlinux = -r
> +# This stupidity extracts the directory in which gcc lives so that it can
> +# be fed to ld when it's linking .tmp_vmlinux during the ldchk stage.
> +LD_DIR = $(shell dirname `gcc -v 2>&1 | head -1 | awk '{print $$NF}'`)

Try gcc -print-search-dirs.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
