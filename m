Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTIASfk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263649AbTIASfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:35:40 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:33421 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263183AbTIASf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:35:29 -0400
Date: Mon, 1 Sep 2003 20:35:27 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] mtime&ctime updated when it should not
Message-ID: <20030901183527.GB21251@DUK2.13thfloor.at>
Mail-Followup-To: Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
References: <20030901181113.GA15672@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901181113.GA15672@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 08:11:13PM +0200, Jan Kara wrote:
>   Hello,
> 
>   one user pointed my attention to the fact that when the write fails
> (for example when the user quota is exceeded) the modification time is
> still updated (the problem appears both in 2.4 and 2.6). According to
> SUSv3 that should not happen because the specification says that mtime
> and ctime should be marked for update upon a successful completition
> of a write (not that it would forbid updating the times in other cases
> but I find it at least a bit nonintuitive).
>   The easiest fix would be probably to "backup" the times at the
> beginning of the write and restore the original values when the write
> fails (simply not updating the times would require more surgery because
> for example vmtruncate() is called when the write fails and it also
> updates the times).
>   So should I write the patch or is the current behaviour considered
> correct?

hmm, what if the request only partially succeeds?

for example echo "five" >/tmp/x will create /tmp/x
if inode limit permits it, but will leave it empty
if the space limit does not ...

personally I wouldn't care about the modification
time on such a quota fault ...

best,
Herbert

> 								Honza
> 
> -- 
> Jan Kara <jack@suse.cz>
> SuSE CR Labs
