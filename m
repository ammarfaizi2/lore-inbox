Return-Path: <linux-kernel-owner+w=401wt.eu-S1750739AbXACMgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbXACMgh (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 07:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbXACMgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 07:36:36 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:32776 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750730AbXACMgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 07:36:35 -0500
Message-ID: <459BA30A.4020809@panasas.com>
Date: Wed, 03 Jan 2007 14:35:22 +0200
From: Benny Halevy <bhalevy@panasas.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, nfsv4@ietf.org,
       linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@poochiereds.net>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [nfsv4] RE: Finding hardlinks
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>	 <1166869106.3281.587.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>	 <4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net>	 <4593DEF8.5020609@panasas.com>	 <Pine.LNX.4.64.0612281916230.2960@artax.karlin.mff.cuni.cz>	 <E472128B1EB43941B4E7FB268020C89B149CEC@riverside.int.panasas.com>	 <1167388129.6106.45.camel@lade.trondhjem.org>	 <E472128B1EB43941B4E7FB268020C89B149CF1@riverside.int.panasas.com> <1167780097.6090.104.camel@lade.trondhjem.org>
In-Reply-To: <1167780097.6090.104.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jan 2007 12:35:02.0712 (UTC) FILETIME=[9708C380:01C72F33]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Sun, 2006-12-31 at 16:25 -0500, Halevy, Benny wrote:
>> Trond Myklebust wrote:
>>>  
>>> On Thu, 2006-12-28 at 15:07 -0500, Halevy, Benny wrote:
>>>> Mikulas Patocka wrote:
>>>>> BTW. how does (or how should?) NFS client deal with cache coherency if 
>>>>> filehandles for the same file differ?
>>>>>
>>>> Trond can probably answer this better than me...
>>>> As I read it, currently the nfs client matches both the fileid and the
>>>> filehandle (in nfs_find_actor). This means that different filehandles
>>>> for the same file would result in different inodes :(.
>>>> Strictly following the nfs protocol, comparing only the fileid should
>>>> be enough IF fileids are indeed unique within the filesystem.
>>>> Comparing the filehandle works as a workaround when the exported filesystem
>>>> (or the nfs server) violates that.  From a user stand point I think that
>>>> this should be configurable, probably per mount point.
>>> Matching files by fileid instead of filehandle is a lot more trouble
>>> since fileids may be reused after a file has been deleted. Every time
>>> you look up a file, and get a new filehandle for the same fileid, you
>>> would at the very least have to do another GETATTR using one of the
>>> 'old' filehandles in order to ensure that the file is the same object as
>>> the one you have cached. Then there is the issue of what to do when you
>>> open(), read() or write() to the file: which filehandle do you use, are
>>> the access permissions the same for all filehandles, ...
>>>
>>> All in all, much pain for little or no gain.
>> See my answer to your previous reply.  It seems like the current
>> implementation is in violation of the nfs protocol and the extra pain
>> is required.
> 
> ...and we should care because...?
> 
> Trond
> 

Believe it or not, but server companies like Panasas try to follow the standard
when designing and implementing their products while relying on client vendors
to do the same.

I sincerely expect you or anybody else for this matter to try to provide
feedback and object to the protocol specification in case they disagree
with it (or think it's ambiguous or self contradicting) rather than ignoring
it and implementing something else. I think we're shooting ourselves in the
foot when doing so and it is in our common interest to strive to reach a
realistic standard we can all comply with and interoperate with each other.

Benny

