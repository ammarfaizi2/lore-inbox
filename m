Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWEELnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWEELnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 07:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWEELnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 07:43:41 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:10372 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030325AbWEELnk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 07:43:40 -0400
Date: Fri, 5 May 2006 06:43:38 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, herbert@13thfloor.at,
       dev@sw.ru, linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
Message-ID: <20060505114338.GA12850@sergelap.austin.ibm.com>
References: <20060501203906.XF1836@sergelap.austin.ibm.com> <200605021930.45068.ak@suse.de> <20060503161143.GA18576@sergelap.austin.ibm.com> <200605051302.43019.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605051302.43019.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andi Kleen (ak@suse.de):
> 
> > But, either the nsproxy is shared between tasks and you need to copy
> > youself a new one as soon as any ns changes
> 
> That would be the case. But it is only shared between tasks where 
> all the name spaces are the same.

Ok, that is how I was thinking.

> > , or it is not shared, and 
> > you don't need  that info at all (just make the change in the nsproxy
> > immediately)
> 
> Don't follow you here.
> 
> Basically the goal is to have a minimum number of nsproxies in the system without
> having to maintain a global hash table. So instead you assume that name space
> changes are infrequent. In the common case of clone without a name space change
> you just share the nsproxy of the parent. If there is a name space change of
> any kind you get a new one.
> 
> This won't get the absolute minimum number of nsproxies, but should be reasonably
> good without too much effort.

Ok.  Then I maintain that the bitmap of changed namespaces seems
unnecessary.  Since you're likely sharing an nsproxy with your parent
process, when you clone a new namespace you just want to immediately get
a new nsproxy pointing to the new namespaces.

Anyway this seems simple enough to just code up.  Simpler than
continuing to talk about it  :)

-serge
