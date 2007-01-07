Return-Path: <linux-kernel-owner+w=401wt.eu-S965003AbXAGT7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbXAGT7O (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbXAGT7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:59:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41772 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965003AbXAGT7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:59:13 -0500
Date: Sun, 7 Jan 2007 19:58:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] math-emu/setcc: avoid gcc extension
Message-ID: <20070107195845.GA21829@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <20070106221947.8e01d404.randy.dunlap@oracle.com> <33e707f92df6b89a1c22f337f230cf32@kernel.crashing.org> <20070107104555.015aa79f.randy.dunlap@oracle.com> <974f8eb0d5984af6726a130082453916@kernel.crashing.org> <20070107111900.9d434162.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107111900.9d434162.randy.dunlap@oracle.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 11:19:00AM -0800, Randy Dunlap wrote:
> On Sun, 7 Jan 2007 20:12:42 +0100 Segher Boessenkool wrote:
> 
> > There's an extra tab in that last line.  Could you also
> > please fix the indenting (use a tab, not spaces) -- I know
> > it was there originally, but since there are only a few
> > lines in that file like that...  :-)
> 
> how's this one?
> ---
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> setcc() in math-emu is written as a gcc extension statement expression
> macro that returns a value.  However, it's not used that way and it's
> not needed like that, so just make it a do-while non-extension macro
> so that we don't use an extension when it's not needed.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  arch/i386/math-emu/status_w.h        |    5 +++--
> 
> ---
>  arch/i386/math-emu/status_w.h |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> --- linux-2620-rc2.orig/arch/i386/math-emu/status_w.h
> +++ linux-2620-rc2/arch/i386/math-emu/status_w.h
> @@ -48,9 +48,10 @@
>  
>  #define status_word() \
>    ((partial_status & ~SW_Top & 0xffff) | ((top << SW_Top_Shift) & SW_Top))
> -#define setcc(cc) ({ \
> -  partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
> -  partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); })
> +#define setcc(cc) do { \
> +	partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
> +	partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); \
> +} while (0)

Is there any reason you this shouldn't be an inline function?

