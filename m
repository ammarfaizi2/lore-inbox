Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWESQ3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWESQ3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 12:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWESQ3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 12:29:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16301 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751044AbWESQ3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 12:29:25 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Herbert Poetzl <herbert@13thfloor.at>, serue@us.ibm.com,
       linux-kernel@vger.kernel.org, dev@sw.ru, devel@openvz.org,
       sam@vilain.net, xemul@sw.ru, haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [PATCH 0/9] namespaces: Introduction
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518103430.080e3523.akpm@osdl.org>
	<20060519124235.GA32304@MAIL.13thfloor.at>
	<20060519081334.06ce452d.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 19 May 2006 10:27:32 -0600
In-Reply-To: <20060519081334.06ce452d.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 19 May 2006 08:13:34 -0700")
Message-ID: <m1iro2yo7f.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Herbert Poetzl <herbert@13thfloor.at> wrote:
>>
>> let me
>>  give a simple example here:
>
> Examples are useful.
>
>>   "pid virtualization"
>> 
>>   - Linux-VServer doesn't really need that right now.
>>     we are perfectly fine with "pid isolation" here, we
>>     only "virtualize" the init pid to make pstree happy
>> 
>>   - Snapshot/Restart and Migration will require "full"
>>     pid virtualization (that's where Eric and OpenVZ
>>     are heading towards)
>
> snapshot/restart/migration worry me.  If they require complete
> serialisation of complex kernel data structures then we have a problem,
> because it means that any time anyone changes such a structure they need to
> update (and test) the serialisation.

There is a strict limit to what is user visible, and if it isn't user visible
we will never need it in a checkpoint.  So internal implementation details
should not matter.

> This may be a show-stopper, in which case maybe we only need to virtualise
> pid #1.

Except we do need something for pid isolation, and a pid namespace is
quite possibly the light weight solution.  If you can't see the pid it is
clearly isolated from you.

> Anyway.  Thanks, guys.  It sound like most of this work will be nicely
> separable so we can think about each bit as it comes along.

Yes, and there are enough issues it is significant.

Eric
