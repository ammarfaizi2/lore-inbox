Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTK0XJx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 18:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbTK0XJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 18:09:53 -0500
Received: from [212.97.163.22] ([212.97.163.22]:63992 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261539AbTK0XJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 18:09:49 -0500
Date: Fri, 28 Nov 2003 00:09:37 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Locking over NFS
Message-ID: <20031127230937.GA23147@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Is locking via lockf/fcntl supposed to work over NFS mounted volumes 
in 2.4 ?
I can't get it to work, even if kernel [lockd] is running in the server.
Server locks the file, and client gets an error:

annwn:~/dev/lk> lockf 10000
locked
<switch term>
annwn:~/dev/lk> bpsh 0 lockf
lockf:F_LOCK: No locks available

lockf.c:

#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

int main(int argc, char** argv)
{
    int fd;

    fd = open("lock",O_RDWR);
    if (fd<0)
        perror("open");

    if (lockf(fd,F_LOCK,0)<0)
        perror("lockf:F_LOCK");
    else
        printf("locked\n");
    fflush(stdout);

    if (argc>1)
        sleep(atoi(argv[1]));

    if (lockf(fd,F_ULOCK,0)<0)
        perror("lockf:F_ULOCK");
    else
        printf("unlocked\n");
    fflush(stdout);

    return 0;
}

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.4.23-rc5-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))
