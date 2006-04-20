Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWDTPcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWDTPcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 11:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWDTPcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 11:32:32 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:24327 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751026AbWDTPca convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 11:32:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BIKl8gFiKsdcgWmfiO3xy6W7rINwOx2SPab3ypc4DIbFsSAmYJmUUHexCXeuMn59V6axlP+aADFUNkPadTuqruHRWmAdxPLH5Sg2ShZqT1e4pJpyEsiU7ptsmNAwAwn57dPmhUXFtkmcIJau7vR0pY+4TcYFupqS8Zvxj176aj8=
Message-ID: <369a7ef40604200832w196f4093m4238544bf48fabb5@mail.gmail.com>
Date: Thu, 20 Apr 2006 17:32:28 +0200
From: "Libor Vanek" <libor.vanek@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: Connector - how to start?
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060420152524.GA14664@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060415091801.GA4782@2ka.mipt.ru>
	 <20060416114017.GA30180@2ka.mipt.ru>
	 <369a7ef40604160509xcf2caadi782b90da956639d5@mail.gmail.com>
	 <20060416132515.GA25602@2ka.mipt.ru>
	 <369a7ef40604160632t16f6aab9u687a6b359997d7ea@mail.gmail.com>
	 <20060418060744.GA20715@2ka.mipt.ru>
	 <369a7ef40604190439v6e8f1bf6lf52cfab5af3a93af@mail.gmail.com>
	 <20060419121423.GA6057@2ka.mipt.ru>
	 <369a7ef40604200812x594a8b3dxc4d730cdbfda720e@mail.gmail.com>
	 <20060420152524.GA14664@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/20/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Thu, Apr 20, 2006 at 05:12:33PM +0200, Libor Vanek (libor.vanek@gmail.com) wrote:
>
> > - When sending message from kernel, cn_netlink_send returns an error
> > in case when there is no reciever - BUT user space "send" doesn't
> > return an error when there is no reciever in kernel :-(
>
> Userspace sends it into kernel socket. Groups were created for
> userspace's sockets, so there is always a listener in kernelspace.

OK, I wanted to use this to check, if my module is loaded.

> > - How (if) can I do ACK (acknoledge received and processed message)?
>
> I put seq and ack fields into connector header, and described a simple
> protocol for it's usage, but it does require some work by driver author,
> it is impossible to generate automatic ack messages in netlink
> (well, it is possible to generate nlmsgerr message sending but generally
> it is not what people want with protocols designed over connector).

Problem is that there is no (easy) way how to confirm that message was
recieved and proccessed correctly... OK, I'll have to do it
asynchronous...

> Not a good style of allocating data from atomic pool without checks for
> return value.

Just an simple example...

> Btw, you do not need to allocate it dynamically,
> char msg[sizeof(struct cn_msg) + 32] will work too.

Thanks, I didn't know that one.

> In this example you will receive messages for groups 1, 2 (bind time
> gropus 0x3 is equal to (1<<(1-1)) | (1<<(2-1))) and group 3 (you
> have subscribed to that gropu explicitly).

Thx.

Libor Vanek
