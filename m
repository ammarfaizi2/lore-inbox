Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133119AbRDRSeB>; Wed, 18 Apr 2001 14:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132507AbRDRSd6>; Wed, 18 Apr 2001 14:33:58 -0400
Received: from ladakh.smo.av.com ([209.73.174.140]:16648 "EHLO
	ladakh.smo.av.com") by vger.kernel.org with ESMTP
	id <S135246AbRDRSdq>; Wed, 18 Apr 2001 14:33:46 -0400
Message-ID: <3ADD64DD.5D8428BA@av.com>
Date: Wed, 18 Apr 2001 02:56:45 -0700
From: Laurent Chavet <lchavet@av.com>
Organization: AltaVista Company
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Very bad behavior of kswapd
In-Reply-To: <Pine.LNX.3.96.1010418134153.20558A-100000@medusa.sparta.lu.se> <3ADD99E8.FB7F8542@coplanar.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try this (my example I've 2GB of ram)

turn all your swap off

dd about 15% of the size of your RAM:
dd if=/dev/zero of=/local/test count=300 bs=1000000

Run this program with SIZE about 95% of your RAM:

#include <stdlib.h>
#include <unistd.h>
#include <assert.h>

#define SIZE (1900 * 1024 * 1024)
int main()
{
  int i;
  char *p = malloc(SIZE);
  assert (p != NULL);
  for (i = 0; i < SIZE; i++)
 p[i] = 1;
  printf ("done %p\n", p);

  while (1)
  {
 sleep (60);
  }
  return 0;
}


Watch top: when this program needs the memory that kswapd keep in cache they go
both at 100% cpu (on SMP) but still the size of the program only grows at about
100KB/s, why is kswapd releasing it so slowly and taking so much CPU ?

Laurent Chavet

