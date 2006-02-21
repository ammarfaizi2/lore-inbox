Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWBUM17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWBUM17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 07:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWBUM17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 07:27:59 -0500
Received: from mail2.designassembly.de ([217.11.62.46]:46559 "EHLO
	mail2.designassembly.de") by vger.kernel.org with ESMTP
	id S1751175AbWBUM16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 07:27:58 -0500
Message-ID: <43FB0746.5010200@designassembly.de>
Date: Tue, 21 Feb 2006 13:27:50 +0100
From: Michael Heyse <mhk@designassembly.de>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>
Subject: which one is broken: VIA padlock aes or aes_i586?
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after upgrading the kernel from 2.6.12.5 to 2.6.16-rc4, decryption of my disk fails. As I am using the Nehemia's Padlock and aes-cbc-essiv, I guess this is the reason:

(from ChangeLog-2.6.13)
commit 476df259cd577e20379b02a7f7ffd086ea925a83
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Wed Jul 6 13:54:09 2005 -0700

    [CRYPTO] Update IV correctly for Padlock CBC encryption

    When the Padlock does CBC encryption, the memory pointed to by EAX is
    not updated at all.  Instead, it updates the value of EAX by pointing
    it to the last block in the output.  Therefore to maintain the correct
    semantics we need to copy the IV.

    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
    Signed-off-by: David S. Miller <davem@davemloft.net>


This probably means, that the on-disk format has changed, and the new aes routine can't decrypt my data any more.

The strange thing is: if I disable the padlock driver and use the software-only aes_i586 module, I can read my disk with 2.6.16-rc4. So obviously one of the implementations produces wrong results (they are supposed to do the same thing, right?). So before I try to re-encrypt my disk: which one is doing it right?

Thanks,
Michael

