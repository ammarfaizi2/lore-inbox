Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVASQ5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVASQ5G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 11:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVASQ5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 11:57:05 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:57992 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261775AbVASQyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 11:54:04 -0500
Message-ID: <41EE909F.5010600@comcast.net>
Date: Wed, 19 Jan 2005 10:53:51 -0600
From: Tom Zanussi <zanussi@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Tom Zanussi <zanussi@us.ibm.com>, karim@opersys.com,
       Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
       Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       frankeh@watson.ibm.com
Subject: Re: 2.6.11-rc1-mm1
References: <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de> <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home> <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home> <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home> <41EA0307.6020807@opersys.com> <16874.47855.427013.376104@tut.ibm.com> <20050119111405.GC12903@infradead.org>
In-Reply-To: <20050119111405.GC12903@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, Jan 16, 2005 at 01:05:19PM -0600, Tom Zanussi wrote:
> 
>>One of the things that uses these functions to read from a channel
>>from within the kernel is the relayfs code that implements read(2), so
>>taking them away means you wouldn't be able to use read() on a relayfs
>>file.
> 
> 
> Removing them from the public API is different from disallowing the
> read operation.
> 

Right, but we were planning on removing all that code in the interest of 
    stripping relayfs down to its bare minimum as a high-speed data 
transfer mechanism.

> 
>>That wouldn't matter for ltt since it mmaps the file, but there
>>are existing users of relayfs that do use relayfs this way.  In fact,
>>most of the bug reports I've gotten are from people using it in this
>>mode.  That doesn't mean though that it's necessarily the right thing
>>for relayfs or these users to be doing if they have suitable
>>alternatives for passing lower-volume messages in this way.  As others
>>have mentioned, that seems to be the major question - should relayfs
>>concentrate on being solely a high-speed data relay mechanism or
>>should it try to be more, as it currently is implemented?
> 
> 
> I'd say let it do one thing well, that is high-volume data transfer.

Yes, I think that's the one thing everyone's agreed on.

> 
> 
>>If the
>>former, then I wonder if you need a filesystem at all - all you have
>>is a collection of mmappable buffers and the only thing the filesystem
>>provides is the namespace.  Removing read()/write() and filesystem
>>support would of course greatly simplify the code; I'd like to hear
>>from any existing users though and see what they'd be missing.
> 
> 
> What else would manage the namespace?

I have to confess I haven't had the time to look at it in detail, but I 
previously suggested that we might be able to recover the read() 
operations by providing them in userspace on top of the mmapped relayfs 
buffer, using FUSE.  If we did that, our FUSE filesystem could also 
provide the namespace, I assume.

Anyway, I don't think I've seen any objections in principal to the 
filesystem part of relayfs, so maybe it's not an issue - any other 
suggestions would be welcome, of course...

Tom

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

