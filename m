Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbTISEqj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 00:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbTISEqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 00:46:38 -0400
Received: from [211.167.76.68] ([211.167.76.68]:27917 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261282AbTISEq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 00:46:27 -0400
Date: Fri, 19 Sep 2003 12:46:31 +0800
From: Hugang <hugang@soulinfo.com>
To: linux-kernel@vger.kernel.org
Subject: use O_DIRECT open file, when read will hang.
Message-Id: <20030919124631.3b4e6301.hugang@soulinfo.com>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all:

Steps to reproduce:

rm -f /tmp/1.log
touch /tmp/1.log
echo << EOF > /tmp/hang.c 
#include <sys/types.h>
#include <asm/fcntl.h>

main()
{
        int i;
        char buf[1025];

        i = open("/tmp/1.log", O_RDONLY | 040000, 0);
        if ( i != -1) {
                read(i, buf, 1);
        }
        printf("'%s'", buf);
}
EOF
gcc -o /tmp/hang /tmp/hang.c
/tmp/hang


-- 
Hu Gang / Steve
Email         : hugang@soulinfo.com, steve@soulinfo.com
GPG FinePrint : 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc
MSN#          : huganglinux@hotmail.com [9:00AM - 5:30PM +8:00]
RLU#          : 204016 [1999] (Register Linux User)
