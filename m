Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265811AbUFSEYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265811AbUFSEYj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 00:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUFSEYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 00:24:39 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:48650 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265811AbUFSEYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 00:24:36 -0400
Date: Sat, 19 Jun 2004 06:18:44 +0200
From: Willy Tarreau <willy@w.ods.org>
To: matthew-lkml@newtoncomputing.co.uk
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop printk printing non-printable chars
Message-ID: <20040619041844.GG29808@alpha.home.local>
References: <20040618205355.GA5286@newtoncomputing.co.uk> <Pine.LNX.4.58.0406181407330.6178@ppc970.osdl.org> <Pine.LNX.4.56.0406190032290.17899@jjulnx.backbone.dif.dk> <20040618235223.GB5286@newtoncomputing.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618235223.GB5286@newtoncomputing.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jun 19, 2004 at 12:52:23AM +0100, matthew-lkml@newtoncomputing.co.uk wrote:
>  /*
> + * Emit character in numeric (octal) form
> + */

Don't most of us handle hex easier than octal ? I'd prefer to read \xE9
than \351, but that's only personal taste.

> -		emit_log_char(*p);
> +		switch (*p) {
> +			case '\n':
> +			case '\t':
> +				emit_log_char(*p);
> +				break;

Logically, ig you use '\' as an escape char, your should also protect it
to avoid confusion, because if you read "\351", you won't know if the
function really sent these four chars or only the \xE9 char.

Another way to do it would be to display "<XX>" like less, but '<' and '>'
are sensible because they're used to indicate the log level.

Regards,
Willy

