Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWHTBg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWHTBg6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 21:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbWHTBg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 21:36:58 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:8890 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932365AbWHTBg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 21:36:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uSyo7HmIqji6dsujypRho9Rqa3oml0JmjZVVYJ34bGez+KaCUFob9nbTSJl5TV/sZOC7Zr38mSHuHguIMO8mdw/glT0hB3eYqoIk0XiACV9XFZJRb8i/9ai5T8HMWZY5GWGI0CATDls4sDwlqfhz4p3Cs92mnS2d5i0QZspenN8=
Message-ID: <4ae3c140608191836we4603c0qa61d5631161a482d@mail.gmail.com>
Date: Sat, 19 Aug 2006 21:36:57 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Where does NFS client associate the file handle received from server with inode?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into a problem:

I extend several fields to file handle, and change compose_fh() to
initialize some value into the file handle. I think the client side
should be able to associate the file handle with inode and used them
properly afterwards.  However, I found a problem:

Say I have a program 'postmark" in /tmp, and my current directory is /

If I do '/tmp/postmark', getattr() funciton will not use the right
file handle with extension. Instead, it seems to use a file handle
excluding my extension

but if I change to '/tmp', do 'ls -al' first, then I do 'postmark',
getattr() will use the right file handle.

So I think maybe I need to change NFS client to associate the extened
file handle with inode . But I don't know where NFS client does this.
Can someone give me a help?

Many thanks!

-x
