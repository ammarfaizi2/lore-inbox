Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVDGCgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVDGCgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 22:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVDGCgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 22:36:31 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:62706 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262392AbVDGCgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 22:36:25 -0400
Message-ID: <42549CA8.8050104@austin.rr.com>
Date: Wed, 06 Apr 2005 21:36:24 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: uid of person who mounts and user unmount
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

smbfs displays the uid of the mounter in show_mounts (viewable in 
/proc/mounts ) and this would allow a setuid unmount program to check 
the uid of the mounter via /proc/mounts (there is also an ioctl which 
does something similar).

Is this approach secure enough?

I slightly prefer an approach in which a program that wishes to check if 
the current->uid matches that of the mounter (or that uid which was 
specified on the mount command option and which was saved in the fs's 
superblock) simply calls an empty ioctl to the fs - which returns yes/no 
(the uid of the current process, matches the uid of the process that did 
the mount or not, this requires the fs to save the uid at mount but 
presumably has the disadvantage of opening a file to get a handle that 
you can use for the ioctl).

There are other ways to achieve somewhat similar effect - of allowing 
user mounts and unmounts via fstab - but I have had users request a way 
to do this via a setuid filesystem specific umount util.

Is there a security issue with displaying the uid of the mounter via the 
fs's show_mounts (shows up in /proc/mounts)
