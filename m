Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318392AbSIKG4W>; Wed, 11 Sep 2002 02:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318407AbSIKG4W>; Wed, 11 Sep 2002 02:56:22 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:16147 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S318392AbSIKG4V>; Wed, 11 Sep 2002 02:56:21 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: the userspace side of driverfs
Date: Wed, 11 Sep 2002 07:00:45 +0000 (UTC)
Organization: Cistron
Message-ID: <almpmt$rmi$1@ncc1701.cistron.net>
References: <1031707119.1396.30.camel@entropy> <Pine.LNX.4.44.0209102122520.1057-100000@cherise.pdx.osdl.net>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1031727645 28370 62.216.29.67 (11 Sep 2002 07:00:45 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0209102122520.1057-100000@cherise.pdx.osdl.net>,
Patrick Mochel  <mochel@osdl.org> wrote:
>The main ideal that we're shooting for is to have one ASCII value per
>file. The ASCII part is mandatory, but there will definitely be exceptions
>where we will have an array of or multiple values per file. We want to
>minimize those instances, though. Both for the sake of easy parsing, but
>also for easy formatting within the drivers.

If you have multiple values per file, why not make it a directory with
multiple files in it, each with one value per file.

If you care about speed, perhaps you can provide a ".array" virtual
file in such a (or each) directory, that when read returns all files
in the directory in "filename: value" format so that you avoid the
while (readdir()) { open(); close(); } overhead.

This would be much cleaner, think for example of how you would
otherwise _write_ individual entries in such an array.

If you really want to get overboard, provide a sysctl() like function
that can read the entries in driverfs in binary. Like the existing
sysctl() in linux, but with an added TYPE_INT, TYPE_STRING etc flag
for each value for consistency. It too should be able to read an
entire directory as an array.

Then, convert procfs to the same interface ;)

Mike.

