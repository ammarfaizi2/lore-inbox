Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269466AbUJFUbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269466AbUJFUbK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269460AbUJFU2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:28:52 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:48043 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269484AbUJFU0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:26:14 -0400
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Joris van Rantwijk <joris@eljakim.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041006193053.GC4523@pclin040.win.tue.nl>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
	 <1097080873.29204.57.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0410061955230.7057@eljakim.netsystem.nl>
	 <20041006193053.GC4523@pclin040.win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097090625.29707.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 20:23:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-06 at 20:30, Andries Brouwer wrote:
>        A  descriptor shall be considered ready for reading when a
>        call to an input function with O_NONBLOCK clear would  not
>        block,  whether  or  not  the function would transfer data
>        successfully. (The function might return data, an  end-of-
>        file  indication,  or  an  error other than one indicating
>        that it is  blocked,  and  in  each  of  these  cases  the
>        descriptor shall be considered ready for reading.)
> 
> As far as I can interpret these sentences, Linux does not conform.

Nor does anything else in that case. I guess we need a POSIX_ME_HARDER
socket option.

As to the Stevens reference - Stevens says nothing about read but does
mention the problem of accept, which is one of the "can't fix" type
examples.

	Connection setup pending
		select returns
	Connection destroyed
		accept blocks

Alan

