Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbVIVTrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbVIVTrH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbVIVTrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:47:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62642 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030196AbVIVTrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:47:05 -0400
Message-ID: <43330A17.4050305@redhat.com>
Date: Thu, 22 Sep 2005 15:46:31 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Lever, Charles" <Charles.Lever@netapp.com>, SteveD@redhat.com,
       NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [NFS] Re: [PATCH] repair nfsd/sunrpc in 2.6.14-rc2-mm1 (and other
 -mm versions)
References: <044B81DE141D7443BCE91E8F44B3C1E288E488@exsvl02.hq.netapp.com> <20050922123150.7a147d1e.akpm@osdl.org>
In-Reply-To: <20050922123150.7a147d1e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>"Lever, Charles" <Charles.Lever@netapp.com> wrote:
>  
>
>>>-----Original Message-----
>>>      
>>>
>> > From: Steve Dickson [mailto:SteveD@redhat.com] 
>> > Sent: Thursday, September 22, 2005 10:02 AM
>> > To: linux-kernel
>> > Cc: NFS@lists.sourceforge.net
>> > Subject: [NFS] Re: [PATCH] repair nfsd/sunrpc in 
>> > 2.6.14-rc2-mm1 (and other -mm versions)
>> > 
>> > Max Kellermann wrote:
>> > > Your -mm patches make the sunrpc client connect to the 
>> > portmapper with
>> > > a non-privileged source port.  This is due to a change in
>> > > net/sunrpc/pmap_clnt.c, which manually resets the xprt->resvport
>> > > field.  My tiny patch removes this line.  I have no idea 
>> > why the line
>> > > was added in the first place, does somebody know better?
>> > Yes this is a bug, since most Linux portmapper will not
>> > allow ports to be set or unset using non-privilege ports.
>> > But non-privilege ports can be used to get ports information.
>> > So I would suggest the following patch that stops the
>> > use of privileges ports on only get port requests.
>>
>> this was my patch (idea was steve's).  i've already sent a fix to
>> andrew.  andrew please let me know if you haven't received it.
>>    
>>
>
>Ah, good.  Please resend?
>

Actually, Chuck's patch and Steve's aren't quite the same.  Both patches
fix the problem that the portmap daemon requires a request to set something
to come from a reserved port.  In addition to this, Steve's patch reduces
the number of reserved ports that the kernel requires.  This is the problem
that resulted in pmap_create() being incorrectly modified in the first 
place.
Steve's patch correctly puts the support in rpc_getport() where it belongs.

    Thanx...

       ps
