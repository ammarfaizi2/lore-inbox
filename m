Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTEGHgd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 03:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbTEGHgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 03:36:33 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:40323
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262955AbTEGHgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 03:36:32 -0400
Message-ID: <3EB8BA67.4060708@redhat.com>
Date: Wed, 07 May 2003 00:48:55 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030505
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Piel <Eric.Piel@Bull.Net>
CC: george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: DELAYTIMER_MAX is defined
References: <3EB7E3DA.C50258A9@Bull.Net> <3EB81719.3050705@mvista.com> <3EB8B5EA.BD5D1C19@Bull.Net>
In-Reply-To: <3EB8B5EA.BD5D1C19@Bull.Net>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eric Piel wrote:

>>>Playing around with the posix timers I've noticed that DELAYTIMER_MAX is
>>>not defined. This constant is specified in the POSIX specifications. It
>>>should contain the maximum possible value of overruns on a signal. It is
>>>also said that the overrun shouldn't overflow. cf
>>>http://www.opengroup.org/onlinepubs/007904975/functions/timer_getoverrun.html

This is not correct.  The constant does not have to be defined.  Like
all the various *_MAX constants they only have to be defined if there is
a fixed limit the implementation has.  If there is none or it can only
be defined dynamically at runtime the the macro must not be defined.
Instead sysconf() can provide the value.  But not even this is
necessary.  sysconf() can return -1.

Anyway, in this specific case the implementation should be protected
against the ever so improbable overflow of the counter, yes.  If you
want a fixed value, fine.  If you want to use ULONG_MAX (or whatever),
good too.  Whether we advertise this limit is another thing.
Advertising it in the macro means it never can be changed.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+uLpr2ijCOnn/RHQRAgiAAKCIj4hn7m/lkOIrLjHjqirTFPfvhQCeLbxB
cl9pJ+BTHy7VQzpCDeyjmSs=
=WTUD
-----END PGP SIGNATURE-----

