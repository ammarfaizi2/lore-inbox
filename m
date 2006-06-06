Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWFFLXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWFFLXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWFFLXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:23:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:51257 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751233AbWFFLXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:23:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rgapKXUV2zODp8d6JkEp4I+omSPjLA+zX2d4ZpBII+7q+rE1eyPzmvU595M7pyCevm5Az2h6B9RdJSVZ9AlRTNfH4U22df2wAT2xXwcaXR7oG5uN1SQFC0Jq5pW1NdyW1y9msz3f8URuVCEx+Y6Kb/c88/W+6yFK3YRBNYbuvbY=
Message-ID: <9a8748490606060423t102384f4m626b4366898ce9cd@mail.gmail.com>
Date: Tue, 6 Jun 2006 13:23:12 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Heiko Gerstung" <heiko.gerstung@meinberg.de>
Subject: Re: Backport of a 2.6.x USB driver to 2.4.32 - help needed
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44854F74.50406@meinberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44854F74.50406@meinberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/06, Heiko Gerstung <heiko.gerstung@meinberg.de> wrote:
> Hi!
>
> Short Version (tm): I try to backport a USB driver (rtl8150.c) from
> 2.6.15.x to 2.4.32 and have no idea how to substitue two functions:
> in_atomic() and schedule_timeout_uninterruptible() ... I really would
> appreciate any help, because I am no kernel hacker at all ...
>
in_atomic() is used to test if the kernel is in a state where sleeping
is allowed or not. The 2.4.x kernel is not preemptive and has quite
coarse grained SMP support (the BKL "Big Kernel Lock"), it didin't
need in_atomic() in the same way as 2.6.x does.

schedule_timeout_uninterruptible() is used to sleep on a wait-queue,
which 2.4.x does not have.


[snip]
>
> Under 2.4.32 this driver crashes (kernel panic) when I try to enslave a
> network interface handled by it, with a 2.6 kernel there is no such
> problem. Unfortunately I cannot go ahead with a 2.6 kernel at the
> moment, because it lacks a properly running PPS support.
>
Wouldn't it make more sense to work on improving PPS (I assume you are
refering to NTP "pulse per second" btw) support in 2.6.x rather than
backporting an USB driver to 2.4.x ???


[snip]
>
> Now I would need help in finding a way to substitute the two missing
> functions in a 2.4 kernel environment and I desperately hope that
> someone sees my dilemma and can help me somehow...
>
The book "Linux Device Drivers" third edition is available for free
online and describes 2.6.x USB drivers in a fair bit of detail.
Earlier editions of the book describe the 2.4.x kernel (don't know if
those are available for free, but it should be possible to get them
from a bookstore in any case).

Getting hold of the second & third editions of LDD and comparing the
USB info from both should give you some idea of where to start...


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
