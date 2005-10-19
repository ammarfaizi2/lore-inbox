Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVJSLzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVJSLzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVJSLzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:55:37 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:31949 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750828AbVJSLzg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:55:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ey6N2dngaD7nu1Ezpk2kkeSOZkiZ1vrsJSKXOHoIRnEwtqb0J7ifCkjTsvC3s2Mm4dN0RHNOtd0LDoAXsuEi9GUPkwJSTwK+qwaz8tv4MmdiFcQXdPsBEWdII1y54F3ZGY70QBgk7E1g8mT7Ae8CWcU/Ajua8vDQNoQr96xkpds=
Message-ID: <7418fe470510190455x3bb746cax365092504e77ba3c@mail.gmail.com>
Date: Wed, 19 Oct 2005 13:55:35 +0200
From: Rabih ElMasri <rabih.elmasri@infineon.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: tty line discipline
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I am trying to assign a new line discipline to ttyS0 from within the
kernel-space. During the initialization of my module I do the
following:

fp=filp_open(dev,O_RDWR | O_NOCTTY,0);
tty=fp->private_data;  //the tty_struct

then I initialize the fields of the new line discipline (ldisc). and
assign it to the tty_struct:

tty->ldisc=ldisc;

It works fine the first time I insert the module, but gets problems
with tty->count if I insert it again.

I tried to call the tty_ioctl function of tty_io.c (with flag
TIOCSETD) using the corresponding field in the file structure
(fp->f_op->ioctl(..)), but it seems to expect a call from user-space,
and returns -EFAULT due to the get_user macro.

I would really appreciate it if someone can tell me how to deal with
this problem.

Regards,
Rabih
