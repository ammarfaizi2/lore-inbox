Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUDAPpd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 10:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUDAPpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 10:45:33 -0500
Received: from bay2-f59.bay2.hotmail.com ([65.54.247.59]:57094 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261779AbUDAPp0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 10:45:26 -0500
X-Originating-IP: [209.172.74.2]
X-Originating-Email: [idht4n@hotmail.com]
From: "David L" <idht4n@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: serial port canonical mode weirdness?
Date: Thu, 01 Apr 2004 07:45:19 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F59A7JVwzf8pTL0003f16c@hotmail.com>
X-OriginalArrivalTime: 01 Apr 2004 15:45:20.0123 (UTC) FILETIME=[565D2CB0:01C41800]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > When I configure a serial port for canonical mode (newtio.c_lflag = 
>ICANON),
> > I get behavior that isn't what I'd expect.
>
>Can you supply the test program you're using on the receive end?
>
>--
#include <termios.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>

#define BAUDRATE B38400
#define SERIALDEVICE "/dev/ttyS0"

int main()
{
  int fd, res;
  struct termios newtio;
  unsigned char buf[10000];

  fd = open(SERIALDEVICE, O_RDWR);
  if (fd <0) {perror(SERIALDEVICE); return -1; }

  bzero(&newtio, sizeof(newtio));

  newtio.c_cflag = BAUDRATE | CS8 | CLOCAL | CREAD;
  newtio.c_iflag = IGNPAR;
  newtio.c_lflag = ICANON;

  newtio.c_cc[VEOL]     = 0x0D;

  tcsetattr(fd,TCSANOW,&newtio);

  while (1) {
    res = read(fd,buf,9000);
    printf("%d bytes read (%d)\n", res, errno);
    printf("%02X %02X %02X %02X %02X %02X\n", 
buf[0],buf[1],buf[2],buf[3],buf[4],buf[5]);
  }
}

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar – get it now! 
http://toolbar.msn.com/go/onm00200415ave/direct/01/

