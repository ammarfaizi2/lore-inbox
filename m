Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbTDGCpK (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 22:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTDGCpK (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 22:45:10 -0400
Received: from user72.209.42.38.dsli.com ([209.42.38.72]:62724 "EHLO
	nolab.conman.org") by vger.kernel.org with ESMTP id S263202AbTDGCpI (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 22:45:08 -0400
Date: Sun, 6 Apr 2003 22:56:42 -0400 (EDT)
From: Mark Grosberg <mark@nolab.conman.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
Message-ID: <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Apr 6 2003, H. Peter Anvin wrote:

> > Suppose I give you an O_RDONLY handle to a file which you then
> > flink and gain write access too ?
>
> This, I believe, is the real issue.  However, we already have that
> problem:

As far as I understand it, isn't the protection information stored in the
inode? The flink call is just linking an inode into a directory that the
caller has write access to. The permissions and ownership of the file
shouldn't change.

> int main(int argc, char *argv[])
> {
>   int rfd, wfd;
>   char filebuf[PATH_MAX];
>
>   rfd = open("testfile", O_RDONLY|O_CREAT, 0666);
>   /* Now rfd is a read-only file descriptor */

There is nothing stopping the caller from re-opening the to-be flinked()
file descriptor read-write using its name if the caller has permissions.
So I don't see why that case is different.

Other than that, HPA's responses make sense.

Personally, I would like to see this system call in Linux. It does make
certain thing easier. Not necessarily even in a security context, but
sometimes its generally useful to be able to make a hard link to an
already open file rather than track the name.

L8r,
Mark G.


