Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbVKVRSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbVKVRSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbVKVRSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:18:06 -0500
Received: from p-mail2.rd.francetelecom.com ([195.101.245.16]:59149 "EHLO
	p-mail2.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S965019AbVKVRSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:18:03 -0500
Message-ID: <438352C4.3060001@francetelecom.com>
Date: Tue, 22 Nov 2005 18:17:56 +0100
From: VALETTE Eric RD-MAPS-REN <eric2.valette@francetelecom.com>
Reply-To: eric2.valette@francetelecom.com
Organization: Frnace Telecom R&D
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve French <smfrench@austin.rr.com>
CC: linux-kernel@vger.kernel.org, linux-cifs-client@lists.samba.org
Subject: Re: CIFS emulated mode bits
References: <4381EFF3.8000201@austin.rr.com> 	<4382032D.4080606@francetelecom.com> <43823CB3.8090303@austin.rr.com> 	<438323AC.2090102@francetelecom.com> <438347B0.9020602@austin.rr.com>
In-Reply-To: <438347B0.9020602@austin.rr.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2005 17:17:56.0912 (UTC) FILETIME=[AE51E300:01C5EF88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French wrote:

> To explain what is going on, here is some obvious background.    Windows
> uses a rich ACL model locally and over the network via CIFS (other
> protocols such as NFSv4 now do something similar) and Windows of course
> does not have really have or need Unix mode bits ... and the server
> (unlike Samba and those that implement the standard SNIA CIFS Unix
> extensions) does not return emulated mode bits (although it does locally
> in Windows "services for Unix" and of course also cygwin does something
> similar) ... so the cifs  client has to approximate mode bits.    If the
> client makes an incorrect approximation you can get access denied on a
> client side permission check.   Of course some would argue that for
> clients that are running as single user desktop clients the client does
> not need to do perm checks (the server does ACL checks) so just turn off
> the client permission checks - that is why the "noperm" option is
> available on the cifs client.
> 
> So the choices today are:
> 
> 1) Turn off mode bit checking (on the client) on a particular cifs mount
> (noperm mount option)

I could live with that altthough there is something I would like to
clarify (see below).

> or
> 2) pass in a default mode and uid or gid on the cifs mount that matches
> what you want (otherwise cifs will use the uid of the mounter, and a
> default mode).  Although cifs caches the mode bits in the inode if they
> are modified by an app on the client e.g. via chmod (while the inode
> stays in memory on the client) - for querying (lookups/stat) on existing
> files cifs can only use the +R dos attribute to distinguish when to
> return something other than 0777 (or the default).

If you put something is a /etc/fstab, that will be mounted by init
scripts, the uid/gid credentials attached with the mount request is of
course root.root (which is wht is see with "ls file" BTW). 'I'm just
surprised that with the perm option, my identity seems to change, on the
client side, between the two commands : if the file is marked locally as
created by root.root, I should still be root.root for the next command!

Side question for my understanding : when I specify  the credentials
(like I did) (credentials=/home/ceva6380/.sambaShareId) and that the
user name exist in the local /etc/passwd, I'm surprised to have to add
the uid=getuidfrom(name) again. I admit, user name on the windows server
may be different than on the client, but to put a valid uid/gid it must
exist on the client system anyway and be consistent with the current
user identity no?


-- eric
