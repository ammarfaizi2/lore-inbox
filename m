Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbULIPgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbULIPgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 10:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbULIPgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 10:36:16 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:3254 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261530AbULIPgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 10:36:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=az0uWqSjg5OpimMv+wrUdr0H7bI4NGVDognwZd/CqJoatyoNQDQxVjEgGplbjjXhXUptJ40YsfbDrAZwfpufOxBg4Wa/vMPH02u1y25UdeAmcdQnsDYTQU11kCqIJgNdH+7BPQOq7Tlwyli/ZSAPogZmHJbupFgwjGTkoLGAzDU=
Message-ID: <8783be6604120907367db1fda5@mail.gmail.com>
Date: Thu, 9 Dec 2004 10:36:08 -0500
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Ilya Pashkovsky <ilya.pashkovsky@gmail.com>
Subject: Re: [PATCH] port_reuse listen fix (allow simultaneous single listen + outgoing connects from same port)
Cc: netdev@oss.sgi.com,
       =?UTF-8?Q?YOSHIFUJI_Hideaki_/_=E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E?= 
	<yoshfuji@linux-ipv6.org>,
       davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <fcb9aa29041209032521899698@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <fcb9aa29041209032521899698@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2004 13:25:26 +0200, Ilya Pashkovsky
<ilya.pashkovsky@gmail.com> wrote:
> This is the latest patch with removed bool > 1 check and ipv6 support.
> http://puding.mine.nu/patches/
> http://puding.mine.nu/patches/patch-reuse-bool-ipv6
> 
> to check, you can use netcat (sets SO_REUSEADDR by default).
> on one host (host A): nc -v -l -p 9999
> on another/same host (host B): nc -v -l -p 9000
> on host A: nc -v -p 9999 host.B.ip.addr 9000
> on host B: nc -v host.A.ip.addr 9999

What happens if on host B you do 

nc -v -p 9000 host.A.ip.addr 9999?

Seems to me you will break the rule that a connection is uniquely
identified by (srcpip, destip, srcport, destport).

    Ross
