Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265751AbSKAUzG>; Fri, 1 Nov 2002 15:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265752AbSKAUzF>; Fri, 1 Nov 2002 15:55:05 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:2955 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265751AbSKAUzD>; Fri, 1 Nov 2002 15:55:03 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: Hans Reiser <reiser@namesys.com>
Subject: Re: [PATCH]: reiser4 [0/8] overview
Date: Fri, 1 Nov 2002 22:01:01 +0100
User-Agent: KMail/1.4.3
Cc: Nikita Danilov <Nikita@namesys.com>, linux-kernel@vger.kernel.org
References: <200210311910.48774.m.c.p@wolk-project.de> <200210311931.08347.m.c.p@wolk-project.de> <3DC2EA6D.1070200@namesys.com>
In-Reply-To: <3DC2EA6D.1070200@namesys.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_P11X52BAKRVVP80H74QY"
Message-Id: <200211012201.01990.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_P11X52BAKRVVP80H74QY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 01 November 2002 21:56, Hans Reiser wrote:

Hi Hans,

> >Does not occur with ReiserFS 3 from 2.5.45 nor with any other FS doing
> > those small stress test. My personal impression is that Reiser4 is sl=
ower
> > than 3 but that might be because of above debugging.
> >I hope this helps.
> Please give us a script which is slower than v3 for us to reproduce
> with, and we will start analyzing it.
Ok. Just small ones:

1. time seq -f "%06.0f" 1 100000  | xargs touch

2. while true; do dd if=3D/dev/zero of=3D/largefile bs=3D16384 count=3D13=
1072; done

3. attached.


ciao, Marc
--------------Boundary-00=_P11X52BAKRVVP80H74QY
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="randfiles.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="randfiles.c"

/*
 * randfiles.c
 *
 * Usage: randfiles <basename> <count> <echo?>
 *
 * For benchmarking create performance - create <count> files with
 * numbered names, in random order.  The <echo?> flag, if y, echoes
 * filenames created.  For example, 'randfiles foo 10 y' will create
 * 10 empty files with names ranging from foo0 to foo9.
 *
 * copyleft: Daniel Phillips, Oct 6, 2001, phillips@nl.linux.org
 *
 */

#include <stdlib.h>

#define swap(x, y) do { typeof(x) z = x; x = y; y = z; } while (0)

int main (int argc, char *argv[])
{
	int n = (argc > 2)? strtol(argv[2], 0, 10): 0;
	int i, size = 50, show = argc > 3 && !strncmp(argv[3], "y", 1);
	char name[size];
	int choose[n];
	for (i = 0; i < n; i++) choose[i] = i;
	
	for (i = n; i; i--)
	{
		int j = rand() % i;
		swap(choose[i-1], choose[j]);
	}
	
	for (i = 0; i < n; i++)
	{
		snprintf(name, size, "%s%i", argv[1], choose[i]);
		if (show) printf("create %s\n", name);
		close(open(name, 0100));
	}
	return 0;
}

--------------Boundary-00=_P11X52BAKRVVP80H74QY--

