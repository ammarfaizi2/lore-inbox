Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135737AbRDSOAN>; Thu, 19 Apr 2001 10:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135678AbRDSOAA>; Thu, 19 Apr 2001 10:00:00 -0400
Received: from auemail2.lucent.com ([192.11.223.163]:9413 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S135677AbRDSN7t>; Thu, 19 Apr 2001 09:59:49 -0400
Message-ID: <3ADEEF31.125FCE94@lucent.com>
Date: Thu, 19 Apr 2001 09:59:13 -0400
From: George Talbot <gtalbot@lucent.com>
Organization: Lucent, Inc.  InterNetworking Systems
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: Re: light weight user level semaphores
Content-Type: multipart/mixed;
 boundary="------------AEBD45E0AF34E2AC1DECE2C8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AEBD45E0AF34E2AC1DECE2C8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 17 Apr 2001 12:48:48 -0700 (PDT) Linus Torvalds wrote:

[deletia]

>         /*
>          * a fast semaphore is a 128-byte opaque thing,
>          * aligned on a 128-byte boundary. This is partly
>          * to minimize false sharing in the L1 (we assume
>          * that 128-byte cache-lines are going to be fairly
>          * common), but also to allow the kernel to hide
>          * data there
>          */
>         struct fast_semaphore {
>                 unsigned int opaque[32];
>         } __attribute__((aligned, 64));
> 
>         struct fast_semaphore *FS_create(char *ID);
>         int FS_down(struct fast_semaphore *, unsigned long timeout);
>         void FS_up(struct fast_semaphore *);

[deletia]

These are counting semaphores, right?  If so, would this make sense?

        struct fast_semaphore *FS_create(char *ID, int initial_count);

        [FS_down/FS_up the same]

        int     FS_get_count(struct fast_semaphore *);

The FS_get_count() is less useful, but being able to pass the initial
count to the semaphore is pretty important.

--George
--------------AEBD45E0AF34E2AC1DECE2C8
Content-Type: text/x-vcard; charset=us-ascii;
 name="gtalbot.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for George Talbot
Content-Disposition: attachment;
 filename="gtalbot.vcf"

begin:vcard 
n:Talbot;George
tel;fax:732-615-4526
tel;work:732-615-5099
x-mozilla-html:FALSE
org:Lucent, Inc.;Inter-Networking Systems
adr:;;480 Red Hill Road, Building 1;Middletown;NJ;07748;USA
version:2.1
email;internet:gtalbot@lucent.com
title:Senior Software Engineer
x-mozilla-cpt:;0
fn:George Talbot
end:vcard

--------------AEBD45E0AF34E2AC1DECE2C8--

