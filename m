Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVCTKxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVCTKxo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 05:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVCTKxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 05:53:44 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:21344 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261678AbVCTKxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 05:53:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=YVtjdzMd/bdDEGQ2T4t5DBhsTQc3fMohxR4VLjdAfyg2OE3GFz6T4jeH2YgVpeJg6+b+16N1tQLtbQBEgVOBuGC0EVKTVwE2qohEgkNXTsMIBfGi/BoEOPjK07QHbjFmDBPnWCG/tWTBNzPhYMUIitkgwFo1gPqrcFZXpP8/dnk=
Message-ID: <aec7e5c3050320025323257b20@mail.gmail.com>
Date: Sun, 20 Mar 2005 11:53:42 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] disable builtin modules
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0503201049190.24849@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050319230648.19238.42743.71351@clementine.local>
	 <Pine.LNX.4.61.0503201049190.24849@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2005 10:51:41 +0100 (MET), Jan Engelhardt
<jengelh@linux01.gwdg.de> wrote:
> 
> >This patch makes it possible to disable built in code from the kernel
> >command line. The patch is rather simple - it extends the compiled-in case
> >of module_init() to include __setup() with a name based on KBUILD_MODNAME.
> 
> What if there is already an option like the modname? I do not know of any
> code that currently does so, but you never know.
> 
> Are acpi= and apm= already what your patch wants to extend to other modules?
> If not, there's conflict.

There is a conflict. Thanks for pointing that out.

Both the obsolete __setup() parameter code and the module parameter
code in kernel/params.c are limited to a single matching parameter.
The first matching parameter will be used, and non-early obsoleted
parameters are overridden by module parameter code. If I understand
the code correctly that is. =)

Maybe it is possible to (mis)use early_param instead of __setup and
let these parameters become "high priority" parameters that only are
parsed by do_early_param()...?

/ magnus
