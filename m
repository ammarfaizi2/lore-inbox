Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTCDWV2>; Tue, 4 Mar 2003 17:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbTCDWV2>; Tue, 4 Mar 2003 17:21:28 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:2272 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S261874AbTCDWVZ>;
	Tue, 4 Mar 2003 17:21:25 -0500
Date: Tue, 4 Mar 2003 23:31:52 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Uwe Reimann <linux-kernel@pulsar.homelinux.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Direct access to parport
In-Reply-To: <3E646091.6070004@pulsar.homelinux.net>
Message-ID: <Pine.LNX.4.52.0303042329450.18334@ally.lammerts.org>
References: <3E646091.6070004@pulsar.homelinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Mar 2003, Uwe Reimann wrote:
> I'd like to connect some self made hardware to the parallel port and
> read the values of the dataline using linux. Can this be done in
> userspace or do I have to write kernel code to do so? I'm currently
> thinking of writing a device like lp, which in turn uses the parport
> device. Does this sound like a good idea?

>From userspace it's quite simple:

#include <stdio.h>
#include <sys/io.h>

int main(int argc, char **argv)
{
	int addr = 0x378;

	if(ioperm(addr, 3, 1) == -1) {
		perror("ioperm");
		exit(1);
	}
	printf("0x%02x\n", inb(addr + 1));
}

The ioperm() only works if you're root.

Eric
