Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWE1MIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWE1MIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 08:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWE1MIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 08:08:16 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:33672 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1750750AbWE1MIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 08:08:16 -0400
Message-ID: <348818092.32485@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sun, 28 May 2006 20:08:15 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/32] Adaptive readahead V14
Message-ID: <20060528120815.GB6478@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org
References: <348745084.15239@ustc.edu.cn> <44788C8A.2070900@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44788C8A.2070900@tls.msk.ru>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2006 at 09:29:46PM +0400, Michael Tokarev wrote:
> How the new readahead logic works with media read errors?
> Current linux behavior is questionable (it killed my dvd drive
> for example, due to too many retries to read a single bad block
> on a CD-Rom), it - I think - should be to stop reading ahead if
> an read error occurs, instead of re-trying, and only retry to
> read that block (if at all) when and only when an application
> asks for that block.  I'm unsure when it should "resume reading
> ahead" again (ie, like, setting ra to 0 on first error, and
> restoring it back if we trying to read past the bad block.. or
> set it to 0, and try to increase it on subsequent reads one by
> one back to the original value, or...) - but that's probably
> different story, for now, i think just setting ra to 0 on read
> error will be sufficient...

It's not quite reasonable for readahead to worry about media errors.
If the media fails, fix it. Or it will hurt read sooner or later.
