Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTEHWRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTEHWRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:17:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46473
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262165AbTEHWRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:17:39 -0400
Subject: Re: [PATCH][2.4] cleanup ptrace secfix and fix most side effects
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bernhard Kaindl <bk@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Bernhard Kaindl <bernhard.kaindl@gmx.de>
In-Reply-To: <Pine.LNX.4.44.0305082310230.12720-200000@wotan.suse.de>
References: <Pine.LNX.4.44.0305082310230.12720-200000@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052429495.13567.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 22:31:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-08 at 23:05, Bernhard Kaindl wrote:
> -	mb();
> -	if (!is_dumpable(child))
> -		return -EPERM;
> 
>  	if (!(child->ptrace & PT_PTRACED))
>  		return -ESRCH;
> 
> Using is_dumpable() here is not neccesary because the checks done here are:
> 
> >        if (!(child->ptrace & PT_PTRACED))
> >                return -ESRCH;

Except that current->mm->dumpable is not per task but per mm so you
might ptrace one thread and have another go setuid.


