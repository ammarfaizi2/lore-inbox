Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130021AbQK1RLL>; Tue, 28 Nov 2000 12:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130105AbQK1RKw>; Tue, 28 Nov 2000 12:10:52 -0500
Received: from 213-123-72-140.btconnect.com ([213.123.72.140]:38151 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S130021AbQK1RKj>;
        Tue, 28 Nov 2000 12:10:39 -0500
Date: Tue, 28 Nov 2000 16:41:46 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bug in count_open_files() or a strange granularity?
In-Reply-To: <Pine.LNX.3.95.1001128103938.365A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.21.0011281638540.1254-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, Richard B. Johnson wrote:
> Yes. This is probably related to the previously-reported MOD_INC_USE_COUNT
> macro in the drivers. The open count is now handled in the call to
> the driver's open(). The MOD_INC_USE_COUNT and the MOD_DEC_USE_COUNT
> should now be defined to do nothing for kernels that already handle
> the counts in the calls.

Hi Richard,

Although your comment had nothing to do with my question -- I still
would like to point out that:

a) the driver in question (/dev/cpu/micocode) deals with module accounting
correctly by using THIS_MODULE in the fops, it doesn't use
MOD_INC/DEC_USE_COUNT macros

b) No, those macros should NOT be defined to do nothing because the Linux
kernel is a lot more than just set of drivers. There are subsystems that
still need them.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
