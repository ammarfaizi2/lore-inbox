Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288149AbSAMVBJ>; Sun, 13 Jan 2002 16:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288153AbSAMVA6>; Sun, 13 Jan 2002 16:00:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62785 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S288149AbSAMVAx>; Sun, 13 Jan 2002 16:00:53 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <a1oqmm$is3$1@cesium.transmeta.com>
	<m1ofjyqb7t.fsf@frodo.biederman.org> <3C41EA0D.2050205@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Jan 2002 13:58:12 -0700
In-Reply-To: <3C41EA0D.2050205@zytor.com>
Message-ID: <m1elkuq87v.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> 
> > Comments.  Endian issues are not specified, is the data little, big
> > or vax endian?
> >
> 
> 
> Not applicable.  There are no endian-specific binary structure in the format AT
> ALL.  ASCII-coded fields are always bigendian.

O.k.  Thanks, I missed that part.  I just looked back and it is clear
that there are 32 bit values encoded in hexadecimal.  And I admit the
bigendian (human readable) is strongly implied from the context.

> > What is the point of alignment?  If the data starts as 4 byte aligned,
> > the 6 byte magic string guarantees the data will be only 2 byte
> > aligned.  This isn't good for 32 or 64 bit architectures.
> 
> 
> They're ASCII-coded, so it supposedly doesn't matter (yet, it's a bit daft, but
> blame the SysV people.)  The alignment makes sure the *data* field is 4-byte
> aligned.

O.k.  So the we have a bit of implied padding after the filename.  And
it is necessary to preserve this padding or we break with the
prexisting format definition.  You don't gain much with that as being
4 byte aligned on 64bit architectures, is not fully aligned.

> > I do like having a c_magic that at least allows us to change things
> > in the future if necessary.
> 
> 
> It's pretty clear from a lot of the comments that a number of people haven't
> understood that the cpio encapsulation *THIS IS A CODIFICATION OF AN EXISTING
> FORMAT.*

Which we are reusing for a different purpose.  And because of that we
become trustees of our version of the format.  To make it clear that
someone else defines how this format works a reference to the
appropriate specification is called for.  

I admit I did a quick search earlier and I did not find this format
specified, elsewhere.

The cases where initramfs will be used are some of the most operating
specific cases I can imagine.  To handle those cases it is necessary
to support the full breadth of the capability of the operating system.
So if initramfs is going to survive todays implementation of the linux
kernel, or possibly be portable to other operating systems we must
have an extensible format.  It appears c_magic gives us that
extensibility.

Eric
