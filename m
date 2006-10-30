Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965265AbWJ3Lv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbWJ3Lv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 06:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965507AbWJ3LvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 06:51:25 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:9343 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965265AbWJ3LvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 06:51:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=N8EXU24ztm6pZe0kJ/VWdNxOrzfdJ+nIcyQdC6JuXlwVkPiEhXRNUiKjnfnHv1TJkat0GCtFOm7D+geaGFvcWpY5u0NNGAw/Sn/TyVpLWI2+7d09zV7WQ03TQVBrczhO4AORAr3E8+u7Y4KUxwXqH/MIIvTgf9taKWvidD47fnk=
Message-ID: <d48dcd3c0610300351g6cb67b0eob3e6bfdf1d1fedc2@mail.gmail.com>
Date: Mon, 30 Oct 2006 22:51:23 +1100
From: "Anindha Parthy" <anindha@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: accurate serial timestamp
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to take a high accuracy timestamp whenever data is
received on the serial port.

I think the best place to do this is in the tty_flip_buffer_push
method of the tty_io.c file.

   2652 void tty_flip_buffer_push(struct tty_struct *tty)
   2653 {
   2654     if (tty->low_latency)
   2655         flush_to_ldisc((void *) tty);
   2656     else
   2657         schedule_delayed_work(&tty->flip.work, 1);
   2658 }

I would buffer the timestamps, and access them using an ioctl.

Is this the best way of doing this?

I am currently using the 2.6.15 kernel.

Regards,

Anindha
