Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278712AbRJZPs0>; Fri, 26 Oct 2001 11:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278666AbRJZPsR>; Fri, 26 Oct 2001 11:48:17 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:49828 "EHLO
	mjc.meridian.redhat.com") by vger.kernel.org with ESMTP
	id <S278646AbRJZPsG>; Fri, 26 Oct 2001 11:48:06 -0400
Date: Fri, 26 Oct 2001 11:48:42 -0400 (EDT)
From: Alex Larsson <alexl@redhat.com>
X-X-Sender: <alexl@mjc.meridian.redhat.com>
To: <linux-kernel@vger.kernel.org>
Subject: dnotify semantics
Message-ID: <Pine.LNX.4.33.0110261139190.10309-100000@mjc.meridian.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when monitoring a directory using dnotify you get notifications 
whenever some file in the directory changes, or is added/removed. But when 
the directory itself is changed (i.e. chmoded) you don't get any notification.

Reading Documentation/dnotify.txt it does not seem clear what the expected 
behaviour is, it says:

 The intention of directory notification is to allow user applications
 to be notified when a directory, or any of the files in it, are changed.

But then:

        DN_ACCESS       A file in the directory was accessed (read)
        DN_MODIFY       A file in the directory was modified (write,truncate)
        DN_CREATE       A file was created in the directory
        DN_DELETE       A file was unlinked from directory
        DN_RENAME       A file in the directory was renamed
        DN_ATTRIB       A file in the directory had its attributes
                        changed (chmod,chown)

 (i.e. no directory was changed event)

This is somewhat of a problem for me, implementing fam using dnotify. When 
monitoring a directory i need to send events also when the directory 
changes. The only way this can be done with the current semantics would be 
to monitor both the directory and it's parent. Unfortunately this could
create many spurious events/stats, and is not possible to do for the root 
directory.

Is there any chance that we can get a change in semantics so that changes 
to the directory itself also causes a notification?

/ Alex

(Please CC me, I'm not on the linux-kernel list)

