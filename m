Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTECJoa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 05:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263286AbTECJoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 05:44:30 -0400
Received: from mail.gmx.de ([213.165.64.20]:10029 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263285AbTECJo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 05:44:29 -0400
Message-ID: <3EB3925F.8050801@gmx.net>
Date: Sat, 03 May 2003 11:56:47 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
References: <Pine.LNX.4.44.0305030249280.30960-100000@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0305030249280.30960-100000@devserv.devel.redhat.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> On Fri, 2 May 2003, Carl-Daniel Hailfinger wrote:
> 
> 
>>Ingo Molnar wrote:
>>
>>>Furthermore, the kernel also remaps all PROT_EXEC mappings to the
>>>so-called ASCII-armor area, which on x86 is the addresses 0-16MB. These

What happens if the ASCII-armor area is full, i.e. sum(PROT_EXEC sizes)
 >16MB for a given binary (Mozilla comes to mind)? Does loading fail or
does the binary run without any errors, giving the user a false sense of
security?

>>
>>[snipped]
>>
>>>In the above layout, the highest executable address is 0x01003fff, ie.
>>>every executable address is in the ASCII-armor.
>>
>>If my math is correct,
>>0x01000000 is 16 MB boundary
>>0x01003fff is outside the ASCII-armor.
> 
> 
> the ASCII-armor, more precisely, is between addresses 0x00000000 and
> 0x0100ffff. Ie. 16 MB + 64K. [in the remaining 64K the \0 character is in
> the second byte of the address.] So the 0x01003fff address is still inside 
> the ASCII-armor.

Thanks. However, that brings me to the next question:

01000000-01004000 r-xp 00000000 16:01 2036120    /home/mingo/cat-lowaddr

I was wondering why the executable parts of the binary start at the 16
MB boundary. Is this always the case or just something that happens with
cat? In the first case, that would be bad for any binary with a
contiguous executable area bigger than 64K.

Thanks for answering,
Carl-Daniel

