Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271770AbTGRNll (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271771AbTGRNll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:41:41 -0400
Received: from 12-229-144-126.client.attbi.com ([12.229.144.126]:36737 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S271770AbTGRNld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:41:33 -0400
Message-ID: <3F17FC8D.9080209@comcast.net>
Date: Fri, 18 Jul 2003 06:56:29 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030704
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davzaffiro@tasking.nl
Subject: Re: [PATCH] pdcraid and weird IDE geometry
References: <3F160965.7060403@comcast.net> <1058431742.5775.0.camel@laptop.fenrus.com> <3F16B49E.8070901@comcast.net> <1058453918.9055.12.camel@dhcp22.swansea.linux.org.uk> <20030717173413.A2393@pclin040.win.tue.nl> <3F175C5C.3030708@comcast.net> <20030718105810.A2925@pclin040.win.tue.nl>
In-Reply-To: <20030718105810.A2925@pclin040.win.tue.nl>
X-Enigmail-Version: 0.76.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
 >
> I don't understand. Did you introduce some float? Remove it immediately.
> 
> You just replace
> 
>         lba = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
>         lba = lba * (ideinfo->head*ideinfo->sect);
>         lba = lba - ideinfo->sect;
> 
> by
> 
> 	lba = ideinfo->capacity - 63;
> 
> Then everything works for you, I suppose.
> Subsequently we wait for other people with the same hardware
> and see how the 63 varies as a function of their setup.
> (Or maybe you can go into the BIOS and specify different
> translations yourself?)
> 
> (By the way, didnt your boot parameters lead to ideinfo->head = 16
> and ideinfo->sect = 63?)
> 
> Andries
> 
> 

No, you're right. I was just trying to clarify the changes that I had
originally made. It seemed as there may have been some confusion that I
was doing more than the original. In my case, the simplified
ideinfo->capacity - ideinfo->sect should work just fine.
The boot parameters did take. The geometry was reported (correctly?) as
I had passed, but when trying to load the pdcraid module, access to the
disk failed with I/O errors. Seemed as if it was trying to read beyond
the end of the device. I used the identical geometry as reported by the
working drive.
Unfortunately, since this is the embedded FastTrak stuff, the BIOS
doesn't allow me to setup geometry for the drives.

I've just tried the simplified method and it works fine. I'll stick with
that on my end. Thanks for the help,

-Walt

