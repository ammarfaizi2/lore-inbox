Return-Path: <linux-kernel-owner+w=401wt.eu-S1754584AbWLZAIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbWLZAIo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 19:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754587AbWLZAIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 19:08:44 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:54292 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584AbWLZAIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 19:08:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=uF3HDu92l8M5YHaXhzOxIayhS32954JQJf/lWtIqRCDq8LU6KPK+eRMQoCBs6jeHkJG/pRn+D+k/hkAUELpM9oMog94Z5+XhLr2s4x7xlnQ5ojyqKc//qZepkvChI5bmESq2kvXdcO5rvfMe4+GTXs0qMZ7r+Tp+Ku+Pu7uwmPw=
Message-ID: <45906820.10805@gmail.com>
Date: Tue, 26 Dec 2006 01:08:41 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: p.hardwick@option.com, hollisb@us.ibm.com
Subject: tty->low_latency + irq context
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

 *      tty_flip_buffer_push    -       terminal
 *      @tty: tty to push
 *
 *      Queue a push of the terminal flip buffers to the line discipline. This
 *      function must not be called from IRQ context if tty->low_latency is set.

But some drivers (mxser, nozomi, hvsi...) sets low_latency to 1 in _open and
calls tty_flip_buffer_push in isr or in functions, which are called from isr.
Is the comment correct or the drivers?

Moreover, hvsi says:
tty->low_latency = 1; /* avoid throttle/tty_flip_buffer_push race */

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
