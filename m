Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130461AbRBLSzg>; Mon, 12 Feb 2001 13:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130664AbRBLSz0>; Mon, 12 Feb 2001 13:55:26 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:55308 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130461AbRBLSzQ>;
	Mon, 12 Feb 2001 13:55:16 -0500
To: Donald Becker <becker@scyld.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.10.10102091707310.7141-100000@vaio.greennet>
From: Jes Sorensen <jes@linuxcare.com>
Date: 12 Feb 2001 19:54:25 +0100
In-Reply-To: Donald Becker's message of "Fri, 9 Feb 2001 17:56:06 -0500 (EST)"
Message-ID: <d3zofrag0u.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Donald" == Donald Becker <becker@scyld.com> writes:

Donald> On 9 Feb 2001, Jes Sorensen wrote:
>> The ia64 kernel has gotten mis aligned load support, but it's slow
>> as a dog so we really want to copy the packet every time anyway
>> when the header is not aligned. If people send out 802.3 headers or
>> other crap on Ethernet then it's just too bad.

Donald> Note the word "required", meaning "must be done"
Donald> vs. "recommended" meaning "should be done".

Donald> The initial issue was a comment in a starfire patch that
Donald> claimed an IA64 bug had been fixed.  The copy breakpoint
Donald> change might have improved performance by doing a copy-align,
Donald> but it didn't fix a bug.

I agree it was a bug, and yes it has been fixed.

Donald> That performance tradeoff was already anticipated: the
Donald> 'rx_copybreak' value that was changed was a module parameter,
Donald> not a constant.  That allows a module-load-time tradeoff,
Donald> based the specific implementation, of copying the received
Donald> packet or accepting a few unaligned loads of the usually small
Donald> IP header.  See the comments in starfire.c, as well as several
Donald> other bus-master drivers.

In this case it just results in a performance degradation for 99% of
the usage. What about making the change so it is optimized away unless
IPX is enabled?

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
