Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVGLSuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVGLSuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 14:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVGLSuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:50:14 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:44797 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262099AbVGLSs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:48:57 -0400
Message-ID: <42D41096.4000209@namesys.com>
Date: Tue, 12 Jul 2005 11:48:54 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Vlad C." <vladc6@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux On-Demand Network Access (LODNA)
References: <20050712160720.36388.qmail@web54403.mail.yahoo.com>
In-Reply-To: <20050712160720.36388.qmail@web54403.mail.yahoo.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please treat at greater length how your proposal differs from NFS.

Hans

Vlad C. wrote:

>Recent discussion on ReiserFS 4 has focused on the
>advantages and disadvantages of VFS at the kernel
>level versus the Desktop Environment (DE) level. I
>believe network locations should be administered by
>the kernel in a proposed framework called Linux
>On-Demand Network Access (LODNA), which would achieve
>seamless network integration regardless (or even in
>the absence) of DEs, thus increasing usability.
>
>INTRODUCTION:
>
>When VFS is implemented at the  KDE/GNOME level, we
>end up with the unfortunate situation where only
>applications native to that DE can access its VFS
>files. For example, Mozilla and Firefox (which are
>GTK-based) can't access network locations set up under
>KDE (see
>https://bugzilla.mozilla.org/show_bug.cgi?id=298848).
>Making an application aware of non-native VFS requires
>serious amount of work, not only to use the other DE's
>libraries, but also to embed miniature network clients
>for every protocol the application supports.
>
>The same problem appears in OpenOffice: even though it
>can use the KDE filepicker, whenever  it accesses a
>file on an SSH network location, a message pops up
>saying "Protocol 'fish' is supported only partially.
>Local copy of the file will be created."
>
>If Mozilla/Firefox and OpenOffice, which are some of
>the most popular applications and which have a strong
>developer base, haven't yet been able to achieve
>cross-VFS compatibility, you can be certain that other
>applications are in the same or worse situation.
>
>These two examples show why VFS at the DE level is a
>temporary hack that only hides the need for such
>functionality in the kernel. This hassle can be
>completely avoided if the kernel provides standard I/O
>functions for files in network locations
>(ssh/webdav/ftp/smb/...) because opening and saving
>network files would then become completely transparent
>(i.e. no different from accessing a local file) from
>the application's point of view. 
>
>Having this functionality in the kernel would be a
>huge usability plus: we would solve all these problems
>in one swish, save application developers a lot of
>time, and give users the peace of mind to know that
>they can seamlessly access their network files no
>matter what application they use.
>
>PROPOSAL: Linux On-Demand Network Access (LODNA)
>
>Users would be able to mount network locations under
>directories they own. For example, to create a network
>location on my home computer pointing to my work
>computer (via ssh), I would do:
>mount -t ssh username@remote.computer.com:~ 
>/home/username/net/remote_computer
>
>>From then on, whenever I change directory to
>/home/username/net/remote_computer, I would be able to
>see the files in my computer at work as if they were
>local - no more need for fancy VPN!
>
>Similarly, I would also be able to do:
>mount -t smbfs username@remote.computer.com:~ 
>/home/username/net/remote_computer
>mount -t webdav username@remote.computer.com:~ 
>/home/username/net/remote_computer
>mount -t ftp username@remote.computer.com:~
>/home/username/net/remote_computer
>
>Advantages of LODNA:
>
>1) Network locations would be fixed in the directory
>tree, rather than float around in a DE abstraction
>like fish:/ .
>2) Remote files would be accessible by all
>applications, even the shell.
>3) LODNA would be independent of Desktop Environments
>(although if present, they could provide GUIs for
>things that could otherwise be done from the command
>line). For example, KDE could use its existing "Add a
>Network Folder" wizard to help users mount network
>locations.
>4) The user could give or deny other local users
>access to his remote locations simply by setting the
>permissions of the mount point (eg. chmod 700
>/home/username/net/remote_computer).
>5) LODNA would help users who want to access files on
>their Local Area Network but who don't know the exact
>name or IP address of the destination computer. Such
>users could use KDE's Konqueror File Manager
>(http://www.konqueror.org/) with the Smb4k
>(http://smb4k.berlios.de/) plugin to discover all the
>samba servers on their LAN. They could then simply
>right-click on a  server/share and select "Mount",
>which would take them to the "Add a Network Folder"
>wizard.
>6) LODNA would combine the transparency of NFS with
>the flexibility of SSH/SMB/WebDav/FTP.
>7) LODNA would allow users to build and manage their
>own VPN client.
>
>CONCLUSION:
>
>Linux On-Demand Network Access (LODNA) is a proposed
>kernel-based method for accessing network locations.
>It would provide transparent, unified network access
>to all applications and pave the way for highly
>intuitive GUIs for managing diverse networks. As a
>built-in, multi-protocol VPN client, LODNA would
>greatly help employees who work from home, and be a
>much needed step towards making Linux viable on the
>desktop.
>
>For now, LODNA is only a concept, but the pieces
>needed to make it happen already exist - they just
>need to be integrated into the kernel, perhaps as a
>ReiserFS 4 plugin or by another method. I welcome your
>suggestions!
>
>Cheers,
>Vlad
>
>
>		
>____________________________________________________
>Sell on Yahoo! Auctions – no fees. Bid on great items.  
>http://auctions.yahoo.com/
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

