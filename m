Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268682AbUHYUlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268682AbUHYUlp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268677AbUHYUjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:39:23 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:58889 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268668AbUHYUgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:36:04 -0400
Date: Wed, 25 Aug 2004 21:35:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825213549.A11531@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
	Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>; from torvalds@osdl.org on Wed, Aug 25, 2004 at 01:22:55PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 01:22:55PM -0700, Linus Torvalds wrote:
> And yes, the semantics can _easily_ be solved in very unixy ways.
> 
> One way to solve it is to just realize that a final slash at the end 
> implies pretty strongly that you want to treat it as a directory. So what 
> you do is:
> 
>  - without the slash, a file-as-dir won't open with O_DIRECTORY (ENOTDIR)
>  - with the slash, it won't open _without_ O_DIRECTORY (EISDIR)
> 
> Problem solved. Very user-friendly, and very intuitive.

That would solve the O_DIRECTORY issue, the dentry aliasing still needs
work though with the semantics for link/unlink/rename.

Maybe Hans & you should start 2.7 to work this out? :)

