Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbTJQNZW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 09:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTJQNZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 09:25:22 -0400
Received: from mx2.seznam.cz ([212.80.76.42]:16786 "HELO email.seznam.cz")
	by vger.kernel.org with SMTP id S263457AbTJQNZR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 09:25:17 -0400
From: =?us-ascii?Q?Pavel=20Krauz?= <Pavel.Krauz@seznam.cz>
To: linux-kernel@vger.kernel.org
Subject: =?us-ascii?Q?mmap=28READ=5FONLY=29=20and=20core?=
Date: Fri, 17 Oct 2003 15:25:15 +0200 (CEST)
Content-Type: text/plain;
	charset="iso-8859-2"
Message-Id: <30932.173161-19744-1487508300-1066397114@seznam.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Reply-To: =?us-ascii?Q?Pavel=20Krauz?= <Pavel.Krauz@seznam.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I tried this prog that generates core. But I am not able to access the mapped addresses
inside the debugger when I load the core. Does anybody know if this is a kernel
(2.4.20) or gdb problem?

cheers
Pavel


(gdb) print addr
$1 = 0x40014000 <Address 0x40014000 out of bounds>
(gdb) print *addr
Cannot access memory at address 0x40014000


#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
        int fd;
        char *addr;

        if ((fd = open(argv[1], O_RDONLY)) < 0) {
                fprintf(stderr, "can't open %s for r/w\n", argv[1]);
                exit(1);
        }
        if (!(addr = mmap(0, 64, PROT_READ, MAP_SHARED, fd, 0))) {
                fprintf(stderr, "can't mmap %s\n", argv[1]);
                exit(1);
        }

        *addr = 0;

        return 0;
}



____________________________________________________________
Nemá¹ komu øíct, ¾e jsi fakt dobrej?  Oskarova nabídka pro studenty - a¾
600 SMSek a 4 hodiny volání zdarma. Volej Kolej! http://ad2.seznam.cz/redir.cgi?instance=62375%26url=http://www.oskarmobil.cz/services/whatsnew.php#volej
