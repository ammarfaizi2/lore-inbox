Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLNXvW>; Thu, 14 Dec 2000 18:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129423AbQLNXvM>; Thu, 14 Dec 2000 18:51:12 -0500
Received: from Cantor.suse.de ([194.112.123.193]:4869 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129257AbQLNXvB>;
	Thu, 14 Dec 2000 18:51:01 -0500
Date: Fri, 15 Dec 2000 00:20:32 +0100
From: Andi Kleen <ak@suse.de>
To: Adam Scislowicz <adams@fourelle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Non-Blocking socket (SOCK_STREAM send)
Message-ID: <20001215002032.A24018@gruyere.muc.suse.de>
In-Reply-To: <3A3953DB.CDA2DF4E@fourelle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A3953DB.CDA2DF4E@fourelle.com>; from adams@fourelle.com on Thu, Dec 14, 2000 at 03:12:27PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 03:12:27PM -0800, Adam Scislowicz wrote:
> Could someone explain why send is failing with EPIPE on the 2.4.x
> kernel, while it is working with the 2.2.x kernels.
> 
> The PsuedoCode:
> sock = socket(AF_INET, SOCK_STREAM, 0)
> buf = fcntl(sock, F_GETFL)
> fcntl(sock, F_SETFL, buf | O_NONBLOCK) // we check the SETFL return
> value, it succeeds
> while ((retval = connect(sock, addr, sizeof(struct sockaddr_in))) < 0)
> {
>   if (retval < 0) {
>    if (errno != EINPROGRESS) return -1; // return failure
>  }
> } // the connect succeeds during first iteration with return value of 0.
> 
> send(sock, msg, msg_length, 0) // this connection is to the thttpd web
> server on the same host. XXX
> XXX: send fails with EPIPE on the 2.4.0-test11-ac 4 and 2.4.0-test12
> kernels, whereas it does not fail on 2.2.14-5.0(redhat kernel)

EPIPE means that the other end or you have closed the connection. It has nothing 
to do with the socket's non blockingness. 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
