Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbTAVSWu>; Wed, 22 Jan 2003 13:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbTAVSWu>; Wed, 22 Jan 2003 13:22:50 -0500
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:51679 "EHLO
	mailhost.ens-lyon.fr") by vger.kernel.org with ESMTP
	id <S262418AbTAVSWu>; Wed, 22 Jan 2003 13:22:50 -0500
Date: Wed, 22 Jan 2003 19:31:48 +0100
From: Brice Goglin <bgoglin@ens-lyon.fr>
To: linux-kernel@vger.kernel.org
Cc: tigran@veritas.com, davej@suse.de, hpa@zytor.com, akpm@digeo.com
Subject: copy_from_user broken on i386 since 2.5.57
Message-ID: <20030122183148.GB23109@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Trying to compile a very very simple module for 2.5,
I got an error from gcc saying that assembly code
is incorrect.
This problem appeared in 2.5.57 and is still here
in 2.5.59.
I only tried on i386.

Here's a very simple example code :

#define __KERNEL__
#define MODULE
#include "linux/module.h"
#include "asm/uaccess.h"

int func(void *to, const void *from) {
  return __copy_from_user(to, from, 1);
}


Here's gcc report :

mp760:~/tmp% gcc user.c -c -o user.o -Ipath_to_2.5.57/include
/tmp/cceAbcRd.s: Assembler messages:
/tmp/cceAbcRd.s:120: Error: `%al' not allowed with `movl'
/tmp/cceAbcRd.s:124: Error: `%al' not allowed with `xorl'
/tmp/cceAbcRd.s:209: Warning: using `%eax' instead of `%ax' due to `l' suffix
/tmp/cceAbcRd.s:213: Warning: using `%eax' instead of `%ax' due to `l' suffix
/tmp/cceAbcRd.s:213: Warning: using `%eax' instead of `%ax' due to `l' suffix


Regards

Brice Goglin
============
Ph.D Student
Laboratoire de l'Informatique et du Parallélisme
ENS Lyon
France
