Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269218AbUHZRYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269218AbUHZRYE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269185AbUHZRU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:20:28 -0400
Received: from smtp.terra.es ([213.4.129.129]:15234 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id S269275AbUHZRJD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:09:03 -0400
Date: Thu, 26 Aug 2004 19:05:48 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Rik van Riel <riel@redhat.com>
Cc: jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040826190548.3e67726f.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com>
References: <20040826154446.GG5733@mail.shareable.org>
	<Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 26 Aug 2004 11:54:51 -0400 (EDT) Rik van Riel <riel@redhat.com> escribió:

> And if an unaware application reads the compound file
> and then writes it out again, does the filesystem
> interpret the contents and create the other streams ?

If the old utils doesn't support streams there's no way to make them create
streams. There's not a real solution for that except fixing the old tools.

Why instead of being "compound" you just make test.compound to
behave as a real directory? ie:

# echo "foo" > streamfile
# echo "fake metadata" > streamfile/somemetadata
# cat streamfile
foo
# cat streamfile/somemetadata
fake metadata

Now the old backup utils could see "streamfile" as a directory, ie:
old apps could see that "streamfile" is a directory and then make
their backups with the following contents:
streamfile/somemetadata
streamfile/defaultstream

The defaultstream would be what its name means. There could be more
default streams like "streamfile/compoundstream"

All this looks like reinventing the file/directory concept wheel. Instead of
adding support for streams and "use files as directories", why not orientate
it to "use directories as files? Streams could very well be provided
by directories containing files, with the addon of being able to cat
a directory (which would cat the output of a designed file inside
every directory like "defaultstream", then there could be other
"special files" like "compoundstream", although the idea of "fixed name-
special files" doesn't sounds very cool) All this could be very well
provided done userspace, but then couldn't userspace also supply the whole VFS 
functionality and still it lives in the kernel...?

