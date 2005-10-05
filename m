Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbVJELNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbVJELNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 07:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbVJELNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 07:13:14 -0400
Received: from free.hands.com ([83.142.228.128]:53669 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S932595AbVJELNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 07:13:14 -0400
Date: Wed, 5 Oct 2005 12:13:05 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005111305.GS10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com> <200510050122.39307.dhazelton@enter.net> <4343694F.5000709@perkel.com> <17219.39868.493728.141642@gargle.gargle.HOWL> <20051005095653.GK10538@lkcl.net> <17219.43860.610103.628963@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17219.43860.610103.628963@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 02:30:44PM +0400, Nikita Danilov wrote:
> Luke Kenneth Casson Leighton writes:
>  > On Wed, Oct 05, 2005 at 01:24:12PM +0400, Nikita Danilov wrote:
>  > 
>  > > Marc Perkel writes:
>  > > 
>  > > [...]
>  > > 
>  > >  > Right - that's Unix "inside the box" thinking. The idea is to make the 
>  > >  > operating system smarter so that the user doesn't have to deal with 
>  > >  > what's computer friendly - but reather what makes sense to the user. 
>  > >  >  From a user's perspective if you have not rights to access a file then 
>  > >  > why should you be allowed to delete it?
>  > > 
>  > > Because in Unix a name is not an attribute of a file.
>  >  
>  >  there is no excuse.
>  > 
>  >  selinux has already provided an alternative that is similar to NW
>  >  file permissions.
> 
> That's exactly the point: Unix file system model is more flexible than
> alternatives. 

 *grin*.  sorry - i have to disagree with you (but see below).

 i was called in to help a friend of mine at EDS to do a bastion sftp
 server to write some selinux policy files because POSIX filepermissions
 could not fulfil the requirements.

 the requirements were two-fold:

 1) for an authorised uploader to be able to copy files into
 a subdirectory but to be banned from seeing other files and
 banned from overwriting or deleting anything - existing or
 uploaded.  once the file's there, it's there.

 2) for an authorised downloader to be able to copy files _out_
 of a subdirectory and to be able to delete those files but
 to be banned from overwriting files, or modifying files,
 or adding files to the subdirectory.

 it is not possible to fulfil those requirements with POSIX - not even
 POSIX ACLs not even messing about creating groups with different rwx
 permissions.

 however, selinux was, because you have separate permissions for
 directories to create and remove names, read and write to the
 directory, and separate permissions _again_ for files.

 basically, i think (without checking) that there is one
 selinux permission per each inode operation and per each
 dnode operation totalling somewhere around thirty separate
 selinux filesystem permissions, which is _much_ better than
 the pathetic POSIX rwx and implicit directory rules stuff.

 POSIX permissions were designed to fit into what... 16 bits,
 so they didn't have a lot to play with.

 if i was to agree with you, it would be that the linux filesystem
 API is more flexible than the alternatives, most definitely not the
 Unix filesystem model (if you believe that to be POSIX).

 but the linux filesystem API i do not believe to be _as_ flexible as
 say the NTFS filesystem API (or the Netware one, although i don't know
 much about that one).

 l.

