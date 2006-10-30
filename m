Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161219AbWJ3KdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbWJ3KdD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbWJ3KdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:33:03 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:19840 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1161219AbWJ3KdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:33:01 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: brice.videau@imag.fr
Subject: Re: Strange connect behavior
Date: Mon, 30 Oct 2006 11:32:57 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <4545D2FA.3030802@imag.fr>
In-Reply-To: <4545D2FA.3030802@imag.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610301132.57769.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 October 2006 11:24, Videau Brice wrote:
> Hello,
>
> While writing some client server application in c, we noticed a strange
> behavior : if we try to connect endlessly to a given local port where
> nobody is listening, and if the port is >= to 32768, after several
> thousands tries ( Connection refused ) connect will return 0.
> This behavior is not exhibited when port is < 32768.
>

Hello Brice

Yes, it's quite possible your attempts are hitting themselves.

Hint :

cat /proc/sys/net/ipv4/ip_local_port_range

When you connect(), TCP stack automatically chose a source port and bind your 
outgoing socket. If the chosen port happens to be 35489 (your 'destination' 
port), then the connect succeeds (you're connected to yourself), as specified 
by TCP specs.


> We confirmed this behavior in kernel 2.6.17-10, 2.6.18-1, 2.6.8, on x86
> and 2.4.21-32 on ia64, on several hardware configurations.
> Distribution is debian or ubuntu.
>
> Attached is a source file that demonstrate this behavior.
> ./a.out port_number
>
> Sample execution :
>
> ./a.out 35489
> Out port : 35489
> connect try 1 failed : Connection refused
> connect try 2 failed : Connection refused
> connect try 3 failed : Connection refused
> .....
> connect try 6089 failed : Connection refused
> connect try 6090 failed : Connection refused
> Connection success : 6091 try
> Connection closed
> last error : Connection refused
>
>
> Is this behavior to be expected?
> Can it be disabled?
>
> Thanks in advance.
>
> Regards,
>
> Brice Videau
