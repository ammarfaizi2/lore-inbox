Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269145AbRGaB3Y>; Mon, 30 Jul 2001 21:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269142AbRGaB3Q>; Mon, 30 Jul 2001 21:29:16 -0400
Received: from wawura.off.connect.com.au ([202.21.9.2]:29173 "HELO
	wawura.off.connect.com.au") by vger.kernel.org with SMTP
	id <S269141AbRGaB3K>; Mon, 30 Jul 2001 21:29:10 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4 
In-Reply-To: Your message of "Mon, 30 Jul 2001 14:55:07 +0100."
             <E15RDVj-0003oi-00@the-village.bc.nu> 
Date: Tue, 31 Jul 2001 11:29:16 +1000
From: Andrew McNamara <andrewm@connect.com.au>
Message-Id: <20010731012916.3B119BE8C@wawura.off.connect.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>> This does not help.  The MTAs are doing fsync() on the temporary file
>> and then using the *subsequent* rename() as the committing operation.
>
>Which is quaint, because as we've pointed out repeatedly to you rename
>is not an atomic operation. Even on a simple BSD or ext2 style fs it can
>be two directory block writes,  metadata block writes, a bitmap write
>and a cylinder group write.

This is almost (but not quite) irrelevant. The receiving MTA simply
wants the fsync()/rename() system call to not return until everything
(including directory blocks) have been written to disk, at which point,
it says to the remote end "250 OK". If the receiving machine goes down
at any point up until this one, the sending system will resend the
message.  (Yes, the receiving system may have a corrupt directory, and
this is a problem).

 ---
Andrew McNamara (System Architect)

connect.com.au Pty Ltd
Lvl 3, 213 Miller St, North Sydney, NSW 2060, Australia
Phone: +61 2 9409 2117, Fax: +61 2 9409 2111
