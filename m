Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291520AbSBNMUa>; Thu, 14 Feb 2002 07:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291549AbSBNMUK>; Thu, 14 Feb 2002 07:20:10 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:52241 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S291519AbSBNMT6>; Thu, 14 Feb 2002 07:19:58 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: RFC: /proc key naming consistency
Date: Thu, 14 Feb 2002 12:19:57 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <a4ga1d$jov$1@ncc1701.cistron.net>
In-Reply-To: <Pine.LNX.4.33.0202141020140.5260-100000@dbsydn2001.aus.deuba.com>
Content-Type: text/plain; charset=iso8859-15
X-Trace: ncc1701.cistron.net 1013689197 20255 195.64.65.67 (14 Feb 2002 12:19:57 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0202141020140.5260-100000@dbsydn2001.aus.deuba.com>,
Luke Burton  <luke.burton@db.com> wrote:
>A compatibility mode might be useful. Either a straight config option, or
>perhaps something more sophisticated. Idea: perhaps proc functions
>installed with create_proc_read_entry could, rather than just write
>strings to buffers, return a list of key/value pairs which is rendered in
>some configurable format by a new function, like "proc_render_values".
>proc_render_values could use a column format like it does now, or a shell
>parseable foo=blah\n format.

Why not one value per file, as has been proposed often here.

You could have /proc/sys/cpu/0/processor
               /proc/sys/cpu/0/vendor_id
               /proc/sys/cpu/0/family

... and a /proc/sys/cpu/0/.table that when read produces

processor=0
vendor_id=GenuineIntel
family=6

.. so you have the best of both worlds. And you could support a
sysctl() system call that reads out the same value *in binary*
so you don't need the printf() -> sscanf() conversion.

The current sysctl_args struct does need an extra "oldtype" and "newtype"
value in there, which could be set to SYSCTL_TYPE_IP, SYSCTL_TYPE_INT4,
SYSCTL_TYPE_STRING, etc and which could be ORed with SYSCTL_FMT_ASCII
or SYSCTL_FMT_BINARY

sysctl also needs a way to get an entire tree (the .table entry)
in just one call.

So I advocate having /proc and sysctl() being just 2 ways to access
the same namespace, having one value per file, and having a way
to read a entire tree or directory at once.

Mike.
-- 
Computers are useless, they only give answers. --Pablo Picasso

