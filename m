Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSEODTu>; Tue, 14 May 2002 23:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316310AbSEODTt>; Tue, 14 May 2002 23:19:49 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:30988 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316309AbSEODTt>;
	Tue, 14 May 2002 23:19:49 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205150318.g4F3IPY103245@saturn.cs.uml.edu>
Subject: Re: [RFC] FAT extension filters
To: msmith@operamail.com (Malcolm Smith)
Date: Tue, 14 May 2002 23:18:25 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
In-Reply-To: <3CE1CA10.F1778F41@operamail.com> from "Malcolm Smith" at May 15, 2002 12:38:08 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (Sorry if I'm doing stupid things - I'm a newbie.  Send me a private
> email and I'll fix them.)
>
> This is a patch that adds an extra mount option for msdos/vfat
> partitions, which allows you to specify a specific umask/uid/gid for
> files with a particular extension.  Supports multiple filters using
> linked list.  Note that this does not provide security on an inherently
> insecure fs.
>
> Use -o filter=ext[:[umask][:[uid][:[gid]]]]

Some ideas:

1. use this to express the existing showexec option
2. make this work for all non-UNIX filesystems
3. specify the data some other place

While you're hacking around FAT stuff, see about
using the timestamp of the volume name file for
the root directory. Remember that very old
filesystems won't have a volume name file, so
you might need to create one.

Also I found a bug in the vfat code. It doesn't
properly handle old (pre-vfat) files with names
that start with 0xE5; these are stored on disk
with 0x05 as the first character.

