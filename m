Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbTEUIaf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 04:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTEUIaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 04:30:35 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:61852 "EHLO
	mwinf0602.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262171AbTEUIab convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 04:30:31 -0400
Date: Wed, 21 May 2003 10:43:30 +0200
Subject: Re: PATCH: usb-uhci: interrupt out with urb->interval 0  [linux-usb-devel]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
To: Pete Zaitcev <zaitcev@redhat.com>
From: Frode Isaksen <fisaksen@bewan.com>
In-Reply-To: <20030430180050.A17797@devserv.devel.redhat.com>
Message-Id: <4C4FDF7A-8B68-11D7-A60F-003065EF6010@bewan.com>
Content-Transfer-Encoding: 8BIT
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le jeudi, 1 mai 2003, à 00:00 Europe/Paris, Pete Zaitcev a écrit :

>> Date: Wed, 30 Apr 2003 14:38:58 +0200
>> From: Frode Isaksen <fisaksen@bewan.com>
>
>> I have tested the patch with the Unicorn (ST70137) adsl usb chip and 
>> it
>> is ok. Thanks...
>
>> Do you think it will be in the official 2.4.21 kernel ?
>
> This is a question to Greg Kroah. He wanted to put brakes on
> it due to insufficient testing. Personally, I do not agree.
> I think we should put it into -rc2 and see if anything breaks
> (which is unlikely in this case). But ultimately it's his call.

I just downloaded 2.4.21-rc2, and the patch is not in...
Is it any hope for it to be in the official 2.4.21 kernel at all ???
For your information, my router with an adsl usb modem has run with 
this patch for weeks now.

Thanks,

Frode

>
> -- Pete
>
>


diff -urN -X dontdiff linux-2.4.21-rc1/drivers/usb/host/usb-uhci.c 
linux-2.4.21-rc1-nip/drivers/usb/host/usb-uhci.c
--- linux-2.4.21-rc1/drivers/usb/host/usb-uhci.c	2003-04-24 
10:52:56.000000000 -0700
+++ linux-2.4.21-rc1-nip/drivers/usb/host/usb-uhci.c	2003-04-29 
12:43:28.000000000 -0700
@@ -2430,9 +2430,9 @@

  _static int process_interrupt (uhci_t *s, struct urb *urb)
  {
-	int i, ret = -EINPROGRESS;
+	int ret = -EINPROGRESS;
  	urb_priv_t *urb_priv = urb->hcpriv;
-	struct list_head *p = urb_priv->desc_list.next;
+	struct list_head *p;
  	uhci_desc_t *desc = list_entry (urb_priv->desc_list.prev, 
uhci_desc_t, desc_list);

  	int actual_length;
@@ -2440,8 +2440,8 @@

  	//dbg("urb contains interrupt request");

-	for (i = 0; p != &urb_priv->desc_list; p = p->next, i++)	// Maybe we 
allow more than one TD later ;-)
-	{
+	// Maybe we allow more than one TD later ;-)
+	while ((p = urb_priv->desc_list.next) != &urb_priv->desc_list) {
  		desc = list_entry (p, uhci_desc_t, desc_list);

  		if (is_td_active(desc)) {

