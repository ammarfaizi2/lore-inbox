Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbUL0XWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbUL0XWe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 18:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUL0XWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 18:22:34 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:10139 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261996AbUL0XWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 18:22:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pL/yCedIyKN4kzDRtM1Cg0po+044a9eq5kxR0lhg6CJd4wbnvWp3ysHMRJKNdX5/Qzl7vLA4OZnSlR5i6aV5RcattdLfAEqvr+O9JK1TIxyVHSgjhYRSzg+ffi2er/oqvQ7Ifv7MXoVSAt0k5N6CJ3zW/rn9Yw22Z4Zeat6yJEs=
Message-ID: <a36005b5041227152268e68af9@mail.gmail.com>
Date: Mon, 27 Dec 2004 15:22:32 -0800
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-VServer <vserver@list.linux-vserver.org>
Subject: Re: The Future of Linux Capabilities ...
In-Reply-To: <20041227014041.GA30550@mail.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041227014041.GA30550@mail.13thfloor.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004 02:40:41 +0100, Herbert Poetzl <herbert@13thfloor.at> wrote:
>   II)   add 32 (or more) sub-capabilities which depend
>         on the parent capability to be usable, and add
>         appropriate syscalls for them.
> 
>         example: CAP_IPC_LOCK gets two subcapabilities
>         (e.g. SCAP_SHM_LOCK and SCAP_MEM_LOCK) which

I won't try to say anything about III, but I is not really suitable,
it breaks code currently using capabilities.  Or at least makes them
less secure.  With sub-capabilities the interface diverges from the
POSIX capabilities interfaces, but at least one can keep backward
compatibilities.

An alternative would be to keep the existing capabilities, and add new
ones for all the cases which need splitting.  If the old value is
set/reset, all the split-out values are "magically" affected as well. 
This would help keeping the interfaces in line with POSIX and no
additions to the userlevel libcap would be needed.  Yes, new cap[gs]et
syscalls would be needed, but this fact is hidden from the user.
