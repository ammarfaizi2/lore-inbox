Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270313AbTGNL0r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270279AbTGNL0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:26:47 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:11525 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S267325AbTGNL01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:26:27 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: modutils-2.3.15 'insmod' 
In-reply-to: Your message of "Wed, 09 Jul 2003 11:25:11 -0400."
             <Pine.LNX.4.53.0307091119450.470@chaos> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Jul 2003 21:41:01 +1000
Message-ID: <20991.1058182861@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003 11:25:11 -0400 (EDT), 
"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>modutils-2.3.15, and probably later, has a bug that can prevent
>modules from being loaded from initrd, this results in not
>being able to mount a root file-system. The bug assumes that
>malloc() will return a valid pointer when given an allocation
>size of zero.

Sigh :(  Fixed over two years ago.

modutils Changelog.  2001-05-06 modutils 2.4.6

	* Do not assume that malloc(0) returns a pointer.  Bug report by
	  Kiichiro Naka, different fix by Keith Owens.

void *
xmalloc(size_t size)
{
  void *ptr = malloc(size ? size : 1);
  if (!ptr)
    {
      error("Out of memory");
      exit(1);
    }
  return ptr;
}

