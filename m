Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265855AbUFITV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265855AbUFITV3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 15:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbUFITV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 15:21:29 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:12735 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S265855AbUFITV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 15:21:27 -0400
Date: Wed, 9 Jun 2004 21:17:58 +0200
To: linux-kernel@vger.kernel.org
Cc: nfs@lists.sourceforge.net
Subject: 2.6.X File locking on NFS stil broken
Message-ID: <20040609191758.GA29969@puettmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *1BY8aE-0003uV-00*7AiirvYx.Fs* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


                hello,


I have a big iproblem with the nfs file locking on some 2.6 er kernel 

Kernel Server: 2.4.9
Kernel Client: 2.6.7-rc3-bk2
               2.6.6-rc3-mm2
               2.6.5

mount options :

10.0.0.149:/export     /mnt/server      nfs rw,auto,soft,bg,timeo=12,retrans=3,in tr,rsize=8192,wsize=8192,mountvers=3,nfsvers=3,udp  0  0

nfs-utils :  1.0.6

Both Server an Client Debian Sarge. Wiht kernel 2.4.21-pre5 the locking
runs very fine against the server.

This little testscript I  used ( got it from a friend):

#define _GNU_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>

int main(int c, char **v)
{
    for (++v, --c; c--; ++v) {
        struct flock lck = {F_RDLCK, SEEK_SET, 0, 0}; /* whole file */
        int fd = open(*v, O_RDONLY);
        if ( fd < 0 )
            fprintf(stderr, "%s: %s\n", *v, strerror(errno));
        else {
            if ( fcntl(fd, F_SETLK, &lck) < 0 )
                fprintf(stderr, "%s[%d]: %s\n", *v, lck.l_pid, strerror(errno));
            else
                printf("%s..ok\n", *v);
            close(fd);
        }
    }
    return 0;
}


The programm hangs after executing ./script testfile. 


                        Ruben





-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
