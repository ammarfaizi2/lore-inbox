Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293040AbSB1APL>; Wed, 27 Feb 2002 19:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293087AbSB1AOJ>; Wed, 27 Feb 2002 19:14:09 -0500
Received: from zero.tech9.net ([209.61.188.187]:60934 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293091AbSB1ANn>;
	Wed, 27 Feb 2002 19:13:43 -0500
Subject: Re: [PATCH] 2.5: (better) syscalls for setting task affinity
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, mingo@elte.hu
In-Reply-To: <1014853522.1109.234.camel@phantasy>
In-Reply-To: <1014853522.1109.234.camel@phantasy>
Content-Type: multipart/mixed; boundary="=-M3NU0m+3AwUm6J9gDJSG"
X-Mailer: Evolution/1.0.2 
Date: 27 Feb 2002 19:13:47 -0500
Message-Id: <1014855228.1107.244.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M3NU0m+3AwUm6J9gDJSG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2002-02-27 at 18:45, Robert Love wrote:

> The attached patch implements a syscall interface for setting and
> retrieving a task's CPU affinity (task->cpus_allowed):

I should posted a test program to demonstrate the syscalls - find such
an attachment below.  It demonstrates using sched_get_affinity to find
the length of the cpu bitmask and then get and set a new value.

`pid_t p' is the process in question.
`unsigned long new_mask' is the new bitmask.

	Robert Love





--=-M3NU0m+3AwUm6J9gDJSG
Content-Disposition: attachment; filename=affinity.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; charset=ISO-8859-1

/*
 * Example of sched_set_affinity and sched_get_affinity
 * 	Robert Love, 20020227
 */

#include <stdio.h>
#include <stdlib.h>
#include <linux/unistd.h>
#include <unistd.h>

#define __NR_sched_set_affinity 239
#define __NR_sched_get_affinity 240

_syscall3 (int, sched_set_affinity, pid_t, pid, unsigned int, len, unsigned=
 long *, new_mask_ptr)
_syscall3 (int, sched_get_affinity, pid_t, pid, unsigned int *, user_len_pt=
r, unsigned long *, user_mask_ptr)

int main(int argc, char * argv[])
{
	unsigned long new_mask =3D 2;
	unsigned int len;
	unsigned long cur_mask;
	pid_t p =3D getpid();
	int ret;

	ret =3D sched_get_affinity(p, &len, NULL);
	printf(" len =3D %u\n", len);

	ret =3D sched_get_affinity(p, &len, &cur_mask);
	printf(" sched_get_affinity =3D %d, cur_mask =3D %ld\n", ret, cur_mask);

	ret =3D sched_set_affinity(p, len, &new_mask);
	printf(" sched_set_affinity =3D %d, new_mask =3D %ld\n", ret, new_mask);

	ret =3D sched_get_affinity(p, &len, &cur_mask);
	printf(" sched_get_affinity =3D %d, cur_mask =3D %ld\n", ret, cur_mask);

	return 0;
}

--=-M3NU0m+3AwUm6J9gDJSG--

