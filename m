Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWF1PHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWF1PHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWF1PHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:07:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45734 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751165AbWF1PHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:07:04 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       viro@ftp.linux.org.uk
Subject: Re: [patch 3/4] Network namespaces: IPv4 FIB/routing in namespaces
References: <20060626134945.A28942@castle.nmd.msu.ru>
	<20060626135250.B28942@castle.nmd.msu.ru>
	<20060626135427.C28942@castle.nmd.msu.ru>
	<449FF5AE.2040201@fr.ibm.com> <44A28964.2090006@fr.ibm.com>
Date: Wed, 28 Jun 2006 09:05:50 -0600
In-Reply-To: <44A28964.2090006@fr.ibm.com> (Daniel Lezcano's message of "Wed,
	28 Jun 2006 15:51:32 +0200")
Message-ID: <m1ejx9gw1d.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Lezcano <dlezcano@fr.ibm.com> writes:

> Daniel Lezcano wrote:
>> Andrey Savochkin wrote:
>>
>>> Structures related to IPv4 rounting (FIB and routing cache)
>>> are made per-namespace.
>
> Hi Andrey,
>
> if the ressources are private to the namespace, how do you will handle NFS
> mounted before creating the network namespace ? 

Through the filesystem namespace.  It is a weird case but it works :)

> Do you take care of that or simply assume you can't access NFS anymore ?

It is actually a noop.  Unless I goofed this is basically handled by
looking at which socket NFS is using to communicate, and plucking the 
namespace from there.

As I recall NFS gets the socket at mount time when it still has user
space context available.

So regardless if I implemented it correctly you can implement it that way
and always get the namespace context from whoever implemented it.

Eric
