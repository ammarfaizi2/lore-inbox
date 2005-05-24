Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVEXAmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVEXAmn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVEXAmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:42:24 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:63902 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261256AbVEXAkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:40:43 -0400
Message-ID: <429277CA.9050300@google.com>
Date: Mon, 23 May 2005 17:39:38 -0700
From: Mike Waychison <mikew@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost> <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost> <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <20050521134615.GB4274@mail.shareable.org> <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
>>>I still see a problem: what if old_nd.mnt is already detached, and
>>>bind is non-recursive.  Now it fails with EINVAL, though it used to
>>>work (and I think is very useful).
>>
>>Hey, you just made another argument for not detaching mounts when the
>>last task with that current->namespace exits, but instead detaching
>>mounts when the last reference to any vfsmnt in the namespace is dropped.
>>
>>Hint :)
> 
> 
> I have a better idea:
> 
>  - create a "dead_mounts" namespace.
>  - chain each detached mount's ->mnt_list on dead_mounts->list
>  - set mnt_namespace to dead_mounts
>  - export the list via proc through the usual mount list interface
> 
> The last would be a nice bonus: I've always wanted to see the list of
> detached, but not-yet destroyed mounts.
> 
> Does anybody see a problem with that?
> 

FWIW, all this stuff has already been done and posted here.

Detachable chunks of vfsmounts:
http://marc.theaimsgroup.com/?l=linux-fsdevel&m=109872862003192&w=2

'Soft' reference counts for manipulating vfsmounts without pinning them 
down:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109872797030644&w=2

Referencing vfsmounts in userspace using a file descriptor:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109871948812782&w=2

walking mountpoints in userspace: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=109875012510262&w=2

attaching mountpoints in userspace:
http://marc.theaimsgroup.com/?l=linux-fsdevel&m=109875063100111&w=2

detaching mountpoints in userspace:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109880051800963&w=2

getting info from a vfsmount:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109875135030473&w=2

Mike Waychison
