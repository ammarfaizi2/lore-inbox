Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbRFML7U>; Wed, 13 Jun 2001 07:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263536AbRFML7J>; Wed, 13 Jun 2001 07:59:09 -0400
Received: from smtp-ham-1.netsurf.de ([194.195.64.97]:60316 "EHLO
	smtp-ham-1.netsurf.de") by vger.kernel.org with ESMTP
	id <S263491AbRFML66>; Wed, 13 Jun 2001 07:58:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Uwe Rathmann <Uwe.Rathmann@epost.de>
Reply-To: Uwe.Rathmann@epost.de
To: linux-kernel@vger.kernel.org
Subject: [BUG] stat.st_size is not set for pipes
Date: Wed, 13 Jun 2001 13:56:00 +0200
X-Mailer: KMail [version 1.2.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010613115905Z263491-17720+3381@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have upgraded from 2.4.2 to 2.4.5 and noticed a difference between the 
output of fstat() for pipes using the following testprogram:

--------
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

main()
{
    FILE *f;
    struct stat buf;
    int retval;

    f = popen("echo -n test", "r");
    retval = fstat(fileno(f), &buf);
    printf("Data: %d, %d\n", retval, buf.st_size );

    pclose(f);
}
--------

Under 2.0.x, 2.2.x and 2.4.2 st_size reports the 4 bytes of the "test" 
string, 2.4.5 reports 0. 

Please CC to my email address also, as I'm not subscribed to the list. I 
checked the archives and hope I didn't miss a previous discussion of this.

Uwe
