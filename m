Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVB1AGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVB1AGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVB1AGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:06:25 -0500
Received: from [195.23.16.24] ([195.23.16.24]:3507 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261517AbVB0XkY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 18:40:24 -0500
Message-ID: <1109547400.42225988b8070@webmail.grupopie.com>
Date: Sun, 27 Feb 2005 23:36:40 +0000
From: "" <pmarques@grupopie.com>
To: Neil <neil@qlsc.sdu.edu.cn>
Cc: "" <linux-kernel@vger.kernel.org>
Subject: Re: Yet another I/O modeling
References: <422219ED.5060404@qlsc.sdu.edu.cn>
In-Reply-To: <422219ED.5060404@qlsc.sdu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.89.181
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Neil <neil@qlsc.sdu.edu.cn>:

> hi,all
> select/poll I/O modeling is fast,easy to use,it returns the number of fd 
> which are acitvity,but you should scan the fd array to find which fd is 
> ready,it costs a lot of time on a heavy load server.
> 
> I proposal another I/O modeling,named eselect.
> struct eselect_struct{
>     unsigned long readbitmap[MAXBITMAPFD];//suppose the MAXBITMAPFD is 
> MAX OPEN                                         //FD NUMBER PER PROCESS
>     int ret;//-1 on error,non-negative return value is the number of     
>             //acitvity fds
> }
> we can use __set_bit(),__clear_bit(),__find_first_bit()....functions to 
> maintain the bitmap.
> So,you shouldnt scan the fd array any more.

I really don't see why __find_first_bit() is better than "scan the fd array".
They both seem like O(N) operations. You might be dividing the tests by 32 (or
64) but in a busy server with 3000 open sockets, what you really want is no
scanning at all.

Anyway, your problem is already solved. You should check epoll:

http://epoll.hackerdojo.com/

It's been in the kernel for a while, now (with CONFIG_EPOLL=y).

--
Paulo Marques - www.grupopie.com
 
All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

