Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbUCHShx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 13:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbUCHShx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 13:37:53 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:60911 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262521AbUCHShs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 13:37:48 -0500
Message-ID: <404CBD79.6090108@mvista.com>
Date: Mon, 08 Mar 2004 10:37:45 -0800
From: Steve Longerbeam <stevel@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen M. Kenton" <skenton@ou.edu>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: new special filesystem for consideration in 2.6/2.7
References: <404BB931.1D3C83E8@ou.edu>
In-Reply-To: <404BB931.1D3C83E8@ou.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephen M. Kenton wrote:

>>>If the recent news about giga-bit mram being a real possibility in
>>>the not too far future pans out, this may be get more important.
>>>      
>>>
>
>  
>
>>This is a reality in embedded devices.  Go read the message again...
>>    
>>
>
>Umm, yes and no.  I did not mean to dis this proposal because I think it
>is worthwhile.  Rather, I was thinking about the problems with really
>large amounts of data.  I don't really think that a few Kilo or Mega
>bytes of data  needs the same sort of infrastructure that will be
>required
>for Tera or Peta bytes.  As an extreme example the few bytes of nv ram
>in the
>cmos clock chips in the original PC/AT did not require much support
>while
>the multiple terabytes of data in my raid farm at work would be very
>vulnerable under this proposal since a rogue process could cause lots of
>damage in very sort order as would losing a memory bank to hardware
>failure.
>
>In the last discussion I saw on the topic on lkml, there was discussion
>about
>whether to even preserve the volume/directory/file abstraction at all
>for
>memory mapped data spaces.  That discussion was quite speculative given
>the lack of affordable *really large* nvram type storage to compete with
>100+ gigabyte disks and even larger raids.  That situation may be
>changing.
>Hence, this may become more important.
>

Hi Steve, I should note that pramfs was not designed with *really large* 
nvram
storage in mind. It was more designed to use space efficiently on small 
amounts
of nvram. For instance, pramfs inodes only have a 2-d block pointer table
(vs ext2/ext3's 3-d i_block[14] pointer table), so the max file size is 
(b/4)^2
blocks or b^3/16 bytes, b being the blocksize. Also, offsets within the 
fs are unsigned
long's, so there's a 4 gig limit already on 32-bit machines.

So in short, for 10s or even 100s of MB, pramfs is fine, but for GB or more
storage it's not an appropriate fs.

Steve


