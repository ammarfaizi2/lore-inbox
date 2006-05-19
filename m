Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWESPOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWESPOf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 11:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWESPOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 11:14:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62652 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932344AbWESPOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 11:14:32 -0400
Date: Fri, 19 May 2006 08:13:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, ebiederm@xmission.com, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [PATCH 0/9] namespaces: Introduction
Message-Id: <20060519081334.06ce452d.akpm@osdl.org>
In-Reply-To: <20060519124235.GA32304@MAIL.13thfloor.at>
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518103430.080e3523.akpm@osdl.org>
	<20060519124235.GA32304@MAIL.13thfloor.at>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> wrote:
>
> let me
>  give a simple example here:

Examples are useful.

>   "pid virtualization"
> 
>   - Linux-VServer doesn't really need that right now.
>     we are perfectly fine with "pid isolation" here, we
>     only "virtualize" the init pid to make pstree happy
> 
>   - Snapshot/Restart and Migration will require "full"
>     pid virtualization (that's where Eric and OpenVZ
>     are heading towards)

snapshot/restart/migration worry me.  If they require complete
serialisation of complex kernel data structures then we have a problem,
because it means that any time anyone changes such a structure they need to
update (and test) the serialisation.

This may be a show-stopper, in which case maybe we only need to virtualise
pid #1.

>   - OpenSSI and *Mosix require system wide pid spaces
>     which probably could be implemented with virtual
>     pid spaces as well
> 
>   - many security addons provide something called pid
>     randomization, and I think they could probably
>     benefit from a virtual pid space, too

ok.

Anyway.  Thanks, guys.  It sound like most of this work will be nicely
separable so we can think about each bit as it comes along.
