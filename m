Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVCZHuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVCZHuP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 02:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVCZHuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 02:50:15 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:61805 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262021AbVCZHuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 02:50:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qxYoKThpn21Bx2qs1D+ArTjT5RqFJSrfbOSDk9og2EVeFhcLEenafNNMrrL1j5GmfH95LdBXXGQU9YLifC7/CEyJrwjMwvk2+e98Kayb6D84TRytBi2oPzQ5vL8zTaJIY281nWdPqF9Efk2yeLKL8KuidL36ibQPKkY5Y/H3/ns=
Message-ID: <84144f020503252350550cd23b@mail.gmail.com>
Date: Sat, 26 Mar 2005 09:50:11 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: linux-os@analogic.com
Subject: Re: [PATCH] no need to check for NULL before calling kfree() - fs/ext2/
Cc: Jesper Juhl <juhl-lkml@dif.dk>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi
In-Reply-To: <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
	 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 25 Mar 2005 17:29:56 -0500 (EST), linux-os
<linux-os@analogic.com> wrote:
> Isn't it expensive of CPU time to call kfree() even though the
> pointer may have already been freed? I suggest that the check
> for a NULL before the call is much less expensive than calling
> kfree() and doing the check there. The resulting "double check"
> is cheap, compared to the call.

Resource release paths are usually not performance critical. However,
if removing the redundant checks introduce a _measurable_ regressions
in terms of performance, we can make kfree() inline which will take
care of it.

                           Pekka
