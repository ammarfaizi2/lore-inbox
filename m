Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263532AbTDMO4e (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 10:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263533AbTDMO4e (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 10:56:34 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60590
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263532AbTDMO4d (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 10:56:33 -0400
Subject: Re: [PATCH] M68k IDE updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <200304131306.h3DD6XQ3001331@callisto.of.borg>
References: <200304131306.h3DD6XQ3001331@callisto.of.borg>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050243002.24186.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Apr 2003 15:10:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-13 at 14:06, Geert Uytterhoeven wrote:
> +#ifdef M68K_IDE_SWAPW
> +	if (M68K_IDE_SWAPW) {	/* fix bus byteorder first */
> +		u_char *p = (u_char *)id;
> +		u_char t;
> +		for (i = 0; i < 512; i += 2) {
> +			t = p[i];
> +			p[i] = p[i+1];
> +			p[i+1] = t;
> +		}
> +	}
> +#endif

This looks the wrong place to fix this problem Geert. The PPC 
folks have the same issues with byte order on busses but you
won't see ifdefs in the core IDE code for it.

Fix your __ide_mm_insw/ide_mm_outsw macros and the rest happens
automatically.

Linus, until better justification of why this has to be here
can you not apply this change.

Alan


