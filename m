Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290574AbSBKW0z>; Mon, 11 Feb 2002 17:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290551AbSBKW0p>; Mon, 11 Feb 2002 17:26:45 -0500
Received: from femail31.sdc1.sfba.home.com ([24.254.60.21]:53997 "EHLO
	femail31.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S290574AbSBKW0e>; Mon, 11 Feb 2002 17:26:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: "Nivedita Singhvi" <nivedita@us.ibm.com>
Subject: Re: [DOC PATCH] Re: tcp_keepalive_intvl vs tcp_keepalive_time?
Date: Mon, 11 Feb 2002 17:27:28 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF1F27EF89.EBD28817-ON88256B5D.00711505@boulder.ibm.com>
In-Reply-To: <OF1F27EF89.EBD28817-ON88256B5D.00711505@boulder.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020211222634.QIHM874.femail31.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 February 2002 03:51 pm, Nivedita Singhvi wrote:

> The keepalive packets are simple tcp segments sent on the connection:
>
> - no data
> - ack # is next expected byte
> - sequence # is a stale (byte already acked by the other end) one, so that
> the
>   other end is forced to send an ack in return (as it receives an out of
> window
>   sequence #).
>
> I cant imagine how a firewall would be filtering them..

The firewall is also doing IP Masquerading/transparent proxying/port 
forwarding as part of a VPN setup (both source and destination NAT).  So 
iptables' connection tracking might be timing out, and/or interfering with 
the keepalive packets.  (Maybe the keepalive packets aren't making it through 
NAT?  That's my current theory.  I know that's got a timeout after which it 
forgets a masqueraded connection, and the same probably applies to the other 
forms of NAT.  My current theory is that keepalive packets aren't keeping NAT 
connections alive...)

> thanks,
> Nivedita

Rob
