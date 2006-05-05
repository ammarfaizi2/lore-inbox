Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbWEELDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWEELDN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 07:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWEELDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 07:03:13 -0400
Received: from cantor2.suse.de ([195.135.220.15]:39879 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030356AbWEELDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 07:03:13 -0400
From: Andi Kleen <ak@suse.de>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
Date: Fri, 5 May 2006 13:02:42 +0200
User-Agent: KMail/1.9.1
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, herbert@13thfloor.at,
       dev@sw.ru, linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
References: <20060501203906.XF1836@sergelap.austin.ibm.com> <200605021930.45068.ak@suse.de> <20060503161143.GA18576@sergelap.austin.ibm.com>
In-Reply-To: <20060503161143.GA18576@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605051302.43019.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But, either the nsproxy is shared between tasks and you need to copy
> youself a new one as soon as any ns changes

That would be the case. But it is only shared between tasks where 
all the name spaces are the same.

> , or it is not shared, and 
> you don't need  that info at all (just make the change in the nsproxy
> immediately)

Don't follow you here.

Basically the goal is to have a minimum number of nsproxies in the system without
having to maintain a global hash table. So instead you assume that name space
changes are infrequent. In the common case of clone without a name space change
you just share the nsproxy of the parent. If there is a name space change of
any kind you get a new one.

This won't get the absolute minimum number of nsproxies, but should be reasonably
good without too much effort.

-Andi

> 
