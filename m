Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbWD0PKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbWD0PKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWD0PKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:10:20 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:38792 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S965146AbWD0PKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:10:19 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Avi Kivity <avi@argo.co.il>
Subject: Re: Compiling C++ modules
Date: Thu, 27 Apr 2006 18:10:07 +0300
User-Agent: KMail/1.8.2
Cc: dtor_core@ameritech.net, Kyle Moffett <mrmacman_g4@mac.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com> <444E61FD.7070408@argo.co.il>
In-Reply-To: <444E61FD.7070408@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604271810.07575.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 20:53, Avi Kivity wrote:
> Very often one needs to acquire a resource, do something with it, and 
> then free the resource. Here, "resource" can mean a file descriptor, a 
> reference into a reference counted object, or, in our case, a spinlock. 
> And we want "free" to mean "free no matter what", e.g. on a normal path 
> or an exception path.

...

> Additionally, C++ guarantees that if an exception is thrown after 
> spin_lock() is called, then the spin_unlock() will also be called. 
> That's an interesting mechanism by itself.

Life gets even more interesting when you hit another exception
inside destructor(s) being executed due to first one.
Say, spin_unlock() discovers that lock is already unlocked
and does "throw BUG_double_unlock".

Even if you
(a) remember what standard says about it
(b) implemented nested exception handling correctly,
	then you are still left with
(c) let's pray gcc has no bugs in stack unwinding
    and nested exceptions and nested destructor calls.

Mozilla crashes over such things. For Mozilla, crash is not
*that* catastrophic. For OS kernel, it is.
--
vda
