Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVBUPfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVBUPfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 10:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVBUPfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 10:35:53 -0500
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:23243 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261996AbVBUPfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 10:35:47 -0500
Message-ID: <4219FFD0.8050008@austin.rr.com>
Date: Mon, 21 Feb 2005 09:35:44 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Cameron Harris <thecwin@gmail.com>, akpm@osld.org
Subject: Re: cifs connection loss hangs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 >Being a wireless user i experience the occasional connection loss due
 >to walking out of range or something, recently after starting to use
 >cifs mounts instead of smbfs, I've noticed that stuff tends to break
 > if i lose connection.

cifs does support reconnection after tcp session drops (including 
reattaching to the server shares and reopening open files, rewriting 
cached data).

What kernel version ("cat /proc/version") or cifs vfs version ("modinfo 
/lib/modules/<kernel ver>/kernel/fs/cifs/cifs.ko) are you running?

2.6.10 includes one fix for a race in the cifs reconnection logic (which 
is included in cifs version 1.27 or later) and there was an earlier (and 
more important) reconnection fix in cifs version 1.10 (I think that came 
in mainline about at kernel version 2.6.6).

There are test patches (or in some cases a copy of the fs/cifs 
directory) available for a few of the older but common kernels (SLES9, 
SuseWorkstation 9.2, FC3 etc.) at 
http://us1.samba.org/samba/ftp/cifs-cvs which include up to 2.6.10 level.

Note that you can view the state of cifs connections by "cat 
/proc/fs/cifs/DebugData" (also interesting is "cat /proc/fs/cifs/Stats") 
which will show the cifs tcp sessions, smb sessions and tree connection 
(mount) and whether they need reconnection - it also shows the state of 
any pending [cifs] operations on the network.
