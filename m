Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263341AbUCYQkg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 11:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbUCYQk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 11:40:29 -0500
Received: from smtp-out.girce.epro.fr ([195.6.195.146]:26976 "EHLO
	srvsec1.girce.epro.fr") by vger.kernel.org with ESMTP
	id S263341AbUCYQkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:40:23 -0500
Message-ID: <13c901c41287$d29bb040$3cc8a8c0@epro.dom>
From: "Colin Leroy" <colin@colino.net>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sf.net>
References: <Pine.LNX.4.44L0.0403250936480.1023-100000@ida.rowland.org>
Subject: Re: [linux-usb-devel] Re: [OOPS] reproducible oops with 2.6.5-rc2-bk3
Date: Thu, 25 Mar 2004 17:40:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

> > If I understand it well, this changes the previous default behaviour;
> > intf->cur_altsetting will be intf->altsetting[0], like before, only if
> > there's no intf->altsetting[i].desc.bAlternateSetting == 0.
>
> That's right.  However, the oops you saw shouldn't happen so long as
> intf->cur_altsetting points to something valid.  I got the impression
that
> in the cdc-acm probe routine maybe it was a null pointer.

Additionally, there's still a reference to altsetting[0] in cdc-acm.c (in
acm_ctrl_msg()), I don't know if it's intentional or should have been
converted from
    acm->control->altsetting[0].desc.bInterfaceNumber
to
    acm->control->cur_altsetting.desc.bInterfaceNumber
?
-- 
Colin
  This message represents the official view of the voices
  in my head.

