Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVC3TIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVC3TIN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVC3TFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:05:36 -0500
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:758 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S262383AbVC3TDm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:03:42 -0500
To: Wiktor <victorjan@poczta.onet.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] 'nice' attribute for executable files
References: <fa.ed33rit.1e148rh@ifi.uio.no>
	<E1DGNaV-0005LG-9m@be1.7eggert.dyndns.org>
	<424ACEA9.6070401@poczta.onet.pl>
	<yw1xpsxhvzsz.fsf@ford.inprovide.com>
	<424AE18B.1080009@poczta.onet.pl>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Wed, 30 Mar 2005 21:03:37 +0200
In-Reply-To: <424AE18B.1080009@poczta.onet.pl> (Wiktor's message of "Wed, 30
 Mar 2005 19:27:39 +0200")
Message-ID: <yw1xll85vtva.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiktor <victorjan@poczta.onet.pl> writes:

> Måns Rullgård wrote:
>> It can be done entirely in userspace, if you want it.  Just hack your
>> shell to examine some extended attribute of your choice, and adjust
>> the nice value before executing files.  Then arrange to have the shell
>> run with a negative nice value.  This can be easily accomplished with
>> a simple wrapper, only for the shell.
>>
>
> this method can be applied, as you've written, only for shell (which
> have to be hacked before). so, every program that runs any other
> program should be hacked to use
> pre-execution-renice-database. rewriting all the programs in the world
> takes a bit more time than i have to the death. woudn't it be simplier
> to implement it in kernel, somewhere near setuid/setgid bits? if it
> would make system slower, support of such attribute could be optional,
> just like acl-s.

You could wrap /lib/ld-linux.so, and get all dynamically linked
programs done in one sweep.

> i've found a way to perform such function in userland, but it is
> awful, and, if some program runs another, that should be reniced, very
> often, starting a shell (even ash) for each call will surely smoke my
> cpu.

Using a shell to run external programs is quite common.  The system()
and popen() functions both invoke the shell.

> this feature without doubt belongs to kernel - it is performed every
> time kernel starts a program, and it is not so complicated like, let's
> say, hotplug support, is it?

I'm not so sure it belongs at all.  The can of worms it opens up is a
bit too big, IMHO.

-- 
Måns Rullgård
mru@inprovide.com
