Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287212AbSASMkR>; Sat, 19 Jan 2002 07:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289210AbSASMkE>; Sat, 19 Jan 2002 07:40:04 -0500
Received: from fungus.teststation.com ([212.32.186.211]:22035 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S287200AbSASMjz>; Sat, 19 Jan 2002 07:39:55 -0500
Date: Sat, 19 Jan 2002 13:39:53 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [question] implentation of smb-browsing: kernel space or user
 space?
In-Reply-To: <E16RtOX-0007Ao-00@mrvdom00.kundenserver.de>
Message-ID: <Pine.LNX.4.33.0201191313170.4434-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jan 2002, Christian Bornträger wrote:

> Hello,
> 
> I think that using the smb-file-system with a user-space mounter like 
> mkautosmb has the problem of bad scalability in large networks, because it 
> scans the whole network before you can access one share.

You don't need to scan on every access. You could run the scanner only if
it was more than x minutes since the last scan. You could run the scanner
independently of any attempts to access autofs.

> The first step might be to glue the autofs with smbfs and add a kernel smb 
> browser as a proof of concept.

autofs works fine with smbfs as it is (except for not allowing space in
the share names, but that belongs on a different mailinglist and isn't
smbfs specific).

I think you can do what you want with an executable autofs map and some
network scanning daemon that "knows" what the smb network looks like.
Perhaps samba's nmbd can be made to talk to it.

You could build a browsing tool that would work on any OS with an
automounter (BSD has a smbfs too, nowadays).

Or just use LinNeighbourhood (http://www.bnro.de/~schmidjo/)


> My question is: Do you think, that this kind of filesystem is sensible, or do 
> you think that smb-stuff has to be in user space. (for example using the 
> filesystem in userspace approach, shown some weeks ago)?

I see no advantage of doing the browsing in kernel space. You want to use
the samba codebase as much as possible.

The advantage of having smbfs in the kernel is speed (current
implementation doesn't really take full advantage of that ...). You can do
smbfs as a userspace filesystem, possibly re-using libsmb from samba. It 
has been suggested before.

/Urban

