Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266067AbUFVWbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266067AbUFVWbD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 18:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUFVW3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 18:29:34 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:31171 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S266014AbUFVW1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 18:27:47 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       linux ia64 kernel <linux-ia64@vger.kernel.org>
Subject: Re: Does parallel make work for modules? 
In-reply-to: Your message of "Tue, 22 Jun 2004 15:08:13 MST."
             <20040622220813.GA306@lucon.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 23 Jun 2004 08:27:35 +1000
Message-ID: <27002.1087943255@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004 15:08:13 -0700, 
"H. J. Lu" <hjl@lucon.org> wrote:
>When building 2.6.7 on a 4way Linux/ia64, "make -j4 modules" doesn't
>spawn 4 jobs. I got
>
> 5756 pts/0    S      0:00 make -s -j4 modules
> 5868 pts/0    S      0:00 make -f scripts/Makefile.build obj=fs
> 7240 pts/0    S      0:00 make -f scripts/Makefile.build obj=fs/nfs
> 7269 pts/0    S      0:00 /bin/sh -c set -e; ?   gcc -Wp,-MD,fs/nfs/.pagelist.o. 
> 7270 pts/0    S      0:00 gcc -Wp,-MD,fs/nfs/.pagelist.o.d -nostdinc -iwithprefi
> 7271 pts/0    S      0:00 /usr/gcc-3.4/libexec/gcc/ia64-unknown-linux-gnu/3.4.1/
> 7272 pts/0    R      0:00 as -x -o fs/nfs/pagelist.o -
>
>2.4 kernel module build work fine. Any ideas?

Works for me, GNU Make version 3.79.1 building 2.6.7 on ia64.  make -j8
modules gives a pstree of

bash(2475)---make(29483)-+-make(29806)---make(30111)---make(30112)---sh(30113)---gcc(30114)-+-as(30116)
                         |                                                                  `-cc1(30115)
                         `-make(29857)-+-make(29938)---sh(30153)---gcc(30154)-+-as(30156)
                                       |                                      `-cc1(30155)
                                       |-make(30103)-+-sh(30104)---gcc(30105)-+-as(30107)
                                       |             |                        `-cc1(30106)
                                       |             `-sh(30146)---gcc(30147)-+-as(30149)
                                       |                                      `-cc1(30148)
                                       `-make(30130)---sh(30131)---gcc(30132)-+-as(30134)
                                                                              `-cc1(30133)

Not the full blown 8 way that I asked for, but that is an artifact of
using recursive make instead of a single top level Makefile with all
the dependencies.

