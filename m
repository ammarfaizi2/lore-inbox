Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTENSrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTENSrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:47:07 -0400
Received: from corky.net ([212.150.53.130]:60626 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S263633AbTENSrG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:47:06 -0400
Date: Wed, 14 May 2003 21:59:47 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Ahmed Masud <masud@googgun.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.]
In-Reply-To: <20030514162323.GB16093@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0305142152500.12748-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Jörn Engel wrote:

> On Wed, 14 May 2003 12:13:03 -0400, Ahmed Masud wrote:
> >
> > The idea is to have encryption keys for the pages to be unique on a
> > per-uid per-process basis. So one user on the system cannot access (even
> > if they are root) parts of another's private data.  To achieve this,
> > different parts of swap device need to be encrypted with different keys.
>
> How do user *know* that root cannot simply bypass this security?
>
> Root, god, what's the difference? ;-)

Aside from what Ahmed said about about rootless systems, the per-process
encryption reduces the window of opportunity for attackers who gain root
(or physical access).

Try strings(1) on your swap device.  You'll be surprised at what you find.
You'll probably recognize passwords you haven't useds for a long time, and
a lot of other stuff you didn't expect.  Sometimes you can find whole ssh
sessions there, plaintext.  (think xterm scroll buffer).

With per-process encryption, even if root decides to read the swap at some
point (evil admin or an attacker who 0wn3d the box), the leakage is
limited to processes currently running.

	Yoav

