Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTDXSVJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 14:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbTDXSVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 14:21:08 -0400
Received: from palrel10.hp.com ([156.153.255.245]:42908 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263806AbTDXSVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 14:21:05 -0400
Date: Thu, 24 Apr 2003 11:33:14 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, davem@redhat.com, kuznet@ms2.inr.ac.ru
Subject: [BUG 2.5.X] pipe/fcntl/F_GETFL/F_SETFL obvious kernel bug
Message-ID: <20030424183313.GA17374@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	I reported this obvious kernel 2.5.X bug 6 months ago, and as
of 2.5.67 it is still not fixed. Do you know who I should send this
bug report to ?
	Thanks...

	Jean

---------------------------------------------
	Compile test program below.
	On 2.5.67 :
GET FLAGS : 0 - 40044F18
SET FLAGS : -1 - 22
	On 2.4.21-pre7 :
GET FLAGS : 0 - 40043F18
SET FLAGS : 0 - 0
---------------------------------------------
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <stdio.h>

int main()
{
  int trigger_pipe[2];
  int err;
  int flags;

  pipe(trigger_pipe);

  err = fcntl(trigger_pipe[0], F_GETFL, &flags);
  fprintf(stderr, "GET FLAGS : %d - %X\n", err, flags);
  if(err >= 0)
    {
      flags |= O_NONBLOCK;
      //flags |= O_NDELAY;
      //flags &= ~O_NDELAY;
      err = fcntl(trigger_pipe[0], F_SETFL, flags);
      fprintf(stderr, "SET FLAGS : %d - %d\n", err, errno);
    }
  return(0);
}


