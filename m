Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266667AbUF3Naw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266667AbUF3Naw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 09:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUF3Naw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 09:30:52 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:9615 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S266667AbUF3Nat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 09:30:49 -0400
Date: Wed, 30 Jun 2004 09:30:11 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: per-process namespace?
In-reply-to: <1088547899.4788.41.camel@dyn319623-009047021109.beaverton.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Message-id: <40E2C063.2010806@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <1088534826.2816.38.camel@dyn319623-009047021109.beaverton.ibm.com>
 <40E1DABD.9000202@sun.com>
 <1088547899.4788.41.camel@dyn319623-009047021109.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ram Pai wrote:
> On Tue, 2004-06-29 at 14:10, Mike Waychison wrote:
>
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Ram Pai wrote:
>>
>>>Is there a way for an application to
>>>1. fork its own namespace and modify it, and
>>>2. still be able to see changes to the system namespace?
>>>
>>>Al Viro's Per-process namespace implementation provides the first
>>>feature.  But is there any work done to do the second part? Is it worth
>>>doing?
>>>
>>>RP
>>
>>In what sense?
>>
>>The current model has no definition for a 'system namespace'.
>
>
> by 'system namespace' I mean the very first initial  hand-crafted
> namespace.
>

The problem is that namespaces have no inherent hierarchy to them.  Once
you create one, all relation to the parenting namespace is lost.  You
can't even tell if you are in a different namespace from the 'system
namespace' other than by comparing /proc/self/mounts with /proc/1/mounts.

>
>>Accessing /proc/<pid>/mounts where <pid> is running in a different
>>namespace appears to work.
>
>
> Are you sure? I dont see it to be the case. I just verified it  on 2.6.7
> /proc/<pid>/mounts is a file. However /proc/pid/root is a symbolic link
> to the root directory of the process. So the process with a cloned
> namespace wont be able to access it through its namespace.
>
>

Yes.  mounts gives you the mount-table.  root is a symbolic link.  You
can obtain the fd across a fork or over a unix socket.  Proc doesn't
give you any magic files to access namespaces directly.


- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4sBidQs4kOxk3/MRAgFUAJ0V19QWPRhT3OMJeSi/2cGhwpJB1ACePHSE
aYAsHb1TNiY7bs7a+FFBsno=
=qpir
-----END PGP SIGNATURE-----
