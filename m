Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVLMUm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVLMUm5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVLMUm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:42:57 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:41862 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751256AbVLMUm4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:42:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HdLsDL+CvDttl+dH1fDYyb1aEWo81F+32loUwTQ5E0P6h5iqKyDZJ5BuWfgsrpcLUkWtmgd+uY5xrb1mphJuhzf3sLBNxKlqZSjLHW2iWTcV7RmUzOlEvAVLnGRHPIJIGf8btrersqIOpR9mxaH7KP0OvhcpBcV2Vm13t6gTRNk=
Message-ID: <e46c534c0512131242n3ad87709kfd0fc9238137f897@mail.gmail.com>
Date: Tue, 13 Dec 2005 20:42:49 +0000
From: Filipe Cabecinhas <filcab@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Possible problem in fcntl
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Nuno Lopes <ncpl@mega.ist.utl.pt>,
       Renato Crissstomo <racc@mega.ist.utl.pt>
In-Reply-To: <Pine.LNX.4.61.0512131337240.8529@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e46c534c0512130756k18c409aen3d60df7aaee50062@mail.gmail.com>
	 <Pine.LNX.4.61.0512131242280.8370@chaos.analogic.com>
	 <e46c534c0512131030v45640694t1030468ac5775804@mail.gmail.com>
	 <Pine.LNX.4.61.0512131337240.8529@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How do you know what wget did after the connection was refused?
> Didn't it close its socket when returning to the shell?

If we have the call to fcntl, the following happens:
Telnet: SYN
Server: SYN, ACK
T: ACK
S: FIN, ACK
T: FIN, ACK
S: ACK

There was no data exchanged. It just accepted the connection, and then
finished it.

Without the call to fcntl everything goes normally:
T: SYN
S: SYN, ACK
T: ACK
T: PSH, ACK (HTTP request)
S: ACK
S: PSH, ACK (HTTP header)
T: ACK
S: PSH, ACK (data)
T: ACK
S: FIN, ACK
T: ACK
T: FIN, ACK
S: ACK

Thanks in advance,

Filipe Cabecinhas
