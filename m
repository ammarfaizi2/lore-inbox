Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTJAOID (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTJAOID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:08:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:54656 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262108AbTJAOH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:07:56 -0400
Date: Wed, 1 Oct 2003 10:09:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jurjen Oskam <jurjen@stupendous.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: File Permissions are incorrect. Security flaw in Linux
In-Reply-To: <20031001135322.GA16692@quadpro.stupendous.org>
Message-ID: <Pine.LNX.4.53.0310011004570.3612@chaos>
References: <1065012013.4078.2.camel@lisaserver> <20031001135322.GA16692@quadpro.stupendous.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Oct 2003, Jurjen Oskam wrote:

> On Wed, Oct 01, 2003 at 06:40:13AM -0600, Lisa R. Nelson wrote:
>
> > [1.] One line summary of the problem:
> > A low level user can delete a file owned by root and belonging to group
> > root even if the files permissions are 744.  This is not in agreement
> > with Unix, and is a major security issue.
>
> This *is* in agreement with Unix. It works exactly the same on AIX, for
> example.
>
> --
> Jurjen Oskam
>

Yes. File removal is subject to DIRECTORY permissions.

Script started on Wed Oct  1 10:03:26 2003
# pwd
/tmp
# >foo
# chmod 744 foo
# ls -la
total 8
drwxrwxrwx   2 root     root         4096 Oct  1 10:03 .
drwxr-xr-x  25 root     root         4096 Oct  1 04:09 ..
-rwxr--r--   1 root     root            0 Oct  1 10:03 foo
-rw-r--r--   1 root     root            0 Oct  1 10:03 typescript
# su johnson
$ ls -la
total 8
drwxrwxrwx   2 root     root         4096 Oct  1 10:03 .
drwxr-xr-x  25 root     root         4096 Oct  1 04:09 ..
-rwxr--r--   1 root     root            0 Oct  1 10:03 foo
-rw-r--r--   1 root     root            0 Oct  1 10:03 typescript
$ pwd
/tmp
$ rm foo
rm: remove write-protected file `foo'? y
$ ls -la
total 8
drwxrwxrwx   2 root     root         4096 Oct  1 10:04 .
drwxr-xr-x  25 root     root         4096 Oct  1 04:09 ..
-rw-r--r--   1 root     root            0 Oct  1 10:03 typescript
$ exit
exit
# ls
typescript
# exit
exit
Script done on Wed Oct  1 10:04:17 2003

...So anything you put into "/tmp", for instance, can be deleted
by anybody. This is the Unix way.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


