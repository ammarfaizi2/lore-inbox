Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276834AbRJCCR7>; Tue, 2 Oct 2001 22:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276836AbRJCCRu>; Tue, 2 Oct 2001 22:17:50 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:52182 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S276834AbRJCCRi>; Tue, 2 Oct 2001 22:17:38 -0400
Date: Tue, 2 Oct 2001 22:18:08 -0400 (EDT)
From: Alex Larsson <alexl@redhat.com>
X-X-Sender: <alexl@devserv.devel.redhat.com>
To: <linux-kernel@vger.kernel.org>
cc: <alexl@redhat.com>
Subject: Directory notification problem
Message-ID: <Pine.LNX.4.33.0110022206100.29931-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I discovered a problem with the dnotify API while fixing a FAM bug today.

The problem occurs when you want to watch a file in a directory, and that 
file is changed several times in the same second. When I get the directory 
notify signal on the directory I need to stat the file to see if the 
change was actually in the file. If the file already changed in the 
current second the stat() result will be identical to the previous stat() 
call, since the resolution of mtime and ctime is one second. 

This leads to missed notifications, leaving clients (such as Nautilus or 
Konqueror) displaying an state not representing the current state.

The only userspace solutions I see is to delay all change notifications to 
the end of the second, so that clients always read the correct state. This 
is somewhat countrary to the idea of FAM though, as it does not give 
instant feedback.

Is there any possibility of extending struct stat with a generation 
counter? Or is there another solution to this problem?

/ Alex

Please CC any reply to me, i'm not on the list.






