Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUEIAKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUEIAKu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 20:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbUEIAKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 20:10:50 -0400
Received: from vinc17.net1.nerim.net ([62.4.18.82]:24935 "EHLO ay.vinc17.org")
	by vger.kernel.org with ESMTP id S263731AbUEIAKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 20:10:48 -0400
Date: Sun, 9 May 2004 02:10:45 +0200
From: Vincent Lefevre <vincent@vinc17.org>
To: linux-kernel@vger.kernel.org
Subject: [2.4.26] overcommit_memory documentation clarification
Message-ID: <20040509001045.GA23263@ay.vinc17.org>
Mail-Followup-To: Vincent Lefevre <vincent@vinc17.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer-Info: http://www.vinc17.org/mutt/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The documentation of overcommit_memory in Documentation/sysctl/vm.txt
should be clarified, as with the following simple program, malloc()
never returns 0 on an official 2.4.26 kernel, even if overcommit_memory
has been set to 0. Running it has the effect of having random processes
killed, and eventually this process itself.

/* $Id: malloc.c 2753 2004-03-16 15:23:09Z lefevre $
 *
 * malloc() test
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ONEMB 1048576

int main (void)
{
  char *p;
  int i;

  for (i = 1; (p = malloc(ONEMB)) != NULL; i++)
    {
      printf ("Got %d MB\n", i);
      memset (p, 0, ONEMB);
    }
  printf ("malloc() failed - OK\n");
  return 0;
}

(After some discussions, it appears not to be a bug in the glibc
<http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=247300>.)

-- 
Vincent Lefèvre <vincent@vinc17.org> - Web: <http://www.vinc17.org/>
100% validated (X)HTML - Acorn / RISC OS / ARM, free software, YP17,
Championnat International des Jeux Mathématiques et Logiques, etc.
Work: CR INRIA - computer arithmetic / SPACES project at LORIA
