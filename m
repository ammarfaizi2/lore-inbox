Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWDLOOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWDLOOG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 10:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWDLOOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 10:14:06 -0400
Received: from boxa.alphawave.net ([207.218.5.130]:34946 "EHLO
	box.alphawave.net") by vger.kernel.org with ESMTP id S1751153AbWDLOOF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 10:14:05 -0400
To: Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org
Subject: Re: CRTSCTS wrong in man tcsetattr
In-Reply-To: <60Nqo-4kw-5@gated-at.bofh.it>
References: <60Nqo-4kw-5@gated-at.bofh.it>
Date: Wed, 12 Apr 2006 15:13:51 +0100
Message-Id: <20060412141352.4FDF914C51F@irishsea.home.craig-wood.com>
From: nick@craig-wood.com (Nick Craig-Wood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.kernel, you wrote:
>  Man tcsetattr in gentoo implicitly states that after
>  #include <termios.h>
>  #include <unistd.h>
> 
>  CRTSCTS constant will be defined. This is however false:
>  tty.c:38: error: `CRTSCTS' undeclared (first use in this function)
> 
>  CRTSCTS is defined in bits/termios.h and in asm/termbits.h The question
>  is what is the correct state of affairs?
>  1) the manpage should say bits/termios.h instead of termios.h
>  2) the manpage should say asm/termbits.h instead of termios.h
>  3) the termios.h should include bits/termios.h or asm/termbits.h
>  4) the manpage should not mention CRTSCTS at all
5) there is a bug in your installation

Works for me in Debian testing

cat <<'EOF' > z.c
#include <termios.h>
#include <unistd.h>
#include <stdio.h>

int main(void)
{
    printf("0x%08X", CRTSCTS);
    return 0;
}
EOF
gcc -Wall z.c -o z
./z

Gives

0x80000000

-- 
Nick Craig-Wood <nick@craig-wood.com> -- http://www.craig-wood.com/nick
