Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317142AbSEXPJk>; Fri, 24 May 2002 11:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317146AbSEXPJi>; Fri, 24 May 2002 11:09:38 -0400
Received: from daimi.au.dk ([130.225.16.1]:1375 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317142AbSEXPIO>;
	Fri, 24 May 2002 11:08:14 -0400
Message-ID: <3CEE5756.69DF322F@daimi.au.dk>
Date: Fri, 24 May 2002 17:08:06 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre8-ac5 swsusp panic
In-Reply-To: <20020524011322.GA6612@merlin.emma.line.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my system I'm actually able to suspend and start
the system again using kernel 2.4.19-pre8-ac5. But
there are some problems.

If there is not enough free physical memory it
complaints about not enough free memory and system
continues without suspending. However runing this
program before suspending helps:

#define BUFSIZE (1024*1024*256)
int main()
{
  char *buf = malloc(BUFSIZE);
  int i;
  for (i=0;i<BUFSIZE;i+=4096) buf[i]++;
  return 0;
}

There is plenty of swap space on my system, so that
is not a problem.

When the system has been started again after a
suspend my PS/2 mouse and my serial logins are
all dead. Restarting gpm and sending a SIGHUP to
the serial logins get the connections to live up.
But if I start X all input devices die, but the
screen output is correct and keep getting updated.

Finally ntpd does complain about loosing sync.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
