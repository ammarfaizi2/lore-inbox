Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314220AbSDVPK1>; Mon, 22 Apr 2002 11:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314221AbSDVPK1>; Mon, 22 Apr 2002 11:10:27 -0400
Received: from [193.120.151.1] ([193.120.151.1]:52473 "EHLO mail.asitatech.com")
	by vger.kernel.org with ESMTP id <S314220AbSDVPKZ>;
	Mon, 22 Apr 2002 11:10:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: DJ Barrow <dj.barrow@asitatech.com>
Organization: Asita Technologies
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: novice coding in /linux/net/ipv4/util.c From: DJ Barrow <dj.barrow@asitatech.com>
Date: Mon, 22 Apr 2002 16:12:16 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020422151025Z314220-22651+13849@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
While debugging last night with Brian O'Sullivan I found this beauty.

char *in_ntoa(__u32 in)
{
        static char buff[18];
        char *p;

        p = (char *) &in;
        sprintf(buff, "%d.%d.%d.%d",
                (p[0] & 255), (p[1] & 255), (p[2] & 255), (p[3] & 255));
        return(buff);
}

This textbook peice of novice coding which has existed since 2.2.14.
For those who can't spot the error, please note that this function is 
returning a static string, excellent stuff if you are hoping to reuse the 
same function like the following
printk("%s %s\n",in_ntoa(addr1),in_ntoa(addr2));
