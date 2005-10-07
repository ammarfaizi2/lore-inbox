Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbVJGRyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbVJGRyy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 13:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030533AbVJGRyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 13:54:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25807 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030391AbVJGRyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 13:54:54 -0400
Message-ID: <4346B658.9010700@redhat.com>
Date: Fri, 07 Oct 2005 13:54:32 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Bruce Fields" <bfields@fieldses.org>
CC: Steve Dickson <SteveD@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH] kNFSD - Allowing rpc.nfsd to setting of the port,
 transport and version the server will use
References: <43469FA7.7020908@RedHat.com> <20051007164435.GC9759@fieldses.org>
In-Reply-To: <20051007164435.GC9759@fieldses.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Bruce Fields wrote:

>On Fri, Oct 07, 2005 at 12:17:43PM -0400, Steve Dickson wrote:
>  
>
>>Here is a kernel patch that will enable the setting
>>of the port knfsd will listens on, the transport knfsd
>>will support and which NFS version will be advertised.
>>
>>The nfs-utils patch, which is also attached, will added
>>the following flags to rpc.nfsd that will enable the kernel
>>functionality (Note: These patches are NOT dependent on each
>>other. Meaning rpc.nfsd and knfsd will still function correctly
>>if one or the other patch do or do not exist):
>>
>>
>>   -N  or  --no-nfs-version vers
>>        This option can be used to request that rpc.nfsd does not  offer
>>        certain  versions of NFS. The current version of rpc.nfsd can
>>        support both NFS version 2,3 and the newer version 4.
>>    
>>
>
>So the obvious question is what will happen if someone does
>
>	rpc.nfsd -N 3
>
>on a server supporting 2, 3, and 4.
>
>It looks like the code in svc_create() will set pg_lovers to 2 and
>pg_hivers to 4 in that case.  So if someone tries to use version 3, the
>error they get back will be a somewhat contradictory "sorry, I only
>support versions 2 through 4."
>
>It seems to me that it'd be cleaner if the kernel interface only
>accepted a range (e.g., "2--4" or "2--3").  Then if someone
>attempted the above, they'll get an error back immediately.
>
>Or svc_create could be adjusted to report a more conservative range
>("2--2" or "4--4" instead of "2--4").
>
>But I don't have really strong feelings about it.  Maybe we shouldn't
>care enough about that case.
>

Well, you are right, it seems contradictory, but it is the right thing
to do in such a situation.  It follows the RPC semantics as defined.
(I suspect that Bob didn't consider something like this when he was
designing this part of RPC.)

I would suggest that doing this to an NFS server would be pretty silly,
not done very much if at all, and not something to care about.

It also isn't the first time that such a situation has occurred.  SGI
used to have a MOUNT version 99 (or some such value) and responses such
as this could be seen from their server at times.

    Thanx...

       ps
