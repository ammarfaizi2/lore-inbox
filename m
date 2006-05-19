Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWESQlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWESQlo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 12:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWESQlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 12:41:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22234 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751342AbWESQln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 12:41:43 -0400
Date: Fri, 19 May 2006 09:40:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: herbert@13thfloor.at, serue@us.ibm.com, linux-kernel@vger.kernel.org,
       dev@sw.ru, devel@openvz.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [PATCH 0/9] namespaces: Introduction
Message-Id: <20060519094047.425dced1.akpm@osdl.org>
In-Reply-To: <m1iro2yo7f.fsf@ebiederm.dsl.xmission.com>
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518103430.080e3523.akpm@osdl.org>
	<20060519124235.GA32304@MAIL.13thfloor.at>
	<20060519081334.06ce452d.akpm@osdl.org>
	<m1iro2yo7f.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>  > Herbert Poetzl <herbert@13thfloor.at> wrote:
>  >>
>  >> let me
>  >>  give a simple example here:
>  >
>  > Examples are useful.
>  >
>  >>   "pid virtualization"
>  >> 
>  >>   - Linux-VServer doesn't really need that right now.
>  >>     we are perfectly fine with "pid isolation" here, we
>  >>     only "virtualize" the init pid to make pstree happy
>  >> 
>  >>   - Snapshot/Restart and Migration will require "full"
>  >>     pid virtualization (that's where Eric and OpenVZ
>  >>     are heading towards)
>  >
>  > snapshot/restart/migration worry me.  If they require complete
>  > serialisation of complex kernel data structures then we have a problem,
>  > because it means that any time anyone changes such a structure they need to
>  > update (and test) the serialisation.
> 
>  There is a strict limit to what is user visible, and if it isn't user visible
>  we will never need it in a checkpoint.  So internal implementation details
>  should not matter.

Migration of currently-open sockets (for example) would require storing of
a lot of state, wouldn't it?
