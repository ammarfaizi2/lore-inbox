Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937838AbWLGAgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937838AbWLGAgf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937840AbWLGAgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:36:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55764 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937838AbWLGAge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:36:34 -0500
Message-ID: <457760DD.5070601@redhat.com>
Date: Wed, 06 Dec 2006 19:31:25 -0500
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Ben Collins <ben.collins@ubuntu.com>
CC: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>	 <20061205184921.GA5029@martell.zuzino.mipt.ru>	 <4575FF08.2030100@redhat.com> <1165383349.7443.78.camel@gullible>	 <457685D1.1080501@s5r6.in-berlin.de> <1165416546.7443.111.camel@gullible>
In-Reply-To: <1165416546.7443.111.camel@gullible>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
...
>> I would like to see new development efforts take cleanliness WRT host
>> byte order and 64bit architectures into account from the ground up. (I
>> understand though why Kristian made the announcement in this early
>> phase, and I agree with him that this kind of development has to go into
>> the open early.)
> 
> And yet endianness is not the focus from the ground up in Kristian's
> work. That was my point.

I don't know what you base this on, it's not true.  Everything outside 
fw-ohci.c is endian aware and I know the two things I need to look into for 
fw-ohci: DMA programs and IEEE1394 headers.  My plan was to develop the stack 
towards feature completeness and then test on big-endian and 64-bit platforms.

If you're thinking of the bitfield problem BenH pointed out, that doesn't 
imply I didn't have endianess in mind when writing the code.  As Stefan 
already mentioned, we use bitfields for wire data in the current stack.  We 
have to sets of structs, one for big endian architectures and one for little 
endian architectures.  My plan was to write big endian versions of these 
structs and then test on various architectures.

So my bitfield approach doesn't work and I haven't gotten around to doing the 
big-endian testing yet, but don't mistake that for lack of endianess 
awareness.  Of course, big endian and 64-bit architectures *must* work, but I 
contend that it can impact the overall design of the stack.  It's a detail 
that you need to get right, not a design principle.  But let's not argue this 
further, I'll post a new set of patches in a few days that work on big-endian 
and 64-bit.

cheers,
Kristian
