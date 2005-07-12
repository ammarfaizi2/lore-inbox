Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVGLQL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVGLQL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVGLQJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:09:14 -0400
Received: from web54403.mail.yahoo.com ([68.142.225.159]:53177 "HELO
	web54403.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261523AbVGLQH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:07:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=C9ZvLK7vQ62PgizU4NMLmctz3IlU7LLEjkXqxQstZW5sKl7cAHK/ig2318T6zp1M+R0dj2JDgwEMslL7qE3HCTD3fdgXV02Dck+ZSnkauaWmEgFxYZf9o8w7/2zTPKASpnHnYUj+4VAk258rLNRQwiE7+IelWdCLygMiLNheT9g=  ;
Message-ID: <20050712160720.36388.qmail@web54403.mail.yahoo.com>
Date: Tue, 12 Jul 2005 09:07:20 -0700 (PDT)
From: "Vlad C." <vladc6@yahoo.com>
Subject: Linux On-Demand Network Access (LODNA)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent discussion on ReiserFS 4 has focused on the
advantages and disadvantages of VFS at the kernel
level versus the Desktop Environment (DE) level. I
believe network locations should be administered by
the kernel in a proposed framework called Linux
On-Demand Network Access (LODNA), which would achieve
seamless network integration regardless (or even in
the absence) of DEs, thus increasing usability.

INTRODUCTION:

When VFS is implemented at the  KDE/GNOME level, we
end up with the unfortunate situation where only
applications native to that DE can access its VFS
files. For example, Mozilla and Firefox (which are
GTK-based) can't access network locations set up under
KDE (see
https://bugzilla.mozilla.org/show_bug.cgi?id=298848).
Making an application aware of non-native VFS requires
serious amount of work, not only to use the other DE's
libraries, but also to embed miniature network clients
for every protocol the application supports.

The same problem appears in OpenOffice: even though it
can use the KDE filepicker, whenever  it accesses a
file on an SSH network location, a message pops up
saying "Protocol 'fish' is supported only partially.
Local copy of the file will be created."

If Mozilla/Firefox and OpenOffice, which are some of
the most popular applications and which have a strong
developer base, haven't yet been able to achieve
cross-VFS compatibility, you can be certain that other
applications are in the same or worse situation.

These two examples show why VFS at the DE level is a
temporary hack that only hides the need for such
functionality in the kernel. This hassle can be
completely avoided if the kernel provides standard I/O
functions for files in network locations
(ssh/webdav/ftp/smb/...) because opening and saving
network files would then become completely transparent
(i.e. no different from accessing a local file) from
the application's point of view. 

Having this functionality in the kernel would be a
huge usability plus: we would solve all these problems
in one swish, save application developers a lot of
time, and give users the peace of mind to know that
they can seamlessly access their network files no
matter what application they use.

PROPOSAL: Linux On-Demand Network Access (LODNA)

Users would be able to mount network locations under
directories they own. For example, to create a network
location on my home computer pointing to my work
computer (via ssh), I would do:
mount -t ssh username@remote.computer.com:~ 
/home/username/net/remote_computer

>From then on, whenever I change directory to
/home/username/net/remote_computer, I would be able to
see the files in my computer at work as if they were
local - no more need for fancy VPN!

Similarly, I would also be able to do:
mount -t smbfs username@remote.computer.com:~ 
/home/username/net/remote_computer
mount -t webdav username@remote.computer.com:~ 
/home/username/net/remote_computer
mount -t ftp username@remote.computer.com:~
/home/username/net/remote_computer

Advantages of LODNA:

1) Network locations would be fixed in the directory
tree, rather than float around in a DE abstraction
like fish:/ .
2) Remote files would be accessible by all
applications, even the shell.
3) LODNA would be independent of Desktop Environments
(although if present, they could provide GUIs for
things that could otherwise be done from the command
line). For example, KDE could use its existing "Add a
Network Folder" wizard to help users mount network
locations.
4) The user could give or deny other local users
access to his remote locations simply by setting the
permissions of the mount point (eg. chmod 700
/home/username/net/remote_computer).
5) LODNA would help users who want to access files on
their Local Area Network but who don't know the exact
name or IP address of the destination computer. Such
users could use KDE's Konqueror File Manager
(http://www.konqueror.org/) with the Smb4k
(http://smb4k.berlios.de/) plugin to discover all the
samba servers on their LAN. They could then simply
right-click on a  server/share and select "Mount",
which would take them to the "Add a Network Folder"
wizard.
6) LODNA would combine the transparency of NFS with
the flexibility of SSH/SMB/WebDav/FTP.
7) LODNA would allow users to build and manage their
own VPN client.

CONCLUSION:

Linux On-Demand Network Access (LODNA) is a proposed
kernel-based method for accessing network locations.
It would provide transparent, unified network access
to all applications and pave the way for highly
intuitive GUIs for managing diverse networks. As a
built-in, multi-protocol VPN client, LODNA would
greatly help employees who work from home, and be a
much needed step towards making Linux viable on the
desktop.

For now, LODNA is only a concept, but the pieces
needed to make it happen already exist - they just
need to be integrated into the kernel, perhaps as a
ReiserFS 4 plugin or by another method. I welcome your
suggestions!

Cheers,
Vlad


		
____________________________________________________
Sell on Yahoo! Auctions – no fees. Bid on great items.  
http://auctions.yahoo.com/
