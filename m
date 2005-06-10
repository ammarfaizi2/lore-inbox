Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVFJJG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVFJJG4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 05:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVFJJG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 05:06:56 -0400
Received: from hrz-ws39.hrz.uni-kassel.de ([141.51.12.239]:47772 "EHLO
	hrz-ws39.hrz.uni-kassel.de") by vger.kernel.org with ESMTP
	id S262527AbVFJJGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 05:06:54 -0400
Message-ID: <42A958AF.5010507@uni-kassel.de>
Date: Fri, 10 Jun 2005 11:09:03 +0200
From: Michael Zapf <Michael.Zapf@uni-kassel.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Fixed the prob (was: Re: Problems with USB on x86_64)
References: <42A6AAFF.2020605@uni-kassel.de>
In-Reply-To: <42A6AAFF.2020605@uni-kassel.de>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-UniK-SMTP-MailScanner-Information: 
X-UniK-SMTP-MailScanner: Found to be clean
X-UniK-SMTP-MailScanner-SpamCheck: 
X-MailScanner-From: michael.zapf@uni-kassel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Zapf schrieb:

> I have some trouble using a memory stick of LG in my Athlon64 system. 
> When I plug it in, dmesg gives messages like this:
>
> ehci_hcd 0000:00:02.2: port 6 reset error -110
> hub 1-0:1.0: hub_port_status failed (err = -32)
> ehci_hcd 0000:00:02.2: port 6 reset error -110
> hub 1-0:1.0: hub_port_status failed (err = -32)
> hub 1-0:1.0: Cannot enable port 6.  Maybe the USB cable is bad?

just minutes before starting to pack my barebone to send it to service, 
it seems that I solved the issue with the USB stick by patching the 
ehci-hub.c file.

Actually, the messages in the log file

ehci_hcd 0000:00:02.2: port 6 reset error -110

showed that I had a timeout problem (110=ETIMEOUT). I found a call to a 
function "handshake" in ehci-hub.c which set the timeout to 500µs.

Increasing this timeout to 600µs allows the onboard hub to complete the 
reset. The stick is correctly mounted afterwards. (I tried 550, but this 
was still not enough.)

Any chance to have this included in future patches and versions? I guess 
there could be other people around with such a problem. The increase of 
the timeout should not hurt too much, should it?

Michael
