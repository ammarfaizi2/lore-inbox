Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVC2Eki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVC2Eki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 23:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVC2Ekh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 23:40:37 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:9104 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262173AbVC2EkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 23:40:22 -0500
Subject: Re: sched_setscheduler() and usage issues ....please help
From: Steven Rostedt <rostedt@goodmis.org>
To: Arun Srinivas <getarunsri@hotmail.com>
Cc: nickpiggin@yahoo.com.au, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <BAY10-F472EE1F6A6F80FEA2F5568D9450@phx.gbl>
References: <BAY10-F472EE1F6A6F80FEA2F5568D9450@phx.gbl>
Content-Type: multipart/mixed; boundary="=-qf1A1aREQzOOvi+Xwrmn"
Organization: Kihon Technologies
Date: Mon, 28 Mar 2005 23:40:15 -0500
Message-Id: <1112071215.3691.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qf1A1aREQzOOvi+Xwrmn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-03-29 at 08:58 +0530, Arun Srinivas wrote:
> I am trying to set the SCHED_FIFO  policy for my process.I am using 
> sched_setscheduler() function to do this.

Attached is a little program that I use to set the priority of tasks.

-- Steve

--=-qf1A1aREQzOOvi+Xwrmn
Content-Disposition: attachment; filename=setscheduler.c
Content-Type: text/x-csrc; name=setscheduler.c; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

/* Copyright (C) 2004 Kihon Technologies Inc.

   This utilities is free software, you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   These utilities are distributed in the hope that they will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307 USA.  */
/*
 * Author: Steven Rostedt
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sched.h>
#include <strutils.h>
#include <errno.h>

void usage (char **argv)
{
	char *arg = argv[0];
	char *p = arg + strlen(arg);
	while (p >= arg && *p != '/') p--;
	p++;
	fprintf(stderr,"usage: %s pid policy priority\n"
			"\n\twhere policy is SCHED_RR, SCHED_FIFO or SCHED_OTHER\n"
			"\n", p);
	exit(-1);
}

int main (int argc, char **argv)
{
	pid_t pid;
	int policy;
	struct sched_param p;
	char *strpolicy;
	
	if (argc != 4)
		usage(argv);

	strpolicy = argv[2];
	pid = atoi(argv[1]);
	p.sched_priority = atoi(argv[3]);

	if (strcmp(strpolicy,"SCHED_RR")==0) {
		policy = SCHED_RR;
	} else if (strcmp(strpolicy,"SCHED_FIFO") == 0) {
		policy = SCHED_FIFO;
	} else if (strcmp(strpolicy,"SCHED_OTHER") == 0) {
		policy = SCHED_OTHER;
	} else {
		fprintf(stderr,"\nunknown policy %s",strpolicy);
		usage(argv);
	}

	if (sched_setscheduler(pid,policy,&p)) {
		perror("sched_setscheduler");
		exit(errno);
	}
	exit(0);
}

--=-qf1A1aREQzOOvi+Xwrmn--

