Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbVDAOqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVDAOqU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 09:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbVDAOqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 09:46:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18067 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262751AbVDAOoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 09:44:23 -0500
Subject: Re: [RFC] CryptoAPI & Compression
From: David Woodhouse <dwmw2@infradead.org>
To: "Artem B. Bityuckiy" <dedekind@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org>
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au>
	 <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org>
Content-Type: text/plain
Date: Fri, 01 Apr 2005 15:44:06 +0100
Message-Id: <1112366647.3899.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 at 15:36 +0100, Artem B. Bityuckiy wrote:
> In our code we do zlib_deflate(stream, Z_SYNC_FLUSH), so we always flush 
> the output. So the final zlib_deflate(stream, Z_FINISH) requires 1 byte 
> for the EOB marker and 4 bytes for adler32 (5 bytes total). Thats all. If 
> we compress a huge buffer, then we still need to output those 5 bytes as 
> well. I.e, the overhead of each block *is not accumulated* ! I even need 
> to make the reserved space less then 12 bytes!

Hm. Could we avoid using Z_SYNC_FLUSH and stick with a larger amount?
That would give us better compression.

-- 
dwmw2

