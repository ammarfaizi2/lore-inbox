Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315793AbSENQHk>; Tue, 14 May 2002 12:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315795AbSENQHj>; Tue, 14 May 2002 12:07:39 -0400
Received: from mercury.lss.emc.com ([168.159.40.77]:37393 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S315793AbSENQHh>; Tue, 14 May 2002 12:07:37 -0400
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F553D1A52@srgraham.eng.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Jes Sorensen'" <jes@wildopensource.com>
Cc: "'Steve Whitehouse'" <Steve@ChyGwyn.com>, linux-kernel@vger.kernel.org
Subject: RE: Kernel deadlock using nbd over acenic driver.
Date: Tue, 14 May 2002 12:07:30 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But how to avoid system hangs due to running out of memory?
Is there a safe guide line? Generally slow is tolerable, but
crash is not.

Thanks,

Xiangping

-----Original Message-----
From: Jes Sorensen [mailto:jes@wildopensource.com]
Sent: Tuesday, May 14, 2002 11:11 AM
To: chen, xiangping
Cc: 'Steve Whitehouse'; linux-kernel@vger.kernel.org
Subject: Re: Kernel deadlock using nbd over acenic driver.


>>>>> "Xiangping" == chen, xiangping <chen_xiangping@emc.com> writes:

Xiangping> But the acenic driver author suggested that sndbuf should
Xiangping> be at least 262144, and the sndbuf can not exceed
Xiangping> r/wmem_default. Is that correct?

Ehm, the acenic author is me ;-)

The default value is what all sockets are assigned on open, you can
adjust this using SO_SNDBUF and SO_RCVBUF, however the values you set
cannot exceed the [rw]mem_max values. Basically if you set the default
to 4MB, your telnet sockets will have a 4MB default limit as well
which may not be what you want (not saying it will use 4MB).

Thus, set the _max values and use SO_SNDBUF and SO_RCVBUF to set the
per process values. But leave the _default values to their original
setting.

Xiangping> So for gigabit Ethernet driver, what is the optimal mem
Xiangping> configuration for performance and reliability?

It depends on your application, number of streams, general usage of
the connection etc. There's no perfect-for-all magic number.

Jes
