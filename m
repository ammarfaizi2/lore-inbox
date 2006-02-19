Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWBSQSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWBSQSF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 11:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWBSQSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 11:18:05 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:7662 "EHLO sunrise.pg.gda.pl")
	by vger.kernel.org with ESMTP id S1750844AbWBSQSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 11:18:04 -0500
Date: Sun, 19 Feb 2006 17:16:43 +0100
From: Adam Tla/lka <atlka@pg.gda.pl>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
Message-ID: <20060219161643.GA15459@sunrise.pg.gda.pl>
References: <20060217233333.GA5208@sunrise.pg.gda.pl> <20060218025921.7456e168.akpm@osdl.org> <43F744C6.8020209@pg.gda.pl> <43F7F2FA.2060102@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43F7F2FA.2060102@ums.usu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 09:24:26AM +0500, Alexander E. Patrakov wrote:
> Adam TlaÅ‚ka wrote:
> 
> >Maybe I should remember all bytes of the UTF-sequence to use their 
> >values as a last resort char in case of malformed sequence and 0xfffd
> >not defined?
> 
> Please don't do that. Display question marks instead in the case when 
> 0xfffd is not defined.

Look at the original code. If conv_uni_to_pc fails and there is no replacement
char (after a clear_unimap for example) and we using US-ASCII we rather
should see something then sequences of '?' chars.
Maybe I could change this to:

if (tc == -4) {
	if (c < 128)
		tc = c;
	else
		tc = '?';
}

What about that?

Remembering of original bytes is needed if we could then remember
them in a way so paste from screen gives us the same sequence as it was
in input. With current console design it is impossible is case
of correct UTF-8 sequences containing undisplayable glyphs or malformed
sequences. So I can remove that part of patch and it will wait until
this functionality will be implemented - not so easy but can
be done IMHO and worth it to obtain properly working selection
and copying in UTF-8 mode.

Regards
-- 
Adam Tla³ka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdañsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl
