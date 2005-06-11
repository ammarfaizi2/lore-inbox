Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVFKQuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVFKQuK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVFKQuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:50:10 -0400
Received: from main.gmane.org ([80.91.229.2]:55976 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261736AbVFKQtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:49:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Assuming NULL
Date: Sat, 11 Jun 2005 18:49:16 +0200
Message-ID: <yw1x64wkkfeb.fsf@ford.inprovide.com>
References: <Pine.LNX.4.61.0506111823440.19223@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:ZKG3WFrSVj+kuwdpAUyxhSSUa30=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

> Hi developers,
>
> some places in fs/*.c have conditions like
>
> (namei.c, 238, in "int permission()"):
>         if(inode->i_op && inode->i_op->permission)
>
> Others just have
> (namei.c, 813, in "int fastcall link_path_walk()"):
>         if(!inode->i_op->lookup)
>
> My question is: Which one is right wrt the case "i_op ==/!= NULL"?
> There are two ways:
>
> - the kernel assumes i_op (and similar) is always non-NULL
>   => then we can remove a lot of checks, like the first example above
>
> - the kernel does not assume...
>   => then we need some extra checks, like in the second example above

And a third:

- in some places it's safe to assume non-NULL, but not always
  => then we need to check only the unsafe places

-- 
Måns Rullgård
mru@inprovide.com

