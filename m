Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265203AbUETTnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUETTnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 15:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUETTnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 15:43:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28575 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265203AbUETTnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 15:43:01 -0400
Date: Thu, 20 May 2004 16:43:59 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in VM accounting code, probably exploitable
Message-ID: <20040520194358.GE19922@logos.cnet>
References: <40A12E83.7030209@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A12E83.7030209@aknet.ru>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 11:50:27PM +0400, Stas Sergeev wrote:
> 
> Hello.
> 
> As far as I know, if overcommit is
> disabled, the OOM kill should never
> happen.
> It seems to be the bug in the linux
> kernel though (any version I think,
> probably also including 2.4.x), which
> makes it possible to overcommit almost
> arbitrary and provoke an OOM kill
> afterwards.
> Attached is a program that demonstrates
> the bug. Don't forget to "swapoff -a"
> before starting it, or touching pages
> will take eternity. And the amount of
> RAM must be <1Gb, or the prog will not
> work:)
> 
> On 2.4.25 I get:
> ---
> May 11 22:28:18 lin kernel: __alloc_pages: 0-order allocation failed 
> (gfp=0x1d2/0)
> May 11 22:28:20 lin syslogd: /var/log/debug: Cannot allocate memory
> May 11 22:28:18 lin kernel: VM: killing process mozilla-bin
> May 11 22:28:18 lin kernel: __alloc_pages: 0-order allocation failed 
> (gfp=0x1f0/0)
> May 11 22:28:20 lin kernel: __alloc_pages: 0-order allocation failed 
> (gfp=0x1d2/0)
> May 11 22:28:21 lin kernel: __alloc_pages: 0-order allocation failed 
> (gfp=0x1d2/0)
> May 11 22:28:21 lin kernel: VM: killing process X
> May 11 22:28:21 lin gnome-name-server[1254]: input condition is: 0x11, 
> exiting
> May 11 22:29:00 lin kernel: __alloc_pages: 0-order allocation failed 
> (gfp=0x1d2/0)
> May 11 22:29:00 lin kernel: VM: killing process overc_test
> ---
> As you can see, the program caused many
> other processes to be killed, before it
> died itself.

About v2.4, can you try v2.4.26 with CONFIG_OOM_KILLER=y ? 

As for the overcommit, I think it has always been "broken"? (its always 
possible to overcommit).
