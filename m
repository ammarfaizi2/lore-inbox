Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbULZQuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbULZQuQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 11:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbULZQuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 11:50:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:50840 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261709AbULZQt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 11:49:57 -0500
Subject: Re: Ho ho ho - Linux v2.6.10
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1103977161.22646.6.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org>
	 <1103977161.22646.6.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104075953.23660.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Dec 2004 15:45:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-12-25 at 12:19, Alan Cox wrote:
> - It seems the security hole inducing exec_id change was not reverted
> and I've not yet found any other changes that fix the same problem
> (setuid_app >/proc/self/mem) in 2.6.10. It was actually quite nasty as a
> hole because you can seek the fd to the right target address before
> execing. With the other /proc changes did I miss something on this one

Thankfully I missed something as the test app shows

static char foo[5]="GOOD";

int main(int argc, char *argv[])
{
  lseek(1, (unsigned long) foo, 0);
  if(write(1, "BAD!", 4) != 4)
    perror("write");
  write(2, foo, 4);
}


Running ./a.out >/proc/self/mem produces the desired write error still
in 2.6.10

