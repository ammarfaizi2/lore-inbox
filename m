Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSENPLf>; Tue, 14 May 2002 11:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSENPLd>; Tue, 14 May 2002 11:11:33 -0400
Received: from trained-monkey.org ([209.217.122.11]:46347 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S315758AbSENPL3>; Tue, 14 May 2002 11:11:29 -0400
To: "chen, xiangping" <chen_xiangping@emc.com>
Cc: "'Steve Whitehouse'" <Steve@ChyGwyn.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel deadlock using nbd over acenic driver.
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1A51@srgraham.eng.emc.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 14 May 2002 11:11:28 -0400
Message-ID: <m3sn4u4vdr.fsf@trained-monkey.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
