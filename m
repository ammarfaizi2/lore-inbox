Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269692AbUHZVXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269692AbUHZVXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269660AbUHZVT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:19:58 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:6280 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S269680AbUHZVRF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:17:05 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Christophe Saout <christophe@saout.de>
Cc: Rik van Riel <riel@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Date: Thu, 26 Aug 2004 14:05:47 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <1093536282.5482.6.camel@leto.cs.pocnet.net>
Message-ID: <Pine.LNX.4.60.0408261348370.27825@dlang.diginsite.com>
References: <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com>
 <1093536282.5482.6.camel@leto.cs.pocnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Christophe Saout wrote:

> Am Donnerstag, den 26.08.2004, 11:54 -0400 schrieb Rik van Riel:
>
>>>> And if you read test.compound (the main stream) you get a special format
>>>> that contains all the components. You can copy that single stream of
>>>> bytes to another (reiser4) fs and then access test.compound/test.txt
>>>> again.
>>>
>>> (To Rik especially), this is the design which more or less satisfies
>>> lots of different goals at once.
>>
>> And if an unaware application reads the compound file
>> and then writes it out again, does the filesystem
>> interpret the contents and create the other streams ?
>>
>> Unless I overlook something (please tell me what), the
>> scheme just proposed requires filesystems to look at
>> the content of files that is being written out, in
>> order to make the streams work.
>
> Yes, the main compound stream unaware applications would see would just
> be a writable view of its contents. Probably not trivial to implement
> but doable.
>
> It should be a simple format. Something simliar to tar. The worst thing
> that can happen is people start writing plugins for every existing
> compound format out there. It should be the other way around, agree on a
> simple compound format and encourage applications to use this one if the
> want to use this advantage.
>

I also don't see why the VFS/Filesystem can't decide that (for example) 
this tar.gz is so active that instead of storing it as a tar.gz and 
providing a virtual directory of the contents that it instead stores the 
directory of the contents and makes the tar.gz virtual (regenerating it as 
needed or as extra system resources are available)

implementation wise I see headaches in doing this, but conceptually this 
is just an optimization that could take place in the future if we fine 
that it's needed.

David Lang

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
