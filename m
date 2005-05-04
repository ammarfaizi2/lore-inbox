Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVEDSnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVEDSnZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 14:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVEDSnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 14:43:25 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:22713 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261246AbVEDSnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 14:43:21 -0400
Date: Wed, 4 May 2005 11:43:18 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andr? Pereira de Almeida <andre@cachola.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A patch for the file kernel/fork.c
Message-ID: <20050504184318.GA644@taniwha.stupidest.org>
References: <4278E03A.1000605@cachola.com.br> <20050504175457.GA31789@taniwha.stupidest.org> <427913E4.3070908@cachola.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427913E4.3070908@cachola.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 03:26:44PM -0300, Andr? Pereira de Almeida wrote:

> >>-       if (tsk->clear_child_tid && atomic_read(&mm->mm_users) > 1) {
> >>+       if (mm && tsk->clear_child_tid && atomic_read(&mm->mm_users) > 1)

> In a preemptible kernel with the serport module and a serial port try to
> run the following program:
>
> int main(int argc, char **argv)
> {
>        int ldisc,fd;
>
>        fd = open("/dev/ttyS0", O_RDWR | O_NOCTTY | O_NONBLOCK);
>        ldisc = N_MOUSE;
>        ioctl(fd, TIOCSETD, &ldisc);
>        read(fd, NULL, 0);
>        return 0;
> }
>
> and kill it.  In my case it will hang the computer. I think this is
> a problem with the serport module. With this patch, the serial mouse
> stop working, but the computer don't hang.

then above something like:

     BUG_ON(!mm);

or something might be better and eyeball the stack trace.

