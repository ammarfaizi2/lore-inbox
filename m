Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVIWSby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVIWSby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVIWSby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:31:54 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:32863 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751128AbVIWSby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:31:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=HJbGv7oj98vhRUPyPEcsuw2tE6GoLoa4XZ6pbxYaYfYxzbY9W7DqqHZw0NJVykORzz+P9oMxTXtRkGhN1QLhtHV3IHuzDTP++QXe6gxeX4R8pKFN/RnlFIeF4DGQaZ/plsHiIdpxEwhqDwXrHa3bb9IGOf8IowEsykJmOK4Tygw=
Date: Fri, 23 Sep 2005 22:42:16 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: tty update speed regression (was: 2.6.14-rc2-mm1)
Message-ID: <20050923184216.GA6452@mipter.zuzino.mipt.ru>
References: <20050921222839.76c53ba1.akpm@osdl.org> <20050922195029.GA6426@mipter.zuzino.mipt.ru> <20050922214926.GA6524@mipter.zuzino.mipt.ru> <20050923000815.GB2973@us.ibm.com> <29495f1d050923101228384a34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d050923101228384a34@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 10:12:11AM -0700, Nish Aravamudan wrote:
> I did not see any tty refresh problems on my TP with HZ=250 under
> 2.6.14-rc2-mm1 (excuse the typo in my previous response) under the
> adom binary you sent me. I even played two games just to make sure ;)

The slowdown is HZ dependent:
* HZ=1000 - game is playable. If I would not know slowdown is there I
  wouldn't notice it.
* HZ=100 - messages at the top are printed r e a l l y  s l o w.
* HZ=250 - somewhere in the middle.

> Is there any chance you can do an strace of the process while it is
> slow to redraw your screen?

Typical pattern is:

rt_sigaction(SIGTSTP, {SIG_IGN}, {0xb7f1e578, [], SA_RESTART}, 8) = 0
poll([{fd=0, events=POLLIN}], 1, 0) = 0
poll([{fd=0, events=POLLIN}], 1, 0) = 0
write(1, "\33[11;18H\33[37m\33[40m[g] Gnome\r\33[12"..., 58) = 58
rt_sigaction(SIGTSTP, {0xb7f1e578, [], SA_RESTART}, NULL, 8) = 0
rt_sigaction(SIGTSTP, {SIG_IGN}, {0xb7f1e578, [], SA_RESTART}, 8) = 0
poll([{fd=0, events=POLLIN}], 1, 0) = 0
poll([{fd=0, events=POLLIN}], 1, 0) = 0
write(1, "\33[12;18H\33[37m\33[40m[h] Hurthling\r"..., 62) = 62
rt_sigaction(SIGTSTP, {0xb7f1e578, [], SA_RESTART}, NULL, 8) = 0
rt_sigaction(SIGTSTP, {SIG_IGN}, {0xb7f1e578, [], SA_RESTART}, 8) = 0
poll([{fd=0, events=POLLIN}], 1, 0) = 0
poll([{fd=0, events=POLLIN}], 1, 0) = 0
write(1, "\33[13;18H\33[37m\33[40m[i] Orc\r\33[14d\33"..., 56) = 56
rt_sigaction(SIGTSTP, {0xb7f1e578, [], SA_RESTART}, NULL, 8) = 0
rt_sigaction(SIGTSTP, {SIG_IGN}, {0xb7f1e578, [], SA_RESTART}, 8) = 0

I can send full strace log if needed.

